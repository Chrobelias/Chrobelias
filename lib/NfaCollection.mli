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

  (** [mod_eq vars term m c] recognises [sum term = c (mod m)], i.e. the
      "divides" constraint [m | (sum term - c)]. [m = 0] is read as plain
      equality. *)
  val mod_eq : (Ir.atom, int) Map.t -> (Ir.atom, Z.t) Map.t -> Z.t -> Z.t -> t

  val strlen : alpha:v list option -> dest:int -> src:int -> unit -> t
  val strlen_const : alpha:v list option -> (int * int) list -> t
  val base : Z.t
end

module type NatType = sig
  include Type

  val div_in_pow : varpos -> int -> int -> t
  val pow_of_log_var : int -> int -> t
end

module Msb : sig
  include Type with type t = Nfa.Msb(Nfa.Bv).t and type v = bool
end

module MsbStr (B : Nfa.Base) : sig
  include Type with type t = Nfa.Msb(Nfa.Str(B)).t and type v = Nfa.Str(B).u
end

module MsbStrBv (B : Nfa.Base) : sig
  include Type with type t = Nfa.Msb(Nfa.StrBv(B)).t and type v = Nfa.StrBv(B).u
end

module MsbNat : sig
  include NatType with type t = Nfa.MsbNat(Nfa.Bv).t and type v = bool
end

module MsbNatStr (B : Nfa.Base) : sig
  include NatType with type t = Nfa.MsbNat(Nfa.Str(B)).t and type v = Nfa.Str(B).u
end

module MsbNatStrBv (B : Nfa.Base) : sig
  include NatType with type t = Nfa.MsbNat(Nfa.StrBv(B)).t and type v = Nfa.StrBv(B).u
end

module Lsb : sig
  include NatType with type t = Nfa.Lsb(Nfa.Bv).t and type v = bool
end

module LsbStr (B : Nfa.Base) : sig
  include NatType with type t = Nfa.Lsb(Nfa.Str(B)).t and type v = Nfa.Str(B).u
end

module LsbStrBv (B : Nfa.Base) : sig
  include NatType with type t = Nfa.Lsb(Nfa.StrBv(B)).t and type v = Nfa.StrBv(B).u
end

module LsbString : sig
  include NatType with type t = Nfa.String.t and type v = Nfa.Str(Nfa.Base10).u
end
