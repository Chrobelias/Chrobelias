(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

module Map = Base.Map.Poly

type config =
  { mutable stop_after : [ `Simpl | `Solving ]
  ; mutable mode : [ `Msb | `Lsb ]
  ; mutable dump_simpl : bool
  ; mutable simpl_alpha : bool
  ; mutable simpl_mono : bool
  ; mutable over_approx : bool
  ; mutable input_file : string
  }

val config : config
val parse_args : unit -> unit
val proof : Ir.t -> [ `Sat | `Unsat | `Unknown ]
val get_model : Ir.t -> (Ir.atom, int) Map.t option
