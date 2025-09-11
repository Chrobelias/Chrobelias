(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

module Map = Base.Map.Poly

val proof : Ir.t -> [ `Sat | `Unsat | `Unknown of Ir.t ]
val get_model : Ir.t -> (Ir.atom, [ `Int of Z.t | `Str of string ]) Map.t option
