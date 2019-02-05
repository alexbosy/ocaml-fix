open Core.Std
open Async.Std
open Log.Global

open Bs_devkit.Core
open Coinbase

let history = ref Int.Map.empty

let host = "fix.gdax.com"
let port = 4198

let send_msg w mk_msg =
  let seqnum, msg = mk_msg () in
  history := Int.Map.add !history ~key:seqnum ~data:msg;
  Pipe.write w msg

let rec on_server_msg w msg = match msg.Fix.typ with
  | Logout ->
    (* Immediately send a logout msg and exit. *)
    send_msg w logout >>= fun () ->
    Shutdown.exit 0
  | TestRequest -> begin match Fix.Tag.Map.find Fix.Tag.(S TestReqID) msg.fields with
      | exception Not_found -> Deferred.unit
      | testreqid ->
        (* Immediately send a heartbeat with the same seqnum. *)
        send_msg w (heartbeat ~testreqid)
    end
  | ResendRequest -> Deferred.unit
  | _ -> Deferred.unit

let rec heartbeat_loop w period =
  after @@ Time.Span.of_string (string_of_int period ^ "s") >>= fun () ->
  send_msg w heartbeat >>= fun () ->
  heartbeat_loop w period

let on_client_cmd ~secret ~passphrase w words =
  let words = String.split ~on:' ' @@ String.chop_suffix_exn words ~suffix:"\n" in
  match List.hd_exn words with
  | "TESTREQ" -> send_msg w (fun () -> testreq @@ Uuid.(create () |> to_string))
  | "BUY" ->
    let symbol = List.nth_exn words 1 in
    let p = List.nth_exn words 2 |> Float.of_string in
    let v = List.nth_exn words 3 |> Float.of_string in
    send_msg w
      (new_order
         ~uuid:Uuid.(create () |> to_string)
         ~symbol ~p ~v ~side:Buy)
  | "SELL" ->
    let symbol = List.nth_exn words 1 in
    let p = List.nth_exn words 2 |> Float.of_string in
    let v = List.nth_exn words 3 |> Float.of_string in
    send_msg w
      (new_order
         ~uuid:Uuid.(create () |> to_string)
         ~symbol ~p ~v ~side:Sell)
  | command ->
    info "Unsupported command: %s" command;
    Deferred.unit

let main cfg ca_file loglevel () =
  Option.iter loglevel ~f:(Fn.compose set_level loglevel_of_int);
  let cfg = Yojson.Safe.from_file cfg |> Cfg.of_yojson |> Result.ok_or_failwith in
  let { Cfg.key; secret; passphrase } = List.Assoc.find_exn cfg "GDAX" in
  init key;
  let run () =
    Fix_async.with_connection ~log:(Lazy.force log) ~tls:(`CAFile ca_file) ~host ~port () >>= fun (r, w) ->
    Signal.(handle terminating ~f:(fun _ -> don't_wait_for @@ send_msg w logout));
    info "Connected to Coinbase";
    send_msg w (logon ~secret ~passphrase) >>= fun () ->
    Deferred.any [
      Pipe.iter r ~f:(on_server_msg w);
      Pipe.iter Reader.(stdin |> Lazy.force |> pipe) ~f:(on_client_cmd ~secret ~passphrase w);
      heartbeat_loop w 30;
      Pipe.closed w
    ] >>= fun () ->
    send_msg w logout >>= fun () ->
    Deferred.never ()
  in
  don't_wait_for @@ run ();
  never_returns @@ Scheduler.go ()

let command =
  let default_cfg = Filename.concat (Option.value_exn (Sys.getenv "HOME")) ".virtu" in
  let spec =
    let open Command.Spec in
    empty
    +> flag "-cfg" (optional_with_default default_cfg string) ~doc:"path Filepath of config file (default: ~/.virtu)"
    +> flag "-ca-file" (optional_with_default "fix.gdax.com.pem" string) ~doc:"path Filepath of CA certificate (default: fix.gdax.com.pem)"
    +> flag "-loglevel" (optional int) ~doc:"1-3 loglevel"

  in
  Command.basic ~summary:"Coinbase test shell" spec main

let () = Command.run command