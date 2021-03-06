(*---------------------------------------------------------------------------
   Copyright (c) 2019 Vincent Bernardoff. All rights reserved.
   Distributed under the ISC license, see terms at the end of the file.
  ---------------------------------------------------------------------------*)

open Core_kernel
open Async
open Fix

val connect :
  Uri.t ->
  (t Pipe.Reader.t * t Pipe.Writer.t) Deferred.t

val with_connection :
  Uri.t ->
  f:(t Pipe.Reader.t -> t Pipe.Writer.t -> 'a Deferred.t) ->
  'a Deferred.t

val connect_ez :
  ?history_size:int ->
  ?heartbeat:Time_ns.Span.t ->
  ?logon_fields:Field.t list ->
  ?logon_ts:Ptime.t ->
  sid:string ->
  tid:string ->
  version:Fixtypes.Version.t ->
  Uri.t ->
  (unit Deferred.t * Fix.t Pipe.Reader.t * Fix.t Pipe.Writer.t) Deferred.t

val with_connection_ez :
  ?history_size:int ->
  ?heartbeat:Time_ns.Span.t ->
  ?logon_fields:Field.t list ->
  ?logon_ts:Ptime.t ->
  sid:string ->
  tid:string ->
  version:Fixtypes.Version.t ->
  Uri.t ->
  f:(closed:unit Deferred.t ->
     t Pipe.Reader.t ->
     t Pipe.Writer.t -> 'a Deferred.t) ->
  'a Deferred.t

(*---------------------------------------------------------------------------
   Copyright (c) 2019 Vincent Bernardoff

   Permission to use, copy, modify, and/or distribute this software for any
   purpose with or without fee is hereby granted, provided that the above
   copyright notice and this permission notice appear in all copies.

   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
   WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
   MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
   ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  ---------------------------------------------------------------------------*)
