(* SPDX-License-Identifier: MIT *)

(* Copyright 2024-2025, Chrobelias. *)

open Format
module Set = Base.Set.Poly
module Map = Base.Map.Poly
module Sequence = Base.Sequence

let trace_log fmt = Debug.trace "nfa" fmt

let _config = Config.config
let _base = _config.enc_base

exception Too_big_nfa

type state = int

let ( let* ) = Option.bind
let return = Option.some

let ( -- ) i j =
  let rec aux n acc = if n < i then acc else aux (n - 1) (n :: acc) in
  aux j []
;;

let cartesian_product l1 l2 =
  Set.fold
    ~f:(fun x a -> Set.fold ~f:(fun y b -> Set.add y (a, b)) ~init:x l2)
    ~init:Set.empty
    l1
;;

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
    :  (state list -> bool)
    -> state list list
    -> AstL.t list
    -> (t * state list) list
    -> (t * state list) list
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

module Str = struct
  type t = char array
  type u = char

  let config = Config.string_config
  let u_zero, u_one, u_null, u_eos = config.zero, config.one, config.null, config.eos
  let unsafe_get = Array.get
  let get label i = if Array.length label <= i then u_null else Array.get label i

  let is_any_at i label =
    let res = get label i = u_null in
    res
  ;;

  let equal vec1 vec2 =
    let len = Int.min (Array.length vec1) (Array.length vec2) in
    let exception Break in
    try
      for i = 0 to len - 1 do
        let v1 = get vec1 i in
        let v2 = get vec2 i in
        if Char.equal v1 u_null || Char.equal v2 u_null || Char.equal v1 v2
        then ()
        else raise_notrace Break
      done;
      true
    with
    | Break -> false
  ;;

  let combine vec1 vec2 =
    let vec1, vec2 =
      if Array.length vec2 > Array.length vec1 then vec2, vec1 else vec1, vec2
    in
    let len = Array.length vec1 in
    Array.init len (fun i ->
      let c1 = get vec1 i in
      if Char.equal c1 u_null then get vec2 i else c1)
  ;;

  let simplify = Fun.id

  let project proj vec =
    Array.init (Array.length vec) (fun i ->
      if List.mem i proj then u_null else unsafe_get vec i)
  ;;

  let is_zero vec = Array.for_all (fun v -> Char.equal v u_eos || Char.equal v u_null) vec

  let stretch vec mask_list deg =
    let m =
      mask_list
      |> List.mapi (fun i k -> k, Set.singleton i)
      |> Map.of_alist_reduce ~f:Set.union
    in
    Array.init deg (fun i ->
      (let* js = Map.find m i in
       let* j = Set.nth js 0 in
       let v = get vec j in
       v |> return)
      |> Option.value ~default:u_null)
    |> return
  ;;

  let alphabet =
    (Char.code '0' -- (Char.code '0' + _base - 1) |> List.map Char.chr)
    @ [ u_eos; u_null ]
  ;;

  (* FIXME: this should support different bases and symbols. *)
  let variations ?alpha vec =
    (*let alpha = List.map (fun a -> [ a ]) alpha in*)
    let full_alpha =
      Char.code '0' -- (Char.code '0' + _base - 1)
      |> List.map Char.chr
    in
    let full_alpha = Option.value ~default:full_alpha alpha in
    let alpha = [ u_eos ] :: (full_alpha |> List.map (fun c -> [ c ])) in
    let rec powerset = function
      | 0 -> []
      | 1 -> alpha
      | i ->
        let open Base.List.Let_syntax in
        let ( let* ) = ( >>= ) in
        let* s = powerset (i - 1) in
        List.map (fun a -> a @ s) alpha
    in
    let mask_list =
      Array.to_list vec
      |> List.mapi (fun i c -> i, c)
      |> List.filter_map (fun (i, c) -> if Char.code c <> 0 then Some i else None)
    in
    let length = Array.length vec in
    (*Iter.int_range ~start:0 ~stop:(pow 2 (List.length mask_list) - 1)*)
      match mask_list with
      | [] -> [ Array.init length (fun _ -> u_null) ]
      | _ ->
        powerset (List.length mask_list)
        |> Iter.of_list
        |> Iter.map (fun c -> Array.init (List.length mask_list) (fun i -> List.nth c i))
        |> Iter.map (fun x -> stretch x mask_list length |> Option.get)
        |> Iter.to_list
  ;;

  let zero deg = Array.init deg (fun _i -> u_null)

  let eos_with_mask mask =
    let len = List.fold_left max 0 mask + 1 in
    Array.init len (fun i -> if List.mem i mask then u_eos else u_null)
  ;;

  let pp_u = Format.pp_print_char

  let pp ppf (vec : t) =
    Array.to_seq vec
    |> Seq.map (function
      | x when x = u_null -> '_'
      | x when x = u_eos -> '$'
      | x -> x)
    |> String.of_seq
    |> Format.fprintf ppf "(%s)"
  ;;

  let of_list l =
    let label = List.map snd l in
    let vars = List.map fst l in
    let bv = Array.init (List.length l) (fun i -> List.nth label i) in
    let deg = List.fold_left max 0 vars + 1 in
    let vec = stretch bv vars deg |> Option.get in
    vec
  ;;

  let alpha s = Array.to_list s |> Set.of_list
end

