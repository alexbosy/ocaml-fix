open Fix_intf

val msgname_of_string : string -> msgname option

module IntMap : Map.S with type key = int

type msg = string IntMap.t

val show_msg : msg -> string

val field_of_string : string -> int * string
val string_of_field : int -> string -> string

val body_length : msg -> int

val msg_maker : ?major:int -> ?minor:int ->
  sendercompid:string ->
  targetcompid:string -> unit ->
  (string -> (int * string) list -> int * msg)

val string_of_msg : msg -> string
val read_msg : bytes -> pos:int -> len:int -> msg
val write_msg : bytes -> pos:int -> msg -> unit
