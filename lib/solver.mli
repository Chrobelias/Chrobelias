(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

module Map = Base.Map.Poly

val check_sat
  :  Ir.t
  -> [ `Sat of (Ir.atom, [ `Str | `Int ]) Map.t -> Ir.model | `Unsat | `Unknown of Ir.t ]
