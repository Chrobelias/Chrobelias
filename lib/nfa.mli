(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)
module Map = Base.Map.Poly
module Set = Base.Set.Poly
module Sequence = Base.Sequence

exception Too_big_nfa

(** Raised by [all_paths_of_len ~limit] when the BFS frontier exceeds [limit].
    Callers passing [~limit] are expected to catch it and degrade to unknown. *)
exception Too_dense_graph

type state = int
type deg = int

(** A Boolean skeleton over atoms numbered by an [int], as consumed by
    {!Type.any_path_bool_comb}. There is deliberately no negation: that function
    needs acceptance to be monotone in the atoms, so a negated subformula has to
    become an atom of its own. *)
module Skel : sig
  type t =
    | True
    | False
    | Atom of int
    | And of t list
    | Or of t list

  val true_ : t
  val false_ : t
  val atom : int -> t

  (** [and_] and [or_] flatten nested combinations of the same connective and
      fold the constants away. *)
  val and_ : t list -> t

  val or_ : t list -> t
  val eval : (int -> bool) -> t -> bool
  val map_atoms : (int -> int) -> t -> t

  (** Whether the skeleton is free of [Or], which is what makes
      {!Type.any_path_bool_comb} a complete decision procedure for it. *)
  val is_conjunctive : t -> bool

  val pp : Format.formatter -> t -> unit
end

module type L = sig
  type t
  type u

  val base : Z.t
  val alphabet : u List.t
  val u_zero : u
  val u_null : u
  val u_eos : u
  val is_any_at : int -> t -> bool
  val get : t -> int -> u
  val equal : t -> t -> bool
  val combine : t -> t -> t
  val project : int list -> t -> t
  val truncate : int -> t -> t
  val is_zero : t -> bool
  val is_zero_soft : t -> bool
  val variations : ?alpha:u list -> t -> t list
  val reenumerate : (int, int) Map.t -> t -> t
  val zero : int -> t
  val zero_with_mask : int list -> t
  val eos_with_mask : int list -> t
  val singleton_with_mask : int -> int list -> t
  val one_with_mask : int list -> t
  val pp_u : Format.formatter -> u -> unit
  val pp : Format.formatter -> t -> unit
  val of_list : (int * u) list -> t
  val alpha : t -> u Set.t
end

module Bv : sig
  include L with type u = bool
end

module type Base = sig
  val base : Z.t
end

module type StrL = sig
  include L

  val u_null : u
  val u_eos : u
  val u_one : u
  val is_end_char : u -> bool
  val is_eos_at : int -> t -> bool
  val is_any_at : int -> t -> bool
  val is_zero_at : int -> t -> bool
  val is_one_at : int -> t -> bool
end

module Str (_ : Base) : sig
  include StrL with type u = char and type t = char array
end

module StrBv (_ : Base) : sig
  include StrL with type u = Z.t and type t = Z.t * Z.t
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
  val re_accepts : v list -> t -> bool
  val any_path : t -> int list -> (v list list * int) option

  (** [any_path_bool_comb skel nfas vars] looks for a word accepted by the
      Boolean combination [skel] of [nfas] (atom [i] of [skel] stands for
      [Map.find_exn nfas i]) without ever building their product: it walks all
      the automata simultaneously, a node of the search being a tuple of states
      and a joint transition a tuple of transitions with agreeing labels.

      A returned path always is a genuine model, because [Skel.t] cannot negate:
      the path exhibits one run per automaton and every automaton whose run is
      accepting does accept the word. [None] means unsatisfiable as long as
      [skel] is conjunctive; under a disjunction it may also mean that some
      automaton — possibly one irrelevant to satisfying [skel] — got stuck. *)
  val any_path_bool_comb
    :  Skel.t
    -> (int, t) Map.t
    -> int list
    -> (v list list * int) option

  val run_bool_comb : Skel.t -> (int, t) Map.t -> bool
  val any_n_paths : t -> ?len:int -> int -> v list list
  val any_n_paths_range : t -> ?len:int -> int -> v list list
  val all_paths_of_len : t -> ?limit:int -> int -> v list list
  val shrink : t -> t
  val intersect : t -> t -> t
  val unite : t -> t -> t
  val project : int list -> t -> t
  val truncate : int -> t -> t
  val is_graph : t -> bool
  val reenumerate : (int, int) Map.t -> t -> t
  val minimize : t -> t
  val minimize_strong : t -> t
  val minimize_not_very_strong : t -> t
  val invert : ?alpha:v list -> t -> t
  val reverse : t -> t
  val format_nfa : Format.formatter -> t -> unit
  val to_nat : t -> u
  val of_nat : u -> t
  val of_regex : v list Regex.t -> t
  val remove_unreachable_from_final : t -> t
  val find_c_d' : t -> (int * int) Seq.t
  val split : t -> (t * t) list
  val equal_start_and_final : t -> t -> bool
  val alpha : t -> v Set.t
  val deriv : t -> v list -> u
  val deriv_final : t -> v list -> u
end

module type NatType = sig
  include Type

  val chrobak : t -> (int * int) Seq.t

  val get_chrobaks_sub_nfas
    :  t
    -> res:deg
    -> temp:deg
    -> vars:int list
    -> no_model:bool
    -> (t * (int * int) Seq.t * (int -> (v list list * int) option)) Seq.t

  val combine_model_pieces : v list list * int -> v list list * int -> v list list * int
end

module Lsb (Label : L) : sig
  type t

  include NatType with type v = Label.u and type u = t and type t := t

  val filter_map : t -> (Label.t * int -> (Label.t * int) option) -> t
  val path_of_len2 : t -> var:int -> len:int -> v list option
end

module MsbNat (Label : L) : sig
  include NatType with type v = Label.u
end

module Msb (Label : L) : sig
  include Type with type u = MsbNat(Label).t and type v = Label.u

  val filter_map : t -> (Label.t * int -> (Label.t * int) option) -> t
  val of_lsb : Lsb(Label).t -> t
end

module Str10 : sig
  include StrL with type u = char and type t = char array
end

module Base10 : Base
module Base2 : Base

module String : sig
  include
    NatType
    with type v = Str(Base10).u
     and type u = Lsb(Str(Base10)).u
     and type t = Lsb(Str(Base10)).t

  val filter_map : t -> (Str(Base10).t * int -> (Str(Base10).t * int) option) -> t
  val path_of_len2 : t -> var:int -> len:int -> v list option
end

module ConvertStr (B : Base) : sig
  val lsb : Lsb(Str(B)).t -> Lsb(StrBv(B)).t
  val msb : Msb(Str(B)).t -> Msb(StrBv(B)).t
  val str : String.t -> Lsb(Str(B)).t
end
