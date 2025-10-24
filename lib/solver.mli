(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

module Map = Base.Map.Poly

val max_longest_path : int

val check_sat
  :  Ir.t
  -> [ `Sat of (Ir.atom, [ `Str | `Int ]) Map.t -> (Ir.model, [ `Too_long ]) Result.t
     | `Unsat
     | `Unknown of Ir.t
     ]

(* TODO(Kakadu): Move somewhere else... *)
val is_internal : string -> bool
val ir_to_ast : Ir.t -> Ast.t
