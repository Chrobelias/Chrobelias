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
  ; mutable simpl_alpha : bool
  ; mutable simpl_mono : bool
  ; mutable over_approx : bool
  ; mutable under_approx : int
  ; mutable input_file : string
  ; mutable logic : [ `Eia | `Str ]
  }

val config : config
val parse_args : unit -> unit
val proof : Ir.t -> [ `Sat | `Unsat | `Unknown of Ir.t ]
val get_model : Ir.t -> (Ir.atom, [ `Int of int | `Str of string ]) Map.t option
