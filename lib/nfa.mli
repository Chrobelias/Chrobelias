(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)
module Map = Base.Map.Poly
module Set = Base.Set.Poly
module Sequence = Base.Sequence

type state = int
type deg = int

module type L = sig
  type t
  type u

  val u_zero : u
  val equal : t -> t -> bool
  val combine : t -> t -> t
  val project : int list -> t -> t
  val truncate : int -> t -> t
  val is_zero : t -> bool
  val variations : t -> t list
  val reenumerate : (int, int) Map.t -> t -> t
  val zero : int -> t
  val zero_with_mask : int list -> t
  val singleton_with_mask : int -> int list -> t
  val one_with_mask : int list -> t
  val pp : Format.formatter -> t -> unit
  val of_list : (int * u) list -> t
  val get : t -> int -> u
end

module Bv : sig
  include L with type u = bool
end

module Str : sig
  include L with type u = char and type t = char array
end

module type Type = sig
  type t
  type u
  type v

  val length : t -> int

  val create_nfa
    :  transitions:(state * v list * state) list
    -> start:state list
    -> final:state list
    -> vars:int list
    -> deg:int
    -> t

  val create_dfa
    :  transitions:(state * v list * state) list
    -> start:state
    -> final:state list
    -> vars:int list
    -> deg:int
    -> t

  val run : t -> bool
  val any_path : t -> int list -> (v list list * int) option
  val intersect : t -> t -> t
  val unite : t -> t -> t
  val project : int list -> t -> t
  val truncate : int -> t -> t
  val is_graph : t -> bool
  val reenumerate : (int, int) Map.t -> t -> t
  val minimize : t -> t
  val invert : t -> t
  val format_nfa : Format.formatter -> t -> unit
  val to_nat : t -> u
  val of_regex : v list Regex.t -> t
  val remove_unreachable_from_final : t -> t
end

module type NatType = sig
  include Type

  val find_c_d : t -> (int, int) Map.t -> (int * int) list
  val chrobak : t -> (int * int) list

  val get_chrobaks_sub_nfas
    :  t
    -> res:deg
    -> temp:deg
    -> vars:int list
    -> (t * (int * int) list * (v list list * int)) Seq.t

  val combine_model_pieces : (v list list * int) list -> v list list
end

module Lsb (Label : L) : sig
  type t

  include NatType with type v = Label.u and type u = t and type t := t

  val filter_map : t -> (Label.t * int -> (Label.t * int) option) -> t
end

module MsbNat (Label : L) : sig
  include NatType with type v = Label.u
end

module Msb (Label : L) : sig
  include Type with type u = MsbNat(Label).t and type v = Label.u
end
