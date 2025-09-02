type relop =
  | Leq
  | Eq

type error

type verdict =
  [ `Sat of string
  | `Unsat of string
  | `Error of Ast.t * error list
  | `Under of Ast.t * Ast.t list (** In underapprox. we should look only for SAT *)
  | `Unknown of Ast.t
  ]

val simpl : int -> Ast.t -> verdict
val pp_error : Format.formatter -> error -> unit

(* TODO(Kakadu): Hash-consing of AST without loss of pattern matching *)

(* TODO(Kakadu): More simplifications
  - algebraic: 8x + y + x ~~> 9x + y
  - bound analysis: (and (<= x 5) (<= x 10)) ~~> (<= x 5)
*)

(* TODO: Under/over-approximations.
   Simplification function should return a list of approximated ASTs *)

(* TODO: monotonicity  *)
(* TODO: alpha-equivalence *)
(* TODO: Zarith (issue #89) *)
(* TODO: Chineese Underapprox (issue #92)
    (50 <= 2^x <= 150) ~~> (= x 6) \/ (= x 7)
*)
