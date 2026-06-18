type relop =
  | Leq
  | Eq

val run_basic_simplify
  :  ?env:Env.t
  -> Ast.t
  -> [ `Sat of string * Env.t | `Unsat | `Unknown of Ast.t * Env.t ]

val subst_term : Env.t -> 'a Ast.RLia.term -> 'a Ast.RLia.term
