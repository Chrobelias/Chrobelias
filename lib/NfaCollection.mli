(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

type varpos = int

module Map = Base.Map.Poly

module type Type = sig
  type t

  val n : unit -> t
  val z : unit -> t
  val power_of_two : int -> t
  val eq : ('a, int) Map.t -> ('a, Z.t) Map.t -> Z.t -> t
  val leq : ('a, int) Map.t -> ('a, Z.t) Map.t -> Z.t -> t
  val strlen_post : t -> dest:int -> src:int -> t
  val stoi_post : t -> dest:int -> src:int -> t
  val seq_post : t -> dest:int -> src:int -> t
  val strlen : ?alpha:char list -> dest:int -> src:int -> unit -> t
  val stoi : dest:int -> src:int -> t
  val itos : dest:int -> src:int -> t
  val seq : ?alpha:char list -> dest:int -> src:int -> unit -> t
  val sprefixof : ?alpha:char list -> dest:int -> src:int -> unit -> t
  val base : int
end

module type NatType = sig
  include Type

  val div_in_pow : varpos -> int -> int -> t
  val pow_of_log_var : int -> int -> t
end

module Lsb : sig
  include NatType with type t = Nfa.Lsb(Nfa.Bv).t
end

module Msb : sig
  include Type with type t = Nfa.Msb(Nfa.Bv).t
end

module MsbNat : sig
  include NatType with type t = Nfa.MsbNat(Nfa.Bv).t
end

module Str : sig
  include NatType with type t = Nfa.Lsb(Nfa.Str).t
end
