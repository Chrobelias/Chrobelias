type relop =
  | Leq
  | Eq

val simpl : Ast.t -> [> `Unknown of Ast.t ]
