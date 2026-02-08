module M (Enc : Nfa.Encoding) : sig
  type relop =
    | Leq
    | Eq

  type error

  val has_unsupported_nonlinearity
    :  Ast.M(Enc).t
    -> (unit, Z.t Ast.M(Enc).Eia.term list) Result.t

  val subst : Env.t -> Ast.M(Enc).t -> Ast.M(Enc).t
  val subst_term : Env.t -> 'a Ast.M(Enc).Eia.term -> 'a Ast.M(Enc).Eia.term

  (** Independent pre-simplifications. Not necessary for the solver. **)
  val simpl
    :  int
    -> Ast.M(Enc).t
    -> [> `Unknown of Ast.M(Enc).t
       | `Sat of string * Env.t
       | `Unsat
       | `Error of Ast.M(Enc).t * error list
       | `Underapprox of Ast.M(Enc).t list
       ]

  val arithmetize
    :  Ast.M(Enc).t
    -> [ `Sat of string * Env.t
       | `Unsat
       | `Unknown of
           (Ast.M(Enc).t
           * (Ir.model -> [ `Sat | `Unknown ]) list
           * (string, Nfa.Lsb(Nfa.Str).u) Base.Map.Poly.t)
             list
       ]

  val run_basic_simplify
    :  Ast.M(Enc).t
    -> [ `Sat of string * Env.t | `Unsat | `Unknown of Ast.M(Enc).t * Env.t ]

  val run_under2 : Env.t -> Ast.M(Enc).t -> [ `Sat | `Underapprox of Ast.M(Enc).t list ]
  val check_nia : Ast.M(Enc).t -> [ `Sat | `Unsat | `Unknown ]
  val pp_error : Format.formatter -> error -> unit
end

(* val rewrite_len : Ast.t -> Ast.t *)

(** Underapproximation 2 related functions *)

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
