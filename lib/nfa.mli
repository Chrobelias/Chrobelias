(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)
module Map = Base.Map.Poly
module Set = Base.Set.Poly
module Sequence = Base.Sequence

type state = int
type deg = int

module type Type = sig
  type t
  type u

  val length : t -> int

  val create_nfa
    :  transitions:(state * int * state) list
    -> start:state list
    -> final:state list
    -> vars:int list
    -> deg:int
    -> t

  val create_dfa
    :  transitions:(state * int * state) list
    -> start:state
    -> final:state list
    -> vars:int list
    -> deg:int
    -> t

  val run : t -> bool
  val any_path : t -> int list -> (int list * int) option
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
    -> (t * (int * int) list * (int list * int)) Seq.t

  val combine_model_pieces : (int list * int) list -> int list
end

module Lsb : sig
  type t

  include NatType with type u = t and type t := t
end

module MsbNat : NatType

module Msb : sig
  include Type with type u = MsbNat.t
end
