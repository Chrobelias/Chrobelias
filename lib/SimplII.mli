type relop =
  | Leq
  | Eq

val subst : Env.t -> Ast.t -> Ast.t
val subst_term : Env.t -> 'a Ast.Eia.term -> 'a Ast.Eia.term

val arithmetize
  :  Ast.t
  -> Env.t
  -> (Ast.t
     * Env.t
     * (Ir.model -> Ast.t -> (Ast.t -> [ `Sat | `Unknown ]) -> [ `Sat | `Unknown ]) list
     * (string, Nfa.Lsb(Nfa.Str).u) Base.Map.Poly.t)
       list

val run_basic_simplify
  :  ?env:Env.t
  -> Ast.t
  -> [ `Sat of string * Env.t | `Unsat | `Unknown of Ast.t * Env.t ]