module Par = struct
  type u = int
  type t = AstL.t

  open AstL

  (** Used in [run nfa] below to check existence of transitions *)
  let _base = Config.config.enc_base

  let const c = Lia.Const (Z.of_int c)
  let eq lhs rhs = Lia (Eq (lhs, rhs))
  let equal = AstL.equal
  let is_zero label = if Lia.equal label AstL.false_ then false else true
  (* else (
      match SimplI.check_sat base label with
      | `Sat ->
        true
      | _ -> false) *)

  let combine vec1 vec2 =
    if AstL.is_trivial vec1 || AstL.is_trivial vec2
    then land_ [ vec1; vec2 ] |> SimplI.simplify_lia
    else land_ [ vec1; vec2 ]
  ;;

  let combine2 vec1 vec2 ph =
    if AstL.is_trivial vec1 || AstL.is_trivial vec2
    then land_ [ vec1; vec2; ph ] |> SimplI.simplify_lia
    else land_ [ vec1; vec2 ]
  ;;

  let combine_list vecs = land_ vecs
  let simplify = SimplI.simplify_lia
  let project = AstL.project
  let pp_u = Format.pp_print_int
  let pp ppf (vec : t) = Format.fprintf ppf "(%a)" AstL.pp vec

  let of_list l =
    land_ (List.map (fun (i, value) -> eq (AstL.get i) (const value)) l)
    |> SimplI.simplify_lia
  ;;

  let filter_states final visited ph =
    fun transitions ->
    try
      let active_transitions =
        List.filter (fun (_, state) -> not visited.(state)) transitions
      in
      match
        active_transitions
        |> List.filter (fun (_, state) -> Set.mem final state)
        |> function
        | [] -> []
        | asts -> SimplI.get_states ph asts
      with
      | [] -> active_transitions |> SimplI.get_states ph
      | states -> states
    with
    | Exit -> []
  ;;

  let filter_states_bool_comb is_final visited phs =
    fun transitions ->
    let active_transitions =
      List.filter (fun (_, state) -> not (List.mem state visited)) transitions
    in
    (* trace_log "Ph: %a" AstL.pp_smtlib2 ph; *)
      try
        match
          active_transitions
          |> List.filter (fun (_, state) -> is_final state)
          |> function
          | [] -> []
          | asts ->
            (* trace_log "Base in filter_states: %a" Z.pp_print base; *)
            SimplI.get_states_bool_comb (AstL.land_ phs) asts
        with
        | [] -> SimplI.get_states_bool_comb (AstL.land_ phs) active_transitions
        | states ->
          (* List.iter
          (fun (_, l) ->
             List.iter (fun x -> trace_log "%d; " x) l;
             trace_log "next;")
          states; *)
          states
      with
      | Exit -> []
  ;;

  let get = AstL.get_val
end

module Graph (Label : BasicL) = struct
  type t = (Label.t * state) list array

  let verticies (graph : t) = Array.length graph

  let reverse (graph : t) : t =
    let rev_graph = Array.make (verticies graph) [] in
    Array.iteri
      (fun q delta ->
         List.iter
           (fun (label, q') -> rev_graph.(q') <- (label, q) :: rev_graph.(q'))
           delta)
      graph;
    rev_graph
  ;;

  let all_paths_of_len graph =
    let rec helper cur = function
      | 0 -> cur
      | n ->
        assert (n > 0);
        let next =
          cur
          |> Map.to_sequence
          |> Sequence.concat_map ~f:(fun (state, path) ->
            graph.(state)
            |> Sequence.of_list
            |> Sequence.map ~f:(fun (lbl, dst) -> dst, lbl :: path))
          |> Map.of_sequence_reduce ~f:Fun.const
        in
        helper next (pred n)
    in
    helper
  ;;
end

(** A modle type representing automata and basic operations for / over them. *)
module type BasicType = sig
  (** The type [v] represents digits in labels of automata. *)
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

type ('a, 'b) nfa_t =
  { transitions : 'a
  ; final : state Set.t
  ; start : state Set.t
  ; deg : int
  ; is_dfa : bool
  ; extra : 'b
  }

let length nfa = Array.length nfa.transitions
let states nfa = 0 -- (length nfa - 1) |> Set.of_list

module Parametric (Label : ParL) = struct
  module Graph = Graph (Label)

  type t = (Graph.t, AstL.t) nfa_t
  type v = Label.u
  type vv = Label.t

  let length = length
  let wrap = fun nfa -> { nfa with extra = AstL.true_ }

  let create_nfa
        ~(transitions : (state * v list * state) list)
        ~(start : state list)
        ~(final : state list)
        ~(vars : int list)
        ~(deg : int)
    =
    let max =
      transitions
      |> Iter.of_list
      |> Iter.map (fun (fst, _, snd) -> max fst snd)
      |> Iter.fold max (List.fold_left max (List.fold_left max 0 final) start)
    in
    let transitions =
      transitions
      |> List.fold_left
           (fun lists (src, lbl, dst) ->
              lists.(src) <- (lbl, dst) :: lists.(src);
              lists)
           (Array.init (max + 1) (Fun.const []))
      |> Array.map (fun delta ->
        List.filter_map
          (fun (label, q') -> (Label.of_list (List.combine vars label), q') |> return)
          delta)
    in
    wrap
      { transitions
      ; final = Set.of_list final
      ; start = Set.of_list start
      ; deg
      ; is_dfa = false
      ; extra = ()
      }
  ;;

  let create_dfa
        ~(transitions : (state * v list * state) list)
        ~(start : state)
        ~(final : state list)
        ~(vars : int list)
        ~(deg : int)
    =
    let max =
      transitions
      |> Iter.of_list
      |> Iter.map (fun (fst, _, snd) -> max fst snd)
      |> Iter.fold max 0
    in
    let transitions =
      transitions
      |> List.fold_left
           (fun lists (src, lbl, dst) ->
              lists.(src) <- (lbl, dst) :: lists.(src);
              lists)
           (Array.init (max + 1) (Fun.const []))
      |> Array.map (fun delta ->
        List.filter_map
          (fun (label, q') -> (Label.of_list (List.combine vars label), q') |> return)
          delta)
    in
    wrap
      { transitions
      ; final = Set.of_list final
      ; start = Set.singleton start
      ; deg
      ; is_dfa = true
      ; extra = ()
      }
  ;;

  let create_nfa2
        ~(transitions : (state * vv * state) list)
        ~(start : state list)
        ~(final : state list)
        ~(vars : int list)
        ~(deg : int)
    =
    let max =
      transitions
      |> Iter.of_list
      |> Iter.map (fun (fst, _, snd) -> max fst snd)
      |> Iter.fold max (List.fold_left max (List.fold_left max 0 final) start)
    in
    let transitions =
      transitions
      |> List.fold_left
           (fun lists (src, lbl, dst) ->
              lists.(src) <- (lbl, dst) :: lists.(src);
              lists)
           (Array.init (max + 1) (Fun.const []))
    in
    wrap
      { transitions
      ; final = Set.of_list final
      ; start = Set.of_list start
      ; deg
      ; is_dfa = false
      ; extra = ()
      }
  ;;

  let create_nfa3
        ~(transitions : (state * vv * state) list)
        ~(start : state list)
        ~(final : state list)
        ~(vars : int list)
        ~(deg : int)
        ~(is_dfa : bool)
        ~(ph : AstL.t)
    =
    { (create_nfa2 ~transitions ~start ~final ~vars ~deg) with extra = ph; is_dfa }
  ;;

  let project_verticies nfa verticies =
    let map_new_old =
      verticies
      |> Set.to_sequence
      |> Sequence.mapi ~f:(fun i v -> i, v)
      |> Map.of_sequence_exn
    in
    let map_old_new =
      verticies
      |> Set.to_sequence
      |> Sequence.mapi ~f:(fun i v -> v, i)
      |> Map.of_sequence_exn
    in
    let start = nfa.start |> Set.filter_map ~f:(Map.find map_old_new) in
    let final = nfa.final |> Set.filter_map ~f:(Map.find map_old_new) in
    let transitions =
      Array.init (Set.length verticies) (fun q ->
        let old_q = Map.find_exn map_new_old q in
        let delta = nfa.transitions.(old_q) in
        List.filter_map
          (fun (label, old_q') ->
             if Set.mem verticies old_q'
             then (
               let q' = Map.find_exn map_old_new old_q' in
               Option.some (label, q'))
             else Option.none)
          delta)
    in
    { transitions; start; final; deg = nfa.deg; is_dfa = false; extra = nfa.extra }
  ;;

  let remove_unreachable_from_start nfa =
    let visited = Array.make (length nfa) false in
    let rec bfs reachable = function
      | [] -> reachable
      | q :: tl ->
        if visited.(q)
        then bfs reachable tl
        else (
          visited.(q) <- true;
          let reachable = Set.add reachable q in
          let delta = Array.get nfa.transitions q in
          let qs = (delta |> List.map snd) @ tl in
          bfs reachable qs)
    in
    bfs Set.empty (nfa.start |> Set.to_list) |> project_verticies nfa
  ;;

  let remove_unreachable_from_final nfa =
    let reversed_transitions = nfa.transitions |> Graph.reverse in
    let visited = Array.make (length nfa) false in
    let rec bfs reachable = function
      | [] -> reachable
      | q :: tl ->
        if visited.(q)
        then bfs reachable tl
        else (
          visited.(q) <- true;
          let reachable = Set.add reachable q in
          let delta = Array.get reversed_transitions q in
          let qs = (delta |> List.map snd) @ tl in
          bfs reachable qs)
    in
    if Set.is_empty nfa.final
    then create_nfa ~transitions:[] ~start:[ 0 ] ~final:[] ~vars:[] ~deg:1
    else bfs Set.empty (nfa.final |> Set.to_list) |> project_verticies nfa
  ;;

  let any_path ?nozero (nfa : t) vars =
    let exception Sat_found of vv list in
    let transitions = nfa.transitions in
    let successors state visited =
      let transitions = Array.get transitions state in
      let without = Array.init (length nfa) (Fun.const false) in
      List.iter (fun state -> without.(state) <- true) visited;
      without.(state) <- true;
      let next without = transitions |> Label.filter_states nfa.final without nfa.extra in
      let succ without =
        match next without with
        | [] -> []
        | states ->
          states |> List.map snd |> List.iter (fun state -> without.(state) <- true);
          states
      in
      Seq.forever (fun () -> succ without) |> Seq.take_while (Fun.negate List.is_empty)
    in
    let dfs start =
      let rec rdfs path visited node =
        (* trace_log "\nVisited states list: ";
        List.iter (fun x -> trace_log "%d; " x) visited; *)
        if not (List.mem node visited)
        then
          begin if Set.mem nfa.final node
          then raise (Sat_found path)
          else
            Seq.fold_left
              (List.fold_left (fun acc x -> rdfs (fst x :: path) acc (snd x)))
              (node :: visited)
              (successors node visited)
          end
        else visited
      in
      rdfs [] [] start
    in
    let bfs start =
      let rec rbfs visited = function
        | [] -> visited
        | ((label, state) :: tl as path) :: other ->
          if not (List.mem state visited)
          then
            begin if Set.mem nfa.final state
            then raise (Sat_found (List.filter_map fst path))
            else (
              let neighbors =
                List.of_seq (successors state visited)
                |> List.concat
                |> List.filter_map (fun (label, state) ->
                  if List.mem state visited
                  then None
                  else Some ((Some label, state) :: path))
              in
              rbfs (state :: visited) (other @ neighbors))
            end
          else rbfs visited other
        | _ -> assert false
      in
      rbfs [] [ [ None, start ] ]
    in
    let visited = Array.init (length nfa) (Fun.const false) in
    let inspect state =
      let serach = if _config.path_search = `Bfs then bfs else dfs in
      try
        List.iter (fun state -> visited.(state) <- true) (serach state);
        None
      with
      | Sat_found path -> Some path
    in
    match Set.find_map ~f:inspect nfa.start with
    | Some [] -> Some (List.map (fun _ -> []) vars, 0)
    | Some p ->
      let p = List.rev p in
      let length = List.length p in
      Some
        ( List.map
            (fun var -> List.init length (fun i -> Label.get (List.nth p i) var))
            vars
        , length )
    | None -> None
  ;;

  let any_path = any_path ~nozero:false
  let run nfa = any_path nfa [] |> Option.is_some

  let format_nfa ppf nfa =
    let format_state ppf state = fprintf ppf "%d" state in
    let start_final = Set.inter nfa.start nfa.final in
    let start = Set.diff nfa.start start_final in
    let final = Set.diff nfa.final start_final in
    fprintf ppf "digraph {\n";
    if Bool.not (AstL.equal nfa.extra AstL.true_)
    then fprintf ppf "NodeL [label=\"%a\", shape=box];\n" AstL.pp_smtlib2 nfa.extra;
    fprintf ppf "node [shape=circle]\n";
    Set.iter final ~f:(fprintf ppf "\"%a\" [shape=doublecircle]\n" format_state);
    Set.iter start ~f:(fprintf ppf "\"%a\" [shape=octagon]\n" format_state);
    Set.iter start_final ~f:(fprintf ppf "\"%a\" [shape=doubleoctagon]\n" format_state);
    Array.iteri
      (fun q delta ->
         delta
         |> List.map (fun (label, q') -> q', label)
         |> Map.of_alist_multi
         |> Map.iteri ~f:(fun ~key:q' ~data:labels ->
           fprintf
             ppf
             "\"%a\" -> \"%a\" [label=\"%a\"]\n"
             format_state
             q
             format_state
             q'
             (Format.pp_print_list
                ~pp_sep:(fun ppf () -> Format.fprintf ppf "\n")
                Label.pp)
             labels))
      nfa.transitions;
    fprintf ppf "}"
  ;;

  let intersect nfa1 nfa2 =
    let counter = ref 0 in
    let visited = Array.make_matrix (length nfa1) (length nfa2) (-1) in
    let q (q1, q2) = visited.(q1).(q2) in
    let is_visited (q1, q2) = q (q1, q2) <> -1 in
    let visit (q1, q2) =
      if is_visited (q1, q2) |> not
      then (
        visited.(q1).(q2) <- !counter;
        counter
        := if !counter >= Config.max_nfa_size then raise Too_big_nfa else !counter + 1)
    in
    let rec aux transitions queue =
      if Queue.is_empty queue
      then transitions
      else (
        let q1, q2 = Queue.pop queue in
        let delta1 = nfa1.transitions.(q1) in
        let delta2 = nfa2.transitions.(q2) in
        let delta =
          List.fold_left
            (fun acc_delta (label1, q1') ->
               List.fold_left
                 (fun acc_delta (label2, q2') ->
                    let label =
                      Label.combine2 label1 label2 (AstL.land_ [ nfa1.extra; nfa2.extra ])
                    in
                    if Label.is_zero label
                    then (
                      let is_visited = is_visited (q1', q2') in
                      visit (q1', q2');
                      let q' = q (q1', q2') in
                      let acc_delta = (label, q') :: acc_delta in
                      if is_visited |> not then Queue.add (q1', q2') queue;
                      acc_delta)
                    else acc_delta)
                 acc_delta
                 delta2)
            []
            delta1
        in
        aux (delta :: transitions) queue)
    in
    let start_pairs = cartesian_product nfa1.start nfa2.start in
    let queue = Queue.create () in
    Set.iter
      ~f:(fun x ->
        visit x;
        Queue.add x queue)
      start_pairs;
    let transitions = aux [] queue |> List.rev |> Array.of_list in
    let start = start_pairs |> Set.map ~f:q in
    let final =
      cartesian_product nfa1.final nfa2.final
      |> Set.map ~f:q
      |> Set.filter ~f:(( <> ) (-1))
    in
    let deg = max nfa1.deg nfa2.deg in
    let is_dfa = nfa1.is_dfa && nfa2.is_dfa in
    { final
    ; start
    ; transitions
    ; deg
    ; is_dfa
    ; extra = AstL.land_ [ nfa1.extra; nfa2.extra ]
    }
    |> remove_unreachable_from_start
    |> remove_unreachable_from_final
  ;;

  let unite nfa1 nfa2 =
    let s1 q = q in
    let s2 q = length nfa1 + q in
    let start = Set.union (Set.map ~f:s1 nfa1.start) (Set.map ~f:s2 nfa2.start) in
    let final = Set.union (Set.map ~f:s1 nfa1.final) (Set.map ~f:s2 nfa2.final) in
    let transitions =
      Array.append
        (nfa1.transitions
         |> Array.map (fun delta -> List.map (fun (label, q') -> label, s1 q') delta))
        (nfa2.transitions
         |> Array.map (fun delta -> List.map (fun (label, q') -> label, s2 q') delta))
    in
    let deg = max nfa1.deg nfa2.deg in
    { start
    ; final
    ; transitions
    ; deg
    ; is_dfa = false
    ; extra = AstL.lor_ [ nfa1.extra; nfa2.extra ]
    }
  ;;

  let invert ?alpha nfa =
    let dfa = if nfa.is_dfa then nfa else failwith "Unimplemented" in
    let states = states dfa in
    let final = Set.diff states dfa.final in
    { final
    ; start = dfa.start
    ; transitions = dfa.transitions
    ; deg = dfa.deg
    ; is_dfa = true
    ; extra = dfa.extra
    }
  ;;

  let is_graph nfa =
    nfa.transitions
    |> Array.for_all (fun delta ->
      List.for_all (fun (label, _) -> Label.is_zero label) delta)
  ;;

  let minimize nfa =
    nfa
    |> fun nfa ->
    { nfa with
      transitions =
        nfa.transitions
        |> Array.map (fun delta ->
          delta
          |> List.map (fun (label, pos) -> Label.simplify label, pos)
          |> List.filter (fun (label, _) -> Label.is_zero label)
          |> Set.of_list
          |> Set.to_list)
    }
    |> remove_unreachable_from_final
    |> remove_unreachable_from_start
  ;;

  let project to_remove nfa =
    let transitions =
      Array.mapi
        (fun q delta ->
           let project (label, q') = Label.project to_remove label, q' in
           List.map project delta)
        nfa.transitions
    in
    { final = nfa.final
    ; start = nfa.start
    ; transitions
    ; deg = nfa.deg
    ; is_dfa = false
    ; extra = failwith "TODO ME"
    }
  ;;

  let reverse nfa =
    let transitions = Array.make (length nfa) [] in
    Array.iteri
      (fun q delta ->
         List.iter
           (fun (label, q') -> transitions.(q') <- (label, q) :: transitions.(q'))
           delta)
      nfa.transitions;
    { final = nfa.start
    ; start = nfa.final
    ; transitions
    ; deg = nfa.deg
    ; is_dfa = false
    ; extra = nfa.extra
    }
  ;;

  (* This function takes on input 
  1) [skel]: a Boolean skeleton, where leafs have names Atom_i; 
  2) [nfas]: a map from i to nfa that correspond to atomic formulas;
  3) [vars] -- here, only a list of numbers of vars *)
  let any_path_bool_comb skel (nfas : (int, t) Map.t) vars =
    let exception Sat_found of vv list in
    let nfas' = Map.data nfas in
    trace_log "Nfas:";
    List.iter (fun nfa -> Debug.dump_nfa ~msg:"> nfa: %s" format_nfa nfa) nfas';
    (* trace_log "Skel: %a" AstL.pp_smtlib2 skel;
    Map.iter ~f:(fun nfa -> Debug.dump_nfa ~msg:"Next nfa: %s" format_nfa nfa) nfas; *)
    let each f = nfas' |> List.map f in
    let starts, transitions, finals, extras =
      ( each (fun nfa -> nfa.start)
      , each (fun nfa -> nfa.transitions)
      , each (fun nfa -> nfa.final)
      , each (fun nfa -> nfa.extra) )
    in
    let is_final node =
      let bl = List.mapi (fun n final -> Set.mem final (List.nth node n)) finals in
      let ph =
        AstL.map
          (function
            | Pred s ->
              let n = AstL.get_atom_num_exn s in
              if List.nth bl n then AstL.true_ else AstL.false_
            | ast -> ast)
          skel
      in
      match SimplI.check_sat ph with
      | `Sat -> true
      | `Unsat | `Unknown -> false
    in
    let successors state visited =
      trace_log
        "State: [%a]"
        (Format.pp_print_list
           ~pp_sep:(fun ppf () -> Format.fprintf ppf " ")
           Format.pp_print_int)
        state;
      (*What happens below: we have a list of labelled graphs. 
      I want to exatract all the successors of [state]=(state_0,...,state_n) from these graphs. 
      I geather the list of lists of successors of state_0, ..., state_n; then consider the cartesian 
      product of these lists to obtain a list of new 'states', the successors. 
      The formulas on the labels are combined = we take the conjunction of them using the function 
      [Label.combine_list]. *)
      let transitions =
        transitions
        |> List.mapi (fun n arr -> Array.get arr (List.nth state n))
        |> Utils.cartesian2
        |> List.map (fun choice ->
          List.fold_right
            (fun (l, state) (acc_l, acc_state) -> l :: acc_l, state :: acc_state)
            choice
            ([], [])
          |> fun (x, y) -> Label.combine_list x, y)
      in
      let next without =
        transitions |> Label.filter_states_bool_comb is_final without extras
      in
      let succ without =
        match next without with
        | [] -> None
        | states ->
          Some (states, List.fold_left (fun acc sl -> snd sl :: acc) without states)
      in
      Seq.unfold (fun acc -> succ acc) (state :: visited)
    in
    let dfs start =
      let rec rdfs path visited node =
        (* trace_log "Node: ";
        List.iter (fun x -> trace_log "%d; " x) node; *)
        (* trace_log "\nVisited states list: ";
        List.iter (fun x -> trace_log "%d; " x) visited; *)
        if not (List.mem node visited)
        then (* trace_log "Node to ast: %a" AstL.pp_smtlib2 (to_ast node); *)
          if is_final node
          then raise (Sat_found path)
          else
            Seq.fold_left
              (List.fold_left (fun acc x -> rdfs (fst x :: path) acc (snd x)))
              (node :: visited)
              (successors node visited)
        else visited
      in
      rdfs [] [] start
    in
    let inspect state =
      try
        let _ = dfs state in
        None
      with
      | Sat_found path -> Some path
    in
    match List.find_map inspect (starts |> List.map Set.to_list |> Utils.cartesian2) with
    | Some [] -> Some (List.map (fun _ -> []) vars, 0)
    | Some p ->
      let p = List.rev p in
      let length = List.length p in
      Some
        ( List.map
            (fun var -> List.init length (fun i -> Label.get (List.nth p i) var))
            vars
        , length )
    | None -> None
  ;;

  let run_bool_comb skel nfas = any_path_bool_comb skel nfas [] |> Option.is_some
end

module Make
    (Label : L)
    (Invariants : sig
       val update_invariants : ((Graph(Label).t, unit) nfa_t as 'a) -> 'a
     end) =
struct
  module Graph = Graph (Label)

  type t = (Graph.t, unit) nfa_t
  type v = Label.u

  let length = length

  let project_verticies nfa verticies =
    let map_new_old =
      verticies
      |> Set.to_sequence
      |> Sequence.mapi ~f:(fun i v -> i, v)
      |> Map.of_sequence_exn
    in
    let map_old_new =
      verticies
      |> Set.to_sequence
      |> Sequence.mapi ~f:(fun i v -> v, i)
      |> Map.of_sequence_exn
    in
    let start = nfa.start |> Set.filter_map ~f:(Map.find map_old_new) in
    let final = nfa.final |> Set.filter_map ~f:(Map.find map_old_new) in
    let transitions =
      Array.init (Set.length verticies) (fun q ->
        let old_q = Map.find_exn map_new_old q in
        let delta = nfa.transitions.(old_q) in
        List.filter_map
          (fun (label, old_q') ->
             if Set.mem verticies old_q'
             then (
               let q' = Map.find_exn map_old_new old_q' in
               Option.some (label, q'))
             else Option.none)
          delta)
    in
    { transitions; start; final; deg = nfa.deg; is_dfa = false; extra = () }
  ;;

  let remove_unreachable_from_start nfa =
    let visited = Array.make (length nfa) false in
    let rec bfs reachable = function
      | [] -> reachable
      | q :: tl ->
        if visited.(q)
        then bfs reachable tl
        else (
          visited.(q) <- true;
          let reachable = Set.add reachable q in
          let delta = Array.get nfa.transitions q in
          let qs = (delta |> List.map snd) @ tl in
          bfs reachable qs)
    in
    bfs Set.empty (nfa.start |> Set.to_list) |> project_verticies nfa
  ;;

  let remove_unreachable_from_final nfa =
    let reversed_transitions = nfa.transitions |> Graph.reverse in
    let visited = Array.make (length nfa) false in
    let rec bfs reachable = function
      | [] -> reachable
      | q :: tl ->
        if visited.(q)
        then bfs reachable tl
        else (
          visited.(q) <- true;
          let reachable = Set.add reachable q in
          let delta = Array.get reversed_transitions q in
          let qs = (delta |> List.map snd) @ tl in
          bfs reachable qs)
    in
    bfs Set.empty (nfa.final |> Set.to_list) |> project_verticies nfa
  ;;

  let create_nfa
        ~(transitions : (state * Label.u list * state) list)
        ~(start : state list)
        ~(final : state list)
        ~(vars : int list)
        ~(deg : int)
    =
    (*let vars = List.rev vars in*)
    let max =
      transitions
      |> Iter.of_list
      |> Iter.map (fun (fst, _, snd) -> max fst snd)
      |> Iter.fold max (List.fold_left max (List.fold_left max 0 final) start)
    in
    let transitions =
      transitions
      |> List.fold_left
           (fun lists (src, lbl, dst) ->
              lists.(src) <- (lbl, dst) :: lists.(src);
              lists)
           (Array.init (max + 1) (Fun.const []))
      |> Array.map (fun delta ->
        List.filter_map
          (fun (label, q') -> (Label.of_list (List.combine vars label), q') |> return)
          delta)
    in
    { transitions
    ; final = Set.of_list final
    ; start = Set.of_list start
    ; deg
    ; is_dfa = false
    ; extra = ()
    }
    |> Invariants.update_invariants
  ;;

  let create_dfa
        ~(transitions : (state * Label.u list * state) list)
        ~(start : state)
        ~(final : state list)
        ~(vars : int list)
        ~(deg : int)
    =
    (*let vars = List.rev vars in*)
    let max =
      transitions
      |> Iter.of_list
      |> Iter.map (fun (fst, _, snd) -> max fst snd)
      |> Iter.fold max 0
    in
    (* TODO: ensure transitions are actually deterministic. *)
    let transitions =
      transitions
      |> List.fold_left
           (fun lists (src, lbl, dst) ->
              lists.(src) <- (lbl, dst) :: lists.(src);
              lists)
           (Array.init (max + 1) (Fun.const []))
      |> Array.map (fun delta ->
        List.filter_map
          (fun (label, q') -> (Label.of_list (List.combine vars label), q') |> return)
          delta)
    in
    { transitions
    ; final = Set.of_list final
    ; start = Set.singleton start
    ; deg
    ; is_dfa = true
    ; extra = ()
    }
  ;;

  let format_nfa ppf nfa =
    let format_state ppf state = fprintf ppf "%d" state in
    let start_final = Set.inter nfa.start nfa.final in
    let start = Set.diff nfa.start start_final in
    let final = Set.diff nfa.final start_final in
    fprintf ppf "digraph {\n";
    fprintf ppf "node [shape=circle]\n";
    Set.iter final ~f:(fprintf ppf "\"%a\" [shape=doublecircle]\n" format_state);
    Set.iter start ~f:(fprintf ppf "\"%a\" [shape=octagon]\n" format_state);
    Set.iter start_final ~f:(fprintf ppf "\"%a\" [shape=doubleoctagon]\n" format_state);
    Array.iteri
      (fun q delta ->
         delta
         |> List.map (fun (label, q') -> q', label)
         |> Map.of_alist_multi
         |> Map.iteri ~f:(fun ~key:q' ~data:labels ->
           fprintf
             ppf
             "\"%a\" -> \"%a\" [label=\"%a\"]\n"
             format_state
             q
             format_state
             q'
             (Format.pp_print_list
                ~pp_sep:(fun ppf () -> Format.fprintf ppf "\n")
                Label.pp)
             labels))
      nfa.transitions;
    fprintf ppf "}"
  ;;

  let intersect nfa1 nfa2 =
    let counter = ref 0 in
    let visited = Array.make_matrix (length nfa1) (length nfa2) (-1) in
    let q (q1, q2) = visited.(q1).(q2) in
    let is_visited (q1, q2) = q (q1, q2) <> -1 in
    let visit (q1, q2) =
      if is_visited (q1, q2) |> not
      then (
        visited.(q1).(q2) <- !counter;
        counter
        := if !counter >= Config.max_nfa_size then raise Too_big_nfa else !counter + 1)
    in
    let rec aux transitions queue =
      if Queue.is_empty queue
      then transitions
      else (
        let q1, q2 = Queue.pop queue in
        let delta1 = nfa1.transitions.(q1) in
        let delta2 = nfa2.transitions.(q2) in
        let delta =
          List.fold_left
            (fun acc_delta (label1, q1') ->
               List.fold_left
                 (fun acc_delta (label2, q2') ->
                    let equal = Label.equal label1 label2 in
                    match equal with
                    | true ->
                      let label = Label.combine label1 label2 in
                      let is_visited = is_visited (q1', q2') in
                      visit (q1', q2');
                      let q' = q (q1', q2') in
                      let acc_delta = (label, q') :: acc_delta in
                      if is_visited |> not then Queue.add (q1', q2') queue;
                      acc_delta
                    | false -> acc_delta)
                 acc_delta
                 delta2)
            []
            delta1
        in
        aux (delta :: transitions) queue)
    in
    let start_pairs = cartesian_product nfa1.start nfa2.start in
    let queue = Queue.create () in
    Set.iter
      ~f:(fun x ->
        visit x;
        Queue.add x queue)
      start_pairs;
    let transitions = aux [] queue |> List.rev |> Array.of_list in
    let start = start_pairs |> Set.map ~f:q in
    let final =
      cartesian_product nfa1.final nfa2.final
      |> Set.map ~f:q
      |> Set.filter ~f:(( <> ) (-1))
    in
    let deg = max nfa1.deg nfa2.deg in
    let is_dfa = nfa1.is_dfa && nfa2.is_dfa in
    let result =
      { final; start; transitions; deg; is_dfa; extra = () }
      |> remove_unreachable_from_start
    in
    result
  ;;

  let unite nfa1 nfa2 =
    let s1 q = q in
    let s2 q = length nfa1 + q in
    let start = Set.union (Set.map ~f:s1 nfa1.start) (Set.map ~f:s2 nfa2.start) in
    let final = Set.union (Set.map ~f:s1 nfa1.final) (Set.map ~f:s2 nfa2.final) in
    let transitions =
      Array.append
        (nfa1.transitions
         |> Array.map (fun delta -> List.map (fun (label, q') -> label, s1 q') delta))
        (nfa2.transitions
         |> Array.map (fun delta -> List.map (fun (label, q') -> label, s2 q') delta))
    in
    let deg = max nfa1.deg nfa2.deg in
    { start; final; transitions; deg; is_dfa = false; extra = () }
  ;;

  let is_graph nfa =
    nfa.transitions
    |> Array.for_all (fun delta ->
      List.for_all (fun (label, _) -> Label.is_zero label) delta)
  ;;

  let project to_remove nfa =
    let transitions =
      Array.mapi
        (fun q delta ->
           let project (label, q') = Label.project to_remove label, q' in
           List.map project delta)
        nfa.transitions
    in
    { final = nfa.final
    ; start = nfa.start
    ; transitions
    ; deg = nfa.deg
    ; is_dfa = false
    ; extra = ()
    }
    |> Invariants.update_invariants
  ;;

  let reverse nfa =
    let transitions = Array.make (length nfa) [] in
    Array.iteri
      (fun q delta ->
         List.iter
           (fun (label, q') -> transitions.(q') <- (label, q) :: transitions.(q'))
           delta)
      nfa.transitions;
    { final = nfa.start
    ; start = nfa.final
    ; transitions
    ; deg = nfa.deg
    ; is_dfa = false
    ; extra = ()
    }
  ;;

  let to_dfa ?alpha nfa =
    if nfa.is_dfa
    then nfa
    else (
      let counter = ref 0 in
      let length = length nfa in
      let visited = Hashtbl.create length in
      let is_visited qs = Hashtbl.mem visited qs in
      let visit qs =
        if is_visited qs |> not
        then (
          let q = !counter in
          counter
          := if !counter >= Config.max_nfa_size then raise Too_big_nfa else !counter + 1;
          Hashtbl.replace visited qs q)
        else ()
      in
      let processed = Hashtbl.create length in
      let is_processed qs = Hashtbl.mem processed qs in
      let process qs =
        if is_processed qs |> not then Hashtbl.replace processed qs true else ()
      in
      let q qs = Hashtbl.find visited qs in
      let rec aux transitions final queue =
        if Queue.is_empty queue
        then transitions, final
        else (
          let qs = Queue.pop queue in
          if is_processed qs |> not
          then (
            visit qs;
            process qs;
            let final =
              if Set.are_disjoint nfa.final qs |> not then Set.add final (q qs) else final
            in
            let acc =
              Set.fold
                ~f:(fun acc q ->
                  let delta = Array.get nfa.transitions q in
                  List.fold_left
                    (fun acc (label, _) -> Label.combine acc label)
                    (Label.zero nfa.deg)
                    delta
                  |> Label.combine acc)
                ~init:(Label.zero nfa.deg)
                qs
            in
            let variations = Label.variations ?alpha acc in
            let delta =
              List.fold_left
                (fun acc label ->
                   (* TODO(Kakadu): It looks like we are constructing a set [qs']
                    and check if it is the same set as [qs]. Maybe we should check presence in [qs] on every addition
                    to [qs'] and in the end check that every element of [qs] is in [qs']. It will give us a chance for
                    early exit
                   *)
                   let qs' =
                     Set.fold
                       ~f:(fun acc q ->
                         (* Note(Kakadu): I tried to replace acc as list to a set, but it became slower *)
                         let delta = Array.get nfa.transitions q in
                         let q' =
                           List.filter_map
                             (fun (label', x) ->
                                if Label.equal label label' then Some x else None)
                             delta
                         in
                         (* TODO(Kakadu): appending lists is slow *)
                         List.append q' acc)
                       ~init:[]
                       qs
                     |> Set.of_list
                   in
                   let q' =
                     if Set.equal qs' qs |> not
                     then (
                       visit qs';
                       Queue.add qs' queue;
                       q qs')
                     else q qs
                   in
                   (label, q') :: acc)
                []
                variations
            in
            let delta', final' = aux transitions final queue in
            delta :: delta', final')
          else aux transitions final queue)
      in
      let queue = Queue.create () in
      Queue.add nfa.start queue;
      let transitions, final = aux [] Set.empty queue in
      let transitions = Array.of_list transitions in
      { final
      ; start = Set.singleton 0
      ; transitions
      ; deg = nfa.deg
      ; is_dfa = true
      ; extra = ()
      })
  ;;

  let invert ?alpha nfa =
    (* We need complete DFA here, to_dfa() makes a complete DFA thus we're using it. *)
    let dfa = nfa |> to_dfa ?alpha in
    let states = states dfa in
    let final = Set.diff states dfa.final in
    { final
    ; start = dfa.start
    ; transitions = dfa.transitions
    ; deg = dfa.deg
    ; is_dfa = true
    ; extra = ()
    }
  ;;

  let of_regex (r : Label.u list Regex.t) =
    let rec traverse visited = function
      | s when Set.is_empty s -> []
      | s ->
        let r = Set.nth s 0 |> Option.get in
        (*Format.printf "<< %a\n%!" (Regex.pp (Format.pp_print_list Label.pp_u)) r;*)
        let tl = Set.remove_index s 0 in
        if Set.mem visited r
        then traverse visited tl
        else (
          let visited = Set.add visited r in
          let symbols = Regex.symbols r in
          let delta = List.map (fun symbol -> symbol, Regex.deriv symbol r) symbols in
          let tl =
            Set.union
              (List.map snd delta
               |> List.filter (fun r' -> not (Set.mem visited r'))
               |> Set.of_list)
              tl
          in
          (r, delta) :: traverse visited tl)
    in
    let transitions = traverse Set.empty (Set.singleton r) in
    let regex_to_state =
      transitions |> List.map fst |> List.mapi (fun i r -> r, i) |> Map.of_alist_exn
    in
    let finals = Map.keys regex_to_state |> List.filter Regex.v in
    let regex_to_state = Map.find_exn regex_to_state in
    let transitions =
      transitions
      |> List.concat_map (fun (q, delta) ->
        List.map (fun (l, q') -> regex_to_state q, l, regex_to_state q') delta)
    in
    let deg =
      Regex.symbols r |> List.fold_left (fun acc v -> max acc (List.length v)) 0
    in
    create_nfa
      ~transitions
      ~start:[ regex_to_state r ]
      ~final:(finals |> List.map regex_to_state)
      ~vars:(0 -- (deg - 1) |> List.rev)
      ~deg
    |> remove_unreachable_from_final
  ;;

  let any_path ?nozero (nfa : t) vars =
    let transitions = nfa.transitions in
    let nozero = nozero |> Option.value ~default:false in
    let p =
      let frontier = Queue.create () in
      let visited = Array.init (length nfa) (Fun.const false) in
      let rec bfs () =
        match Queue.take_opt frontier with
        | None -> None
        | Some ((_, hd) :: _ as path) ->
          if visited.(hd)
          then bfs ()
          else begin
            visited.(hd) <- true;
            let new_paths =
              Array.get transitions hd |> List.map (fun part -> part :: path)
            in
            let path' =
              List.find_opt
                (fun path' -> Set.mem nfa.final (List.hd path' |> snd))
                new_paths
            in
            begin match path' with
            | Some path' -> Some path'
            | None ->
              List.iter (fun path' -> Queue.add path' frontier) new_paths;
              bfs ()
            end
          end
        | Some [] -> failwith ""
      in
      Set.iter ~f:(fun q -> Queue.add [ Label.zero nfa.deg, q ] frontier) nfa.start;
      if (not nozero) && not (Set.inter nfa.start nfa.final |> Set.is_empty)
      then Some []
      else bfs ()
    in
    match p with
    | Some [] -> Some (List.map (fun _ -> []) vars, 0)
    | Some p ->
      let p = List.rev p |> List.tl in
      let length = List.length p in
      Some
        ( List.map
            (fun var -> List.init length (fun i -> Label.get (List.nth p i |> fst) var))
            vars
        , length )
    | None -> None
  ;;

  let re_accepts path nfa =
    let dfa =
      create_dfa
        ~start:0
        ~final:[ List.length path ]
        ~vars:[ 0 ]
        ~deg:1
        ~transitions:(List.mapi (fun i v -> i, [ v ], i + 1) path)
      |> intersect nfa
    in
    any_path dfa [] |> Option.is_some
  ;;

  let alpha (nfa : t) =
    nfa.transitions
    |> Array.to_seq
    |> Sequence.of_seq
    |> Sequence.map ~f:(fun l ->
      l
      |> Sequence.of_list
      |> Sequence.map ~f:(fun (label, _) -> Label.alpha label |> Set.to_sequence)
      |> Sequence.concat)
    |> Sequence.concat
    |> Set.of_sequence
  ;;

  let deriv_helper : t -> v list -> t =
    fun nfa vs ->
    let start =
      List.fold_left
        (fun acc v ->
           let qs =
             Set.map
               ~f:(fun q ->
                 let delta = nfa.transitions.(q) in
                 List.filter_map
                   (fun (label, q') ->
                      if Label.get label 0 = v || Label.is_any_at 0 label
                      then Option.some q'
                      else Option.none)
                   delta
                 |> Set.of_list)
               acc
           in
           Set.fold_right ~init:Set.empty ~f:Set.union qs)
        nfa.start
        vs
    in
    { nfa with start }
  ;;

  let deriv nfa vs =
    deriv_helper nfa vs
    |> to_dfa ~alpha:(nfa |> alpha |> Set.to_list)
    |> remove_unreachable_from_final
  ;;
end

module Lsb (Label : L) = struct
  include
    Make
      (Label)
      (struct
        let update_invariants (nfa : (Graph(Label).t, unit) nfa_t) =
          let module Graph = Graph (Label) in
          let reversed_transitions = nfa.transitions |> Graph.reverse in
          let final =
            let visited = Array.make (length nfa) false in
            let rec bfs reachable = function
              | [] -> reachable
              | q :: tl ->
                if visited.(q)
                then bfs reachable tl
                else (
                  visited.(q) <- true;
                  let reachable = Set.add reachable q in
                  let delta =
                    Array.get reversed_transitions q
                    |> List.filter (fun (label, _) -> Label.is_zero label)
                  in
                  let qs = (delta |> List.map snd) @ tl in
                  bfs reachable qs)
            in
            bfs Set.empty (nfa.final |> Set.to_list)
          in
          { transitions = nfa.transitions
          ; start = nfa.start
          ; final
          ; deg = nfa.deg
          ; is_dfa = nfa.is_dfa
          ; extra = ()
          }
        ;;
      end)

  type u = t

  let any_path = any_path ~nozero:false
  let run nfa = any_path nfa [] |> Option.is_some
  let any_path_bool_comb skel nfas vars = failwith "Unimplemented"
  let run_bool_comb skel nfas = any_path_bool_comb skel nfas [] |> Option.is_some

  let minimize nfa =
    nfa
    |> fun nfa ->
    { nfa with
      transitions =
        nfa.transitions |> Array.map (fun delta -> Set.of_list delta |> Set.to_list)
    }
    |> remove_unreachable_from_final
    |> remove_unreachable_from_start
  ;;

  let minimize_strong nfa =
    nfa
    |> remove_unreachable_from_final
    |> remove_unreachable_from_start
    |> reverse
    |> to_dfa
    |> reverse
    |> to_dfa
  ;;

  let minimize_not_very_strong nfa =
    if length nfa > Config.config.good_for_minimize
    then nfa |> minimize
    else nfa |> minimize_strong
  ;;

  let path_of_len2 (nfa : t) ~var ~len : v list option =
    let start =
      nfa.start |> Set.to_list |> List.map (fun x -> x, []) |> Map.of_alist_exn
    in
    let paths = Graph.all_paths_of_len nfa.transitions start len in
    let paths = Map.filteri paths ~f:(fun ~key ~data:_ -> Set.mem nfa.final key) in
    if Map.is_empty paths
    then Option.none
    else (
      let path = Map.nth_exn paths 0 |> snd in
      let path = path |> List.map (fun l -> Label.get l var) in
      Option.some path)
  ;;
end

module Msb (Label : L) = struct
  include
    Make
      (Label)
      (struct
        let update_invariants (nfa : (Graph(Label).t, unit) nfa_t) =
          match Set.find ~f:(Fun.const true) nfa.start with
          | Some start ->
            let rec helper front visited transitions =
              if Set.is_empty front
              then transitions
              else (
                let next =
                  front
                  |> Set.to_sequence
                  |> Sequence.concat_map ~f:(fun (lbl, state) ->
                    transitions.(state)
                    |> Sequence.of_list
                    |> Sequence.filter_map ~f:(fun (lbl', state) ->
                      if (not (Set.mem visited state)) && Label.equal lbl lbl'
                      then Some (lbl, state)
                      else None))
                  |> Set.of_sequence
                in
                let visited = Set.union visited (front |> Set.map ~f:snd) in
                transitions.(start)
                <- (let t = transitions.(start) in
                    List.append
                      (Set.filter ~f:(fun x -> not (List.mem x t)) next |> Set.to_list)
                      t);
                helper next visited transitions)
            in
            let front =
              nfa.start
              |> Set.to_list
              |> List.concat_map (Array.get nfa.transitions)
              |> Set.of_list
            in
            { nfa with transitions = helper front Set.empty (Array.copy nfa.transitions) }
          | None -> nfa
        ;;
      end)

  type u = t

  let minimize nfa =
    nfa
    |> fun nfa ->
    { nfa with
      transitions =
        nfa.transitions |> Array.map (fun delta -> Set.of_list delta |> Set.to_list)
    }
    |> remove_unreachable_from_final
    |> remove_unreachable_from_start
  ;;

  let minimize_strong nfa = nfa |> reverse |> to_dfa |> reverse |> to_dfa |> minimize

  let minimize_not_very_strong nfa =
    if length nfa > Config.config.good_for_minimize
    then nfa |> minimize
    else nfa |> minimize_strong
  ;;

  let any_path nfa =
    Debug.dump_nfa ~msg:"ANY PATH INPUT: %s" format_nfa nfa;
    any_path ~nozero:true nfa
  ;;

  let run nfa = any_path nfa [] |> Option.is_some
  let any_path_bool_comb skel nfas vars = failwith "Unimplemented"
  let run_bool_comb skel nfas = any_path_bool_comb skel nfas [] |> Option.is_some

  let of_lsb (nfa : Lsb(Label).t) : t =
    let nfa = minimize_not_very_strong nfa in
    let start = length nfa in
    let transitions' =
      Array.append
        (Graph.reverse nfa.transitions)
        (Set.map ~f:(fun start' -> Label.eos_with_mask [ 0 ], start') nfa.final
         |> Set.to_list
         |> fun x -> [ Label.eos_with_mask [ 0 ], start ] @ x |> fun x -> [| x |])
    in
    { start = Set.singleton start
    ; is_dfa = false
    ; final = nfa.start
    ; transitions = transitions'
    ; deg = nfa.deg
    ; extra = ()
    }
  ;;
end

let astl_of_str is_sign vars (str : Str.t) =
  Map.fold
    ~f:(fun ~key ~data acc ->
      let open AstL in
      let open Lia in
      let safe_get s i =
        if i < Array.length s then Option.some (Array.get s i) else Option.none
      in
      match safe_get str data with
      | Some c when Base.Char.is_digit c ->
        let c = Base.Char.get_digit_exn c |> Z.of_int in
        lia (eq (atom (Var key)) (const c)) :: acc
      | Some c when Char.equal c Str.u_eos && is_sign ->
        lia (eq (atom (Var key)) (const Z.zero)) :: acc
      | Some c when Char.equal c Str.u_eos -> false_ :: acc
      | _ -> acc)
    ~init:[]
    vars
  |> AstL.land_
  |> SimplI.simplify_lia
;;

let convert_nfa_msb_par vars : Msb(Str).t -> Parametric(Par).t =
  fun nfa ->
  { start = nfa.start
  ; is_dfa = nfa.is_dfa
  ; deg = nfa.deg
  ; final = nfa.final
  ; transitions =
      (let f =
         fun i x ->
         x
         |> List.map (fun (label, q') -> q', astl_of_str (Set.mem nfa.start i) vars label)
         |> Map.of_alist_multi
         |> Map.filter_map ~f:(fun ts ->
           match SimplI.simplify_lia (AstL.lor_ ts) with
           | ph when AstL.equal ph AstL.false_ -> None
           | ph -> Some ph)
         |> Map.to_alist
         |> List.map (fun (x, y) -> y, x)
       in
       Array.mapi f nfa.transitions)
  ; extra = AstL.true_
  }
;;
