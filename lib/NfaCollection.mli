(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

type varpos = int

module Map = Base.Map.Poly

module type Type = sig
  type t
  type v

  val n : unit -> t
  val z : unit -> t
  val power_of_two : int -> t
  val eq : (Ir.atom, int) Map.t -> (Ir.atom, Z.t) Map.t -> Z.t -> t
  val neq : (Ir.atom, int) Map.t -> (Ir.atom, Z.t) Map.t -> Z.t -> t
  val leq : (Ir.atom, int) Map.t -> (Ir.atom, Z.t) Map.t -> Z.t -> t
  val strlen : alpha:v list option -> dest:int -> src:int -> unit -> t
  val base : int
end

module type NatType = sig
  include Type

  val div_in_pow : varpos -> int -> int -> t
  val pow_of_log_var : int -> int -> t
end

module Msb : sig
  include Type with type t = Nfa.Msb(Nfa.Bv).t and type v = bool
end

module MsbStr (Enc : Nfa.Encoding) : sig
  include Type with type t = Nfa.Msb(Nfa.Str(Enc)).t and type v = Nfa.Str(Enc).u
end

module MsbStrBv (Enc : Nfa.Encoding) : sig
  include Type with type t = Nfa.Msb(Nfa.StrBv(Enc)).t and type v = Nfa.StrBv(Enc).u
end

module MsbNat : sig
  include NatType with type t = Nfa.MsbNat(Nfa.Bv).t and type v = bool
end

module MsbNatStr (Enc : Nfa.Encoding) : sig
  include NatType with type t = Nfa.MsbNat(Nfa.Str(Enc)).t and type v = Nfa.Str(Enc).u
end

module MsbNatStrBv (Enc : Nfa.Encoding) : sig
  include NatType with type t = Nfa.MsbNat(Nfa.StrBv(Enc)).t and type v = Nfa.StrBv(Enc).u
end

module Lsb : sig
  include NatType with type t = Nfa.Lsb(Nfa.Bv).t and type v = bool
end

module LsbStr (Enc : Nfa.Encoding) : sig
  include NatType with type t = Nfa.Lsb(Nfa.Str(Enc)).t and type v = Nfa.Str(Enc).u
end

module LsbStrBv (Enc : Nfa.Encoding) : sig
  include NatType with type t = Nfa.Lsb(Nfa.StrBv(Enc)).t and type v = Nfa.StrBv(Enc).u
end
