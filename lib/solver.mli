(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

module Map = Base.Map.Poly

module M(Enc : Nfa.Encoding) : sig
  val check_sat
    :  Ir.M(Enc).t
    -> [ `Sat of
           (Ir.M(Enc).atom, [ `Str | `Int ]) Map.t
           -> (Ir.M(Enc).model, [ `Too_long | `No_model ]) Result.t
       | `Unsat
       | `Unknown of Ir.M(Enc).t
       ]

  (* TODO(Kakadu): Move somewhere else... *)
  val is_internal : string -> bool
end
