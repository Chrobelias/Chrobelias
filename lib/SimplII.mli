type relop =
  | Leq
  | Eq

val subst : Env.t -> Ast.t -> Ast.t
val subst_term : Env.t -> 'a Ast.Eia.term -> 'a Ast.Eia.term

val run_basic_simplify
  :  ?env:Env.t
  -> Ast.t
  -> [ `Sat of string * Env.t | `Unsat | `Unknown of Ast.t * Env.t ]
