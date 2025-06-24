(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

module Map = Base.Map.Poly

val dump : Ir.poly_atom Ir.t -> string
val proof : Ir.poly_atom Ir.t -> [ `Sat | `Unsat | `Unknown ]
val get_model : Ir.poly_atom Ir.t -> (Ir.atom, int) Map.t option
