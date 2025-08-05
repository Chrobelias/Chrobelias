(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

type varpos = int

module Map = Base.Map.Poly

module type Type = sig
  type t

  val add : lhs:varpos -> rhs:varpos -> res:varpos -> t
  val eq_const : varpos -> int -> t
  val n : unit -> t
  val z : unit -> t
  val geq : varpos -> varpos -> t
  val lt : varpos -> varpos -> t
  val gt : varpos -> varpos -> t
  val power_of_two : int -> t
  val eq : ('a, int) Map.t -> ('a, int) Map.t -> int -> t
  val leq : ('a, int) Map.t -> ('a, int) Map.t -> int -> t
end

module type NatType = sig
  include Type

  val torename : varpos -> int -> int -> t
  val torename2 : int -> int -> t
  val mul : res:varpos -> lhs:int -> rhs:varpos -> t
end

module Lsb : sig
  include NatType with type t = Nfa.Lsb.t
end

module Msb : sig
  include Type with type t = Nfa.Msb.t
end

module MsbNat : sig
  include NatType with type t = Nfa.MsbNat.t
end
