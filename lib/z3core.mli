(** Unsat cores of length abstractions, through Z3's native core support when
    the z3 findlib package is available at build time; a stub that always gives
    up otherwise (dune selects the implementation, see lib/dune). *)

(** [check_length_core ~parts ~facts]: each part pairs a conjunct of the
    original formula with its length abstraction; the facts always hold. On
    [`Unsat] returns the (minimized) subset of original conjuncts whose
    abstractions are jointly contradictory. *)
val check_length_core
  :  parts:(Ast.t * Ast.t) list
  -> facts:Ast.t list
  -> [ `Unsat of Ast.t list | `Unknown ]
