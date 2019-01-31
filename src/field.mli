open Rresult
open Fixtypes

type (_,_) eq = Eq : ('a,'a) eq

type _ typ = ..

module type T = sig
  type t [@@deriving sexp]
  val pp : Format.formatter -> t -> unit
  val tag : int
  val name : string
end

type field =
    F : 'a typ * (module T with type t = 'a) * 'a -> field [@@deriving sexp]
type t = field

val create : 'a typ -> (module T with type t = 'a) -> 'a -> field

val pp : Format.formatter -> t -> unit
val print : t -> string
val add_to_buffer : Buffer.t -> field -> unit
val parse : string -> (t option, R.msg) result

val find : 'a typ -> field -> 'a option
val find_list : 'a typ -> field list -> 'a option

module type FIELD = sig
  type t [@@deriving sexp]
  val pp : Format.formatter -> t -> unit
  val tag : int
  val name : string
  val create : t -> field
  val find : 'a typ -> field -> 'a option
  val parse : int -> string -> field option
end

val register_field : (module FIELD) -> unit

type _ typ += MsgType : Fixtypes.MsgType.t typ
type _ typ += Account : string typ
type _ typ += CheckSum : string typ

module Account : FIELD with type t := string
module CheckSum : FIELD with type t := string
module MsgType : FIELD with type t := Fixtypes.MsgType.t
module MsgSeqNum : FIELD with type t := int
module SenderCompID : FIELD with type t := string
module TargetCompID : FIELD with type t := string
module RawData : FIELD with type t := string
module Username : FIELD with type t := string
module Password : FIELD with type t := string


