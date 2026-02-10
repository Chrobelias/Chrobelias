(** Simplification based on alpha-equivalence *)

module M (Enc : Nfa.Encoding) : sig
  val simplify : Ir.M(Enc).t -> Ir.M(Enc).t
end
