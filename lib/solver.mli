(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

module Map = Base.Map.Poly

type config =
  { mutable stop_after : [ `Simpl | `Pre_simplify | `Solving ]
  ; mutable mode : [ `Msb | `Lsb ]
  ; mutable dump_simpl : bool
  ; mutable dump_pre_simpl : bool
  ; mutable dump_ir : bool
  ; mutable pre_simpl : bool (** Simplify the AST *)
  ; mutable error_check : bool
  ; mutable simpl_alpha : bool
  ; mutable simpl_mono : bool
  ; mutable over_approx : bool
  ; mutable minimize_in_semenov : bool
  ; mutable under_approx : int
  ; mutable under_mode : [ `First | `Second ]
  ; mutable input_file : string
  ; mutable logic : [ `Eia | `Str ]
  ; mutable with_check_sat : bool
  }

val config : config
val is_under2_enabled : unit -> bool
val parse_args : unit -> unit
val check_sat : Ir.t -> [ `Sat of unit -> Ir.model | `Unsat | `Unknown of Ir.t ]
