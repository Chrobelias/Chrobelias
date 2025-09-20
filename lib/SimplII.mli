type relop =
  | Leq
  | Eq

type error

val has_unsupported_nonlinearity : Ast.t -> (unit, Ast.Eia.term list) Result.t

module Env : sig
  type t = (string, Ast.Eia.term) Base.Map.Poly.t

  val empty : t
  val merge : t -> t -> t
  val fold : t -> init:'a -> f:(key:string -> data:Ast.Eia.term -> 'a -> 'a) -> 'a
  val length : t -> int
  val pp : Format.formatter -> t -> unit
end

val simpl
  :  ?under_mode:[ `First | `Second ]
  -> int
  -> Ast.t
  -> [> `Unknown of Ast.t
     | `Sat of string * Env.t
     | `Unsat
     | `Error of Ast.t * error list
     | `Underapprox of Ast.t list
     ]

val run_basic_simplify
  :  Ast.t
  -> [ `Sat of string * Env.t | `Unsat | `Unknown of Ast.t * Env.t ]

val run_under1 : int -> Ast.t -> [ `Sat of string | `Unknown ]
val run_under2 : Ast.t -> [ `Sat | `Underapprox of Ast.t list ]
val pp_error : Format.formatter -> error -> unit
val set_a_min : int -> unit
val set_a_max : int -> unit

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
