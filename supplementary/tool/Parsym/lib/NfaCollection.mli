type varpos = int

module Map = Base.Map.Poly

module type Type = sig
  type t
  type v

  val n : unit -> t
  val z : unit -> t
  val power_of_base : int -> t
  val buchi : int -> int -> t
  val eq : (Ir.atom, int) Map.t -> (Ir.atom, Z.t) Map.t -> Z.t -> t
  val neq : (Ir.atom, int) Map.t -> (Ir.atom, Z.t) Map.t -> Z.t -> t
  val leq : (Ir.atom, int) Map.t -> (Ir.atom, Z.t) Map.t -> Z.t -> t
end

module LsbStr : sig
  include Type with type t = Nfa.Lsb(Nfa.Str).t and type v = Nfa.Str.u
end

module MsbSym : sig
  include Type with type t = Nfa.Symbolic(Nfa.Sym).t and type v = Nfa.Sym.u
end

module MsbPar : sig
  include Type with type t = Nfa.Parametric(Nfa.Sym).t and type v = Nfa.Sym.u
end
