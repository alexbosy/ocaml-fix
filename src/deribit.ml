open Sexplib.Std
open Fix
open Fixtypes
open Field

type _ typ += CancelOnDisconnect : bool typ
module CancelOnDisconnect = Make(struct
    type t = bool [@@deriving sexp]
    let t = CancelOnDisconnect
    let pp = YesOrNo.pp
    let parse = YesOrNo.parse
    let tag = 9001
    let name = "CancelOnDisconnect"
  let eq :
    type a b. a typ -> b typ -> (a, b) eq option = fun a b ->
    match a, b with
    | CancelOnDisconnect, CancelOnDisconnect -> Some Eq
    | _ -> None
end)
let () = register_field (module CancelOnDisconnect)

type _ typ += InstrumentPricePrecision : int typ
module InstrumentPricePrecision = Make(struct
    type t = int [@@deriving sexp]
    let t = InstrumentPricePrecision
    let pp = Format.pp_print_int
    let parse = int_of_string_opt
    let tag = 2576
    let name = "InstrumentPricePrecision"
    let eq :
      type a b. a typ -> b typ -> (a, b) eq option = fun a b ->
      match a, b with
      | InstrumentPricePrecision, InstrumentPricePrecision -> Some Eq
      | _ -> None
  end)
let () = register_field (module InstrumentPricePrecision)

type _ typ += DeribitTradeAmount : int typ
module DeribitTradeAmount = Make(struct
    type t = int [@@deriving sexp]
    let t = DeribitTradeAmount
    let pp = Format.pp_print_int
    let parse = int_of_string_opt
    let tag = 100_007
    let name = "DeribitTradeAmount"
    let eq :
      type a b. a typ -> b typ -> (a, b) eq option = fun a b ->
      match a, b with
      | DeribitTradeAmount, DeribitTradeAmount -> Some Eq
      | _ -> None
  end)
let () = register_field (module DeribitTradeAmount)

type _ typ += DeribitTradeID : int typ
module DeribitTradeID = Make(struct
    type t = int [@@deriving sexp]
    let t = DeribitTradeID
    let pp = Format.pp_print_int
    let parse = int_of_string_opt
    let tag = 100_009
    let name = "DeribitTradeID"
    let eq :
      type a b. a typ -> b typ -> (a, b) eq option = fun a b ->
      match a, b with
      | DeribitTradeID, DeribitTradeID -> Some Eq
      | _ -> None
  end)
let () = register_field (module DeribitTradeID)

type _ typ += DeribitSinceTimestamp : Ptime.t typ
module DeribitSinceTimestamp = Make(struct
    type t = Ptime.t [@@deriving sexp]
    let t = DeribitSinceTimestamp
    let pp ppf t =
      Format.fprintf ppf "%.0f" (Ptime.to_float_s t *. 1e3)
    let parse s =
      match float_of_string_opt s with
      | None -> None
      | Some ts -> Ptime.of_float_s (ts /. 1e3)
    let tag = 100_008
    let name = "DeribitSinceTimestamp"
    let eq :
      type a b. a typ -> b typ -> (a, b) eq option = fun a b ->
      match a, b with
      | DeribitSinceTimestamp, DeribitSinceTimestamp -> Some Eq
      | _ -> None
  end)
let () = register_field (module DeribitSinceTimestamp)

type _ typ += TradeVolume24h : float typ
module TradeVolume24h = Make(struct
    type t = float [@@deriving sexp]
    let t = TradeVolume24h
    let pp = Format.pp_print_float
    let parse = float_of_string_opt
    let tag = 100_087
    let name = "TradeVolume24h"
    let eq :
      type a b. a typ -> b typ -> (a, b) eq option = fun a b ->
      match a, b with
      | TradeVolume24h, TradeVolume24h -> Some Eq
      | _ -> None
  end)
let () = register_field (module TradeVolume24h)

let sid = "ocaml-fix"
let tid = "DERIBITSERVER"

let logon_fields
    ?(cancel_on_disconnect=true)
    ~username
    ~secret
    ~ts =
  let b64rand =
    B64.encode (Monocypher.Rand.gen 32 |> Bigstring.to_string) in
  let rawdata =
    Format.asprintf "%.0f.%s" (Ptime.to_float_s ts *. 1e3) b64rand in
  let password =
    B64.encode Digestif.SHA256.(digest_string (rawdata ^ secret) |> to_raw_string) in
  [ RawData.create rawdata ;
    Username.create username ;
    Password.create password ;
    CancelOnDisconnect.create cancel_on_disconnect ;
  ]
