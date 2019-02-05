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

type _ typ += DeribitLiquidationPrice : float typ
module DeribitLiquidationPrice = Make(struct
    type t = float [@@deriving sexp]
    let t = DeribitLiquidationPrice
    let pp = Format.pp_print_float
    let parse = float_of_string_opt
    let tag = 100_088
    let name = "DeribitLiquidationPrice"
    let eq :
      type a b. a typ -> b typ -> (a, b) eq option = fun a b ->
      match a, b with
      | DeribitLiquidationPrice, DeribitLiquidationPrice -> Some Eq
      | _ -> None
  end)
let () = register_field (module DeribitLiquidationPrice)

type _ typ += DeribitBTCSize : float typ
module DeribitBTCSize = Make(struct
    type t = float [@@deriving sexp]
    let t = DeribitBTCSize
    let pp = Format.pp_print_float
    let parse = float_of_string_opt
    let tag = 100_089
    let name = "DeribitBTCSize"
    let eq :
      type a b. a typ -> b typ -> (a, b) eq option = fun a b ->
      match a, b with
      | DeribitBTCSize, DeribitBTCSize -> Some Eq
      | _ -> None
  end)
let () = register_field (module DeribitBTCSize)

type _ typ += DeribitUserEquity : float typ
module DeribitUserEquity = Make(struct
    type t = float [@@deriving sexp]
    let t = DeribitUserEquity
    let pp = Format.pp_print_float
    let parse = float_of_string_opt
    let tag = 100_001
    let name = "DeribitUserEquity"
    let eq :
      type a b. a typ -> b typ -> (a, b) eq option = fun a b ->
      match a, b with
      | DeribitUserEquity, DeribitUserEquity -> Some Eq
      | _ -> None
  end)
let () = register_field (module DeribitUserEquity)

type _ typ += DeribitUserBalance : float typ
module DeribitUserBalance = Make(struct
    type t = float [@@deriving sexp]
    let t = DeribitUserBalance
    let pp = Format.pp_print_float
    let parse = float_of_string_opt
    let tag = 100_002
    let name = "DeribitUserBalance"
    let eq :
      type a b. a typ -> b typ -> (a, b) eq option = fun a b ->
      match a, b with
      | DeribitUserBalance, DeribitUserBalance -> Some Eq
      | _ -> None
  end)
let () = register_field (module DeribitUserBalance)

type _ typ += DeribitInitialMargin : float typ
module DeribitInitialMargin = Make(struct
    type t = float [@@deriving sexp]
    let t = DeribitInitialMargin
    let pp = Format.pp_print_float
    let parse = float_of_string_opt
    let tag = 100_003
    let name = "DeribitInitialMargin"
    let eq :
      type a b. a typ -> b typ -> (a, b) eq option = fun a b ->
      match a, b with
      | DeribitInitialMargin, DeribitInitialMargin -> Some Eq
      | _ -> None
  end)
let () = register_field (module DeribitInitialMargin)

type _ typ += DeribitMaintenanceMargin : float typ
module DeribitMaintenanceMargin = Make(struct
    type t = float [@@deriving sexp]
    let t = DeribitMaintenanceMargin
    let pp = Format.pp_print_float
    let parse = float_of_string_opt
    let tag = 100_004
    let name = "DeribitMaintenanceMargin"
    let eq :
      type a b. a typ -> b typ -> (a, b) eq option = fun a b ->
      match a, b with
      | DeribitMaintenanceMargin, DeribitMaintenanceMargin -> Some Eq
      | _ -> None
  end)
let () = register_field (module DeribitMaintenanceMargin)

type _ typ += DeribitUnrealizedPl : float typ
module DeribitUnrealizedPl = Make(struct
    type t = float [@@deriving sexp]
    let t = DeribitUnrealizedPl
    let pp = Format.pp_print_float
    let parse = float_of_string_opt
    let tag = 100_005
    let name = "DeribitUnrealizedPl"
    let eq :
      type a b. a typ -> b typ -> (a, b) eq option = fun a b ->
      match a, b with
      | DeribitUnrealizedPl, DeribitUnrealizedPl -> Some Eq
      | _ -> None
  end)
let () = register_field (module DeribitUnrealizedPl)

type _ typ += DeribitRealizedPl : float typ
module DeribitRealizedPl = Make(struct
    type t = float [@@deriving sexp]
    let t = DeribitRealizedPl
    let pp = Format.pp_print_float
    let parse = float_of_string_opt
    let tag = 100_006
    let name = "DeribitRealizedPl"
    let eq :
      type a b. a typ -> b typ -> (a, b) eq option = fun a b ->
      match a, b with
      | DeribitRealizedPl, DeribitRealizedPl -> Some Eq
      | _ -> None
  end)
let () = register_field (module DeribitRealizedPl)

type _ typ += DeribitCustom11 : float typ
module DeribitCustom11 = Make(struct
    type t = float [@@deriving sexp]
    let t = DeribitCustom11
    let pp = Format.pp_print_float
    let parse = float_of_string_opt
    let tag = 100_011
    let name = "DeribitCustom11"
    let eq :
      type a b. a typ -> b typ -> (a, b) eq option = fun a b ->
      match a, b with
      | DeribitCustom11, DeribitCustom11 -> Some Eq
      | _ -> None
  end)
let () = register_field (module DeribitCustom11)

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
