(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

module Map = Base.Map.Poly

type config =
  { mutable stop_after : [ `Simpl | `Solving ]
  ; mutable dump_simpl : bool
  ; mutable input_file : string
  }

val config : config
val parse_args : unit -> unit
val dump : Ir.t -> string
val proof : Ir.t -> [ `Sat | `Unsat | `Unknown ]
val get_model : Ir.t -> (Ir.atom, int) Map.t option
