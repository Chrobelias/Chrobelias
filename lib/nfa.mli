(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)
module Map = Base.Map.Poly
module Set = Base.Set.Poly
module Sequence = Base.Sequence

exception Too_big_nfa

type state = int

(** A modle type representing labels and basic operations over them. *)
module type BasicL = sig
  (** The type [u] represents digits. *)
  type u

  (** The type [t] represents arbitrary labels. *)
  type t

  (** [equal l1 l2] returns [true] if labels [l1] and [l2] are equal, otherwise [false].*)
  val equal : t -> t -> bool

  (** [is_zero l] returns [true] if labels [l] are equal to some ``good'' element, which is called zero*)
  val is_zero : t -> bool

  (** [combine l1 l2] returns a combination of labels [l1] and [l2] provided that they can be combined. In the parametric world = conjunction of labels*)
  val combine : t -> t -> t

  val simplify : t -> t

  (** [project pos l] returns a label obtained from [l] by projection over variables with positions 
  from the list [pos]. *)
  val project : int list -> t -> t

  (** Pretty print for digits*)
  val pp_u : Format.formatter -> u -> unit

  (** Pretty print for labels*)
  val pp : Format.formatter -> t -> unit

  (** [of_list vals] returns a label obtained from a list [vals] of pairs of positions and digits on these positions. *)
  val of_list : (int * u) list -> t

  val get : t -> int -> u
end

module type ParL = sig
  include BasicL

  (** [combine2 l1 l2 ph] the same as [combine l1 l2] but also uses a LIA-formula [ph] which binds [l1] and [l2]. 
  Usegful when working with automata for LIA-constraints *)
  val combine2 : t -> t -> AstL.t -> t

  val combine_list : t list -> t

  val filter_states
    :  state Set.t
    -> bool array
    -> AstL.t
    -> (t * state) list
    -> (t * state) list

  val filter_states_bool_comb
    :  (int -> state list -> bool)
    -> AstL.t list
    -> (t * state list) list
    -> (t * state list) list
end

module Par : sig
  include ParL with type u = int and type t = AstL.t
end

module type L = sig
  include BasicL

  val alphabet : u List.t
  val u_zero : u
  val u_one : u
  val u_null : u
  val u_eos : u
  val is_any_at : int -> t -> bool
  val variations : ?alpha:u list -> t -> t list
  val zero : int -> t
  val eos_with_mask : int list -> t
  val alpha : t -> u Set.t
end

module Str : sig
  include L with type u = char and type t = char array
end

(** A modle type representing automata and basic operations for / over them. *)
module type BasicType = sig
  (** The type [v] represents labels of automata. *)
  type v

  (** The type [t] represents automata. *)
  type t

  (** [length a] returns the number of states in the automaton [a]*)
  val length : t -> int

  (** [create_nfa trans start final vars deg] returns an nfa with [deg] states, which is 
  constructed using the list of transitions [trans], where the second argument is the list 
  of all labels from the lhs to the rhs; for two lists of states [start] and [final]; 
  and with the labels corresponding to the variables in [vars] *)
  val create_nfa
    :  transitions:(state * v list * state) list
    -> start:state list
    -> final:state list
    -> vars:int list
    -> deg:int
    -> t

  (** [create_dfa trans start final vars deg] returns a dfa with [deg] states, which is 
  constructed using the list of transitions [trans], where the second argument is the list 
  of all labels from the lhs to the rhs; for the starting state [start] and the list 
  of final states [final]; and with the labels corresponding to the variables in [vars] *)
  val create_dfa
    :  transitions:(state * v list * state) list
    -> start:state
    -> final:state list
    -> vars:int list
    -> deg:int
    -> t

  (** [run a] returns [true] if the automaton [a] recognizes a non-emty language, otherwise [false]. *)
  val run : t -> bool

  val any_path : t -> int list -> (v list list * int) option
  val run_bool_comb : AstL.t -> (int, t) Map.t -> bool

  val any_path_bool_comb
    :  AstL.t
    -> (int, t) Map.t
    -> int list
    -> (v list list * int) option

  (** [intersect a1 a2] returns an nfa recognizing the intersection of the languages 
  recognizable by [a1] and [a2]. *)
  val intersect : t -> t -> t

  (** [unite a1 a2] returns an nfa recognizing the union of the languages 
  recognizable by [a1] and [a2]. *)
  val unite : t -> t -> t

  (** [invert a] returns an nfa recognizing the complement of the language 
  recognizable by [a]. *)
  val invert : ?alpha:v list -> t -> t

  (** [project vars a] returns the result of the projection over the variables [vars] 
  applied to the automaton [a]. *)
  val project : int list -> t -> t

  (** [is_graph a] returns [true] if all labels in the automaton [a] are equal to the ``good'' element 
    (see is_zero). *)
  val is_graph : t -> bool

  val minimize : t -> t

  (** [reverse a] returns the nfa [a] where all transitions are reversed. *)
  val reverse : t -> t

  val format_nfa : Format.formatter -> t -> unit
end

module Parametric (Label : ParL) : sig
  include BasicType with type v = Label.u

  type vv = Label.t

  val create_nfa2
    :  transitions:(state * vv * state) list
    -> start:state list
    -> final:state list
    -> vars:int list
    -> deg:int
    -> t

  val create_nfa3
    :  transitions:(state * vv * state) list
    -> start:state list
    -> final:state list
    -> vars:int list
    -> deg:int
    -> is_dfa:bool
    -> ph:AstL.t
    -> t
end

module type Type = sig
  include BasicType

  type u

  val re_accepts : v list -> t -> bool
  val any_path : t -> int list -> (v list list * int) option
  val minimize_strong : t -> t
  val minimize_not_very_strong : t -> t
  val of_regex : v list Regex.t -> t
  val remove_unreachable_from_final : t -> t
  val alpha : t -> v Set.t
  val deriv : t -> v list -> u
end

module Lsb (Label : L) : sig
  type t

  include Type with type v = Label.u and type u = t and type t := t

  val path_of_len2 : t -> var:int -> len:int -> v list option
end

module Msb (Label : L) : sig
  type t

  include Type with type v = Label.u and type u = t and type t := t

  val of_lsb : Lsb(Label).t -> t
end

val convert_nfa_msb_par : (string, int) Map.t -> Msb(Str).t -> Parametric(Par).t
