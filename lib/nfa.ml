(* SPDX-License-Identifier: MIT *)

(* Copyright 2024-2025, Chrobelias. *)

open Format
module Set = Base.Set.Poly
module Map = Base.Map.Poly
module Sequence = Base.Sequence

module Debug = struct
  let nfa_cnt = ref 0
  let flag () = Sys.getenv_opt "CHRO_DEBUG" |> Option.is_some

  let fmt =
    if flag ()
    then Format.formatter_of_out_channel Stdio.stderr
    else
      Format.formatter_of_out_functions
        { out_string = (fun _ _ _ -> ())
        ; out_flush = (fun _ -> ())
        ; out_newline = (fun _ -> ())
        ; out_spaces = (fun _ -> ())
        ; out_indent = (fun _ -> ())
        }
  ;;

  let _printf str = Format.fprintf fmt (str ^^ "%!")
  let printfln str = Format.fprintf fmt (str ^^ "\n%!")

  let dump_nfa ?msg ?vars format_nfa nfa =
    if flag ()
    then (
      let ( !< ) a = Format.sprintf a in
      let name =
        nfa_cnt := !nfa_cnt + 1;
        Format.sprintf "%d" !nfa_cnt
      in
      let subdir = string_of_int (Unix.getpid ()) in
      let supdir = "debugs" in
      Sys.command (!<{|mkdir -p "%s"/"%s"|} supdir subdir) |> ignore;
      let dir = !<"%s/%s" supdir subdir in
      let dot_file = !<"%s/n%s.dot" dir name in
      let svg_file = !<"%s/n%s.svg" dir name in
      let oc = open_out dot_file in
      let command = Format.sprintf {|dot -Tsvg "%s" > "%s"|} dot_file svg_file in
      Format.asprintf "%a" format_nfa nfa |> Printf.fprintf oc "%s";
      close_out oc;
      Sys.command command |> ignore;
      match msg with
      | Some msg -> printfln msg svg_file
      | None -> ())
  ;;
end

let _pow2 n = List.init n (Fun.const 2) |> List.fold_left ( * ) 1

type deg = int
type state = int

let ( let* ) = Option.bind
let return = Option.some

let ( -- ) i j =
  let rec aux n acc = if n < i then acc else aux (n - 1) (n :: acc) in
  aux j []
;;

let rec pow a = function
  | 0 -> 1
  | 1 -> a
  | n ->
    let b = pow a (n / 2) in
    b * b * if n mod 2 = 0 then 1 else a
;;

module type L = sig
  type t
  type u

  val u_zero : u
  val equal : t -> t -> bool
  val combine : t -> t -> t
  val project : int list -> t -> t
  val truncate : int -> t -> t
  val is_zero : t -> bool
  val is_zero_soft : t -> bool
  val variations : u list -> t -> t list
  val reenumerate : (int, int) Map.t -> t -> t
  val zero : int -> t
  val zero_with_mask : int list -> t
  val singleton_with_mask : int -> int list -> t
  val one_with_mask : int list -> t
  val pp : formatter -> t -> unit
  val pp_u : formatter -> u -> unit
  val of_list : (int * u) list -> t
  val get : t -> int -> u
  val alpha : t -> u Set.t
end

module Bv = struct
  type t = Z.t * Z.t
  type u = bool

  let bv_get v i = Z.logand v (Z.shift_left Z.one i) |> Z.equal Z.zero |> not

  let bv_init deg f =
    List.fold_left
      (fun acc v -> if f v then Z.logor acc (Z.shift_left Z.one v) else acc)
      Z.zero
      (0 -- (deg - 1))
  ;;

  let bv_of_list = List.fold_left (fun acc v -> Z.logor acc (Z.shift_left Z.one v)) Z.zero

  let stretch vec mask_list deg =
    let m =
      mask_list
      |> List.mapi (fun i k -> k, Set.singleton i)
      |> Map.of_alist_reduce ~f:Set.union
    in
    let ok =
      0 -- deg
      |> List.for_all (fun j ->
        let js = Map.find m j |> Option.value ~default:Set.empty in
        Set.for_all ~f:(fun j -> bv_get vec j) js
        || Set.for_all ~f:(fun j -> bv_get vec j |> not) js)
    in
    match ok with
    | true ->
      bv_init deg (fun i ->
        (let* js = Map.find m i in
         let* j = Set.nth js 0 in
         let v = bv_get vec j in
         match v with
         | true -> Option.some true
         | false -> Option.none)
        |> Option.is_some)
      |> return
    | false -> Option.none
  ;;

  let bv_len v = if Z.equal v Z.zero then 0 else Z.log2 v + 1

  let bv_to_list =
    let rec aux acc z =
      if Z.equal z Z.zero
      then acc
      else (
        let v = Z.log2 z in
        aux (v :: acc) (Z.sub z (Z.shift_left Z.one v)))
    in
    aux []
  ;;

  let u_zero = false

  let equal (vec1, mask1) (vec2, mask2) =
    let mask = Z.logand mask1 mask2 in
    Z.equal (Z.logand vec1 mask) (Z.logand vec2 mask)
  ;;

  let combine (vec1, mask1) (vec2, mask2) =
    Z.logor (Z.logand vec1 mask1) (Z.logand vec2 mask2), Z.logor mask1 mask2
  ;;

  let project proj (vec, mask) =
    let proj = bv_of_list proj in
    vec, Z.sub mask (Z.logand mask proj)
  ;;

  let truncate len (vec, mask) =
    let proj = Z.sub (Z.shift_left Z.one len) Z.one in
    vec, Z.logand mask proj
  ;;

  let is_zero (vec, mask) = Z.logand vec mask |> Z.equal Z.zero
  let is_zero_soft = is_zero

  let variations _alpha (_, mask) =
    let mask_list = mask |> bv_to_list in
    let length = bv_len mask in
    Iter.int_range ~start:0 ~stop:(pow 2 (List.length mask_list) - 1)
    |> Iter.map Z.of_int
    |> Iter.map (fun x -> stretch x mask_list length |> Option.get)
    |> Iter.map (fun x -> x, mask)
    |> Iter.to_list
  ;;

  let zero _deg = Z.zero, Z.zero
  let zero_with_mask mask = Z.zero, bv_of_list mask
  let singleton_with_mask c mask = Z.shift_left Z.one c, bv_of_list mask
  let one_with_mask mask = bv_of_list mask, bv_of_list mask

  let pp ppf (vec, mask) =
    let mask_len = bv_len mask in
    let vec =
      Bitv.of_list_with_length (bv_to_list vec |> List.filter (( > ) mask_len)) mask_len
      |> Bitv.L.to_string
      |> String.to_seq
    in
    let mask =
      Bitv.of_list_with_length (bv_to_list mask |> List.filter (( > ) mask_len)) mask_len
      |> Bitv.L.to_string
      |> String.to_seq
    in
    Seq.zip vec mask
    |> Seq.map (function
      | _, '0' -> '_'
      | x, _ -> x)
    |> String.of_seq
    |> Format.fprintf ppf "(%s)"
  ;;

  let pp_u fmt = function
    | true -> Format.fprintf fmt "1"
    | false -> Format.fprintf fmt "0"
  ;;

  let reenumerate map (vec, mask) =
    let length =
      max (bv_len mask) ((map |> Map.keys |> List.fold_left max min_int) + 1)
    in
    let vec =
      bv_init length (fun i ->
        match Map.find map i with
        | Some j -> bv_get vec j
        | None -> false)
    in
    let mask =
      bv_init length (fun i ->
        match Map.find map i with
        | Some j -> bv_get mask j
        | None -> false)
    in
    vec, mask
  ;;

  let of_list l =
    let label = List.map snd l in
    let vars = List.map fst l in
    let bv = bv_init (List.length l) (fun i -> List.nth label i) in
    let deg = List.fold_left max 0 vars + 1 in
    let vec = stretch bv vars deg |> Option.get in
    let mask = bv_of_list vars in
    vec, mask
  ;;

  let get (vec, _mask) = bv_get vec
  let alpha _ = [ true; false ] |> Set.of_list
end

module Str = struct
  type t = char array
  type u = char

  let config = Config.string_config
  let u_zero, u_one, u_null, u_eos = config.zero, config.one, config.null, config.eos
  let is_end_char c = c = u_eos || c = u_null

  let pp ppf (vec : t) =
    Array.to_seq vec
    |> Seq.map (function
      | x when x = u_null -> '_'
      | x when x = u_eos -> '$'
      | x -> x)
    |> String.of_seq
    |> Format.fprintf ppf "(%s)"
  ;;

  let unsafe_get = Array.get
  let safe_get arr i = if Array.length arr <= i then u_null else Array.get arr i
  let nth i label = safe_get label i
  let is_eos_at i label = nth i label = u_eos

  let is_any_at i label =
    let res = nth i label = u_null in
    res
  ;;

  let is_zero_at i label = nth i label = u_zero
  let is_one_at i label = nth i label = u_one

  let stretch vec mask_list deg =
    let m =
      mask_list
      |> List.mapi (fun i k -> k, Set.singleton i)
      |> Map.of_alist_reduce ~f:Set.union
    in
    (*let ok =
      0 -- deg
      |> List.for_all (fun j ->
        let js = Map.find m j |> Option.value ~default:Set.empty in
        Set.for_all ~f:(fun j -> bv_get vec j) js
        || Set.for_all ~f:(fun j -> bv_get vec j |> not) js)
    in
    match ok with
    | true ->*)
    Array.init deg (fun i ->
      (let* js = Map.find m i in
       let* j = Set.nth js 0 in
       let v = safe_get vec j in
       v |> return)
      |> Option.value ~default:u_null)
    |> return
  ;;

  (*| false -> Option.none*)

  let equal vec1 vec2 =
    let len = max (Array.length vec1) (Array.length vec2) in
    0 -- (len - 1)
    |> List.for_all (fun i ->
      let v1 = safe_get vec1 i in
      let v2 = safe_get vec2 i in
      Char.equal v1 u_null || Char.equal v2 u_null || Char.equal v1 v2)
  ;;

  let combine vec1 vec2 =
    let vec1, vec2 =
      if Array.length vec2 > Array.length vec1 then vec2, vec1 else vec1, vec2
    in
    let len = Array.length vec1 in
    Array.init len (fun i ->
      let c1 = safe_get vec1 i in
      if Char.equal c1 u_null then safe_get vec2 i else c1)
  ;;

  let project proj vec =
    Array.init (Array.length vec) (fun i ->
      if List.mem i proj then u_null else unsafe_get vec i)
  ;;

  let truncate len vec =
    Array.init (Array.length vec) (fun i -> if i < len then unsafe_get vec i else u_null)
  ;;

  let is_zero vec = Array.for_all (fun v -> Char.equal v u_eos || Char.equal v u_null) vec

  let is_zero_soft vec =
    Array.for_all
      (fun v -> Char.equal v u_eos || Char.equal v u_null || Char.equal v '0')
      vec
  ;;

  let zero deg = Array.init deg (fun _i -> u_null)

  let zero_with_mask mask =
    let len = List.fold_left max 0 mask + 1 in
    Array.init len (fun i -> if List.mem i mask then '0' else u_null)
  ;;

  let singleton_with_mask c mask =
    let len = max (List.fold_left max 0 mask) c + 1 in
    Array.init len (fun i ->
      if not (List.mem i mask) then u_null else if i = c then '1' else '0')
  ;;

  let one_with_mask mask =
    let len = List.fold_left max 0 mask + 1 in
    Array.init len (fun i -> if List.mem i mask then '1' else u_null)
  ;;

  let pp_u = Format.pp_print_char
  let full_alpha = 32 -- 126 |> List.map Char.chr

  (* FIXME: this should support different bases and symbols. *)
  let variations _alpha vec =
    (*let alpha = List.map (fun a -> [ a ]) alpha in*)
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

  let reenumerate map vec =
    let len =
      max (Array.length vec) ((map |> Map.keys |> List.fold_left max min_int) + 1)
    in
    let vec =
      Array.init len (fun i ->
        match Map.find map i with
        | Some j -> unsafe_get vec j
        | None -> u_null)
    in
    vec
  ;;

  let of_list l =
    let label = List.map snd l in
    let vars = List.map fst l in
    let bv = Array.init (List.length l) (fun i -> List.nth label i) in
    let deg = List.fold_left max 0 vars + 1 in
    let vec = stretch bv vars deg |> Option.get in
    vec
  ;;

  let get = safe_get
  let alpha s = Array.to_list s |> Set.of_list
end

module Graph (Label : L) = struct
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

  let reachable_in_range (graph : t) first last (init : state Set.t) =
    assert (0 <= first);
    assert (first <= last);
    let diff = last - first + 1 in
    let step =
      let mem = ref Map.empty in
      fun cur ->
        match Map.find !mem cur with
        | Some x -> x
        | None ->
          let ans =
            cur
            |> Set.to_sequence
            |> Sequence.concat_map ~f:(fun state ->
              graph.(state) |> Sequence.of_list |> Sequence.map ~f:snd)
            |> Set.of_sequence
          in
          mem := Map.add_exn !mem ~key:cur ~data:ans;
          ans
    in
    let rec helper n cur =
      match n with
      | 0 -> [ cur ], 1
      | n ->
        assert (n > 0);
        let states = step cur in
        let next, amount = helper (n - 1) states in
        if amount < diff then cur :: next, amount + 1 else next, amount
    in
    helper last init |> fst
  ;;

  let rec _reachable (graph : t) (start : state Set.t) : state Set.t =
    let next =
      start
      |> Set.to_sequence
      |> Sequence.concat_map ~f:(fun i -> graph.(i) |> List.map snd |> Sequence.of_list)
      |> Set.of_sequence
    in
    let next = Set.diff next start in
    if Set.is_empty next then start else _reachable graph (Set.union start next)
  ;;

  let find_strongly_connected_components (graph : t) =
    let s = Stack.create () in
    let rev_graph = reverse graph in
    let visited = Array.make (verticies graph) false in
    let dfs1 v =
      let rec dfs1 v =
        if visited.(v) |> not
        then (
          visited.(v) <- true;
          let us = graph.(v) |> List.map snd in
          List.iter (fun u -> if visited.(u) |> not then dfs1 u else ()) us;
          Stack.push v s)
      in
      dfs1 v
    in
    Array.iteri (fun v _ -> dfs1 v) graph;
    let visited = Array.make (verticies graph) false in
    let rec dfs2 v =
      if visited.(v) |> not
      then (
        visited.(v) <- true;
        let us = rev_graph.(v) |> List.map snd in
        v
        :: (List.map (fun u -> if visited.(u) |> not then dfs2 u else []) us
            |> List.concat))
      else []
    in
    Stack.to_seq s
    |> Seq.filter_map (fun v ->
      if visited.(v) |> not then Option.some (dfs2 v) else Option.none)
    |> List.of_seq
  ;;

  let union_list (graphs : t list) : t =
    match graphs with
    | [] -> Array.init 0 (Fun.const [])
    | hd :: tl ->
      let len = Array.length hd in
      tl |> List.iter (fun graph -> assert (Array.length graph = len));
      let res = Array.init len (Fun.const []) in
      0 -- pred len
      |> List.iter (fun i ->
        res.(i) <- graphs |> List.concat_map (fun graph -> graph.(i)));
      res
  ;;

  let find_shortest_cycle (graph : t) (vertex : state) : int =
    let rec helper acc visited cur =
      if Set.is_empty cur
      then 0
      else (
        let acc = acc + 1 in
        let next =
          cur
          |> Set.to_list
          |> List.concat_map (fun x -> graph.(x) |> List.map snd)
          |> Set.of_list
        in
        if Set.mem next vertex
        then acc
        else (
          let visited = Set.union visited cur in
          helper acc visited (Set.diff next visited)))
    in
    helper 0 Set.empty (Set.singleton vertex)
  ;;

  let find_important_verticies graph =
    find_strongly_connected_components graph
    |> List.concat_map (fun vs ->
      let list = List.map (fun v -> v, find_shortest_cycle graph v) vs in
      let min = list |> List.map snd |> List.fold_left Int.min (verticies graph) in
      list |> List.find_all (fun (_, len) -> len = min))
  ;;

  let all_paths (graph : t) start =
    let rec helper visited front =
      if List.is_empty front
      then visited
      else (
        let visited =
          Map.fold2
            visited
            (Map.of_alist_reduce ~f:Fun.const front)
            ~init:Map.empty
            ~f:(fun ~key ~data ->
              match data with
              | `Left data | `Right data -> Map.add_exn ~key ~data
              | `Both _ -> failwith "Unreachable")
        in
        let next =
          front
          |> List.concat_map (fun (i, path) ->
            graph.(i)
            |> List.filter (fun (lbl, dst) -> not (Map.mem visited dst))
            |> List.map (fun (lbl, dst) -> dst, lbl :: path))
        in
        helper visited next)
    in
    start |> Map.to_alist |> helper Map.empty
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

let%expect_test "Reachable in range smoke test" =
  let module Graph = Graph (Bv) in
  let reachable_in_range = Graph.reachable_in_range in
  let print x =
    Format.printf
      "%a\n"
      (Format.pp_print_list
         ~pp_sep:(fun fmt () -> Format.fprintf fmt "; ")
         (Format.pp_print_list
            ~pp_sep:(fun fmt () -> Format.fprintf fmt ", ")
            Format.pp_print_int))
      (List.map Set.to_list x)
  in
  let graph =
    [| [ 1; 2 ]; [ 0 ]; [] |] |> Array.map (List.map (fun x -> (Z.zero, Z.zero), x))
  in
  print (reachable_in_range graph 0 0 (Set.singleton 0));
  print (reachable_in_range graph 0 1 (Set.singleton 0));
  print (reachable_in_range graph 2 3 (Set.singleton 1));
  [%expect
    {|
    0
    0; 1, 2
    1, 2; 0
    |}]
;;

let%expect_test "Important verticies smoke test" =
  let module Graph = Graph (Bv) in
  let find_important_verticies = Graph.find_important_verticies in
  let print =
    Format.printf
      "%a\n"
      (Format.pp_print_list
         ~pp_sep:(fun fmt () -> Format.fprintf fmt "; ")
         (fun fmt (a, b) -> Format.fprintf fmt "%d, %d" a b))
  in
  let graph =
    [| [ 1; 2 ]; [ 0 ]; [] |] |> Array.map (List.map (fun x -> (Z.zero, Z.zero), x))
  in
  print (find_important_verticies graph);
  [%expect {|0, 2; 1, 2; 2, 0|}]
;;

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
  val intersect : t -> t -> t
  val unite : t -> t -> t
  val project : int list -> t -> t
  val truncate : int -> t -> t
  val is_graph : t -> bool
  val reenumerate : (int, int) Map.t -> t -> t
  val minimize : t -> t
  val minimize_strong : t -> t
  val invert : t -> t
  val format_nfa : Format.formatter -> t -> unit
  val to_nat : t -> u
  val of_regex : v list Regex.t -> t
  val remove_unreachable_from_final : t -> t
  val find_c_d' : t -> (int * int) Seq.t
  val split : t -> (t * t) list
  val equal_start_and_final : t -> t -> bool
  val alpha : t -> v Set.t
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

type 'a _t =
  { transitions : 'a
  ; final : state Set.t
  ; start : state Set.t
  ; deg : deg
  ; is_dfa : bool
  }

let length nfa = Array.length nfa.transitions
let states nfa = 0 -- (length nfa - 1) |> Set.of_list

module Make
    (Label : L)
    (Invariants : sig
       val update_invariants : (Graph(Label).t _t as 'a) -> 'a
     end) =
struct
  module Graph = Graph (Label)

  type t = Graph.t _t
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
    { transitions; start; final; deg = nfa.deg; is_dfa = false }
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
    let cartesian_product l1 l2 =
      Set.fold
        ~f:(fun x a -> Set.fold ~f:(fun y b -> Set.add y (a, b)) ~init:x l2)
        ~init:Set.empty
        l1
    in
    let counter = ref 0 in
    let visited = Array.make_matrix (length nfa1) (length nfa2) (-1) in
    let q (q1, q2) = visited.(q1).(q2) in
    let is_visited (q1, q2) = q (q1, q2) <> -1 in
    let visit (q1, q2) =
      if is_visited (q1, q2) |> not
      then (
        visited.(q1).(q2) <- !counter;
        counter := !counter + 1)
    in
    let rec aux transitions queue =
      if Queue.is_empty queue
      then transitions
      else (
        let q1, q2 = Queue.pop queue in
        let delta1 = nfa1.transitions.(q1) |> Iter.of_list in
        let delta2 = nfa2.transitions.(q2) |> Iter.of_list in
        let delta =
          Iter.fold
            (fun acc_delta (label1, q1') ->
               Iter.fold
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
        delta :: aux transitions queue)
    in
    let start_pairs = cartesian_product nfa1.start nfa2.start in
    let queue = Queue.create () in
    Set.iter
      ~f:(fun x ->
        visit x;
        Queue.add x queue)
      start_pairs;
    let transitions = aux [] queue |> Array.of_list in
    let start = start_pairs |> Set.map ~f:q in
    let final =
      cartesian_product nfa1.final nfa2.final
      |> Set.map ~f:q
      |> Set.filter ~f:(( <> ) (-1))
    in
    let deg = max nfa1.deg nfa2.deg in
    let is_dfa = nfa1.is_dfa && nfa2.is_dfa in
    { final; start; transitions; deg; is_dfa } |> remove_unreachable_from_final
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
    { start; final; transitions; deg; is_dfa = false }
  ;;

  let is_graph nfa =
    nfa.transitions
    |> Array.for_all (fun delta ->
      List.for_all (fun (label, _) -> Label.is_zero label) delta)
  ;;

  let reenumerate map nfa =
    let transitions =
      nfa.transitions
      |> Array.map (fun delta ->
        List.map (fun (label, q') -> Label.reenumerate map label, q') delta)
    in
    { start = nfa.start
    ; final = nfa.final
    ; transitions
    ; is_dfa = nfa.is_dfa
    ; deg = Map.keys map |> List.fold_left max min_int
    }
  ;;

  let project to_remove nfa =
    let transitions =
      Array.mapi
        (fun q delta ->
           let project (label, q') = Label.project to_remove label, q' in
           List.map project delta)
        nfa.transitions
    in
    { final = nfa.final; start = nfa.start; transitions; deg = nfa.deg; is_dfa = false }
    |> Invariants.update_invariants
  ;;

  let truncate l nfa =
    let transitions = nfa.transitions in
    Array.iteri
      (fun q delta ->
         let truncate (label, q') = Label.truncate l label, q' in
         Array.set transitions q (List.map truncate delta))
      transitions;
    { final = nfa.final; start = nfa.start; transitions; deg = l; is_dfa = false }
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
    { final = nfa.start; start = nfa.final; transitions; deg = nfa.deg; is_dfa = false }
  ;;

  (* Note(Kakadu): it seems to be the slowest function *)
  let to_dfa nfa =
    (* Format.printf "Runinng to_dfa\n%!"; *)
    let alpha =
      nfa.transitions
      |> Array.to_seq
      |> Seq.map List.to_seq
      |> Seq.concat_map Fun.id
      |> Seq.map fst
      |> Seq.map Label.alpha
      |> Seq.fold_left Set.union Set.empty
      |> Set.to_list
    in
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
          counter := !counter + 1;
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
            let variations = Label.variations alpha acc in
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
      (* Format.printf "End to_dfa\n%!"; *)
      { final; start = Set.singleton 0; transitions; deg = nfa.deg; is_dfa = true })
  ;;

  let invert nfa =
    (* We need complete DFA here, to_dfa() makes a complete DFA thus we're using it. *)
    let dfa = nfa |> to_dfa in
    let states = states dfa in
    let final = Set.diff states dfa.final in
    { final
    ; start = dfa.start
    ; transitions = dfa.transitions
    ; deg = dfa.deg
    ; is_dfa = true
    }
  ;;

  let find_c_d nfa (imp : (int, int) Map.t) =
    assert (Set.length nfa.start = 1);
    let n = max 2 (length nfa) in
    let m = n * n in
    let t =
      Graph.reachable_in_range (Graph.reverse nfa.transitions) 0 (m - n - 1) nfa.final
      |> Array.of_list
    in
    let s = Graph.reachable_in_range nfa.transitions 0 m nfa.start in
    let r1 =
      s
      |> List.mapi (fun i set -> if Set.are_disjoint nfa.final set then None else Some i)
      |> List.filter_map Fun.id
      |> Set.of_list
    in
    let states = List.nth s (n - 1) in
    let states =
      states
      |> Set.to_sequence
      |> Sequence.filter_map ~f:(fun state ->
        Map.find imp state |> Option.map (fun d -> state, d))
    in
    let r2 =
      states
      |> Sequence.concat_map ~f:(fun (state, d) ->
        let first = (n * n) - n - d in
        assert (first >= 0);
        let last = (n * n) - n - 1 in
        first -- last
        |> List.filter (fun i -> Set.mem t.(i) state)
        |> List.map (fun c -> c + n - 1, d)
        |> Sequence.of_list)
      |> Sequence.map ~f:(fun (c, d) ->
        let rec helper c = if Set.mem r1 (c - d) then helper (c - d) else c in
        helper c, d)
      |> Sequence.to_list
    in
    let r1 =
      r1
      |> Set.to_list
      |> List.filter (fun c ->
        not (List.exists (fun (c1, d) -> c mod d = c1 mod d && c >= c1) r2))
      |> List.map (fun c -> c, 0)
    in
    r2 @ r1 |> Set.of_list |> Set.to_sequence |> Sequence.to_seq
  ;;

  let find_c_d' nfa =
    find_c_d nfa (Set.to_list nfa.start |> List.map (fun a -> a, 0) |> Map.of_alist_exn)
  ;;

  let split (nfa : t) =
    let length = length nfa in
    let states =
      Graph.reachable_in_range nfa.transitions 0 ((length * length) - 1) nfa.start
      |> List.fold_left (fun acc x -> Set.union acc x) Set.empty
    in
    states
    |> Set.to_list
    |> List.map (fun state ->
      let nfa' =
        { is_dfa = false
        ; deg = nfa.deg
        ; transitions = nfa.transitions
        ; start = nfa.start
        ; final = Set.singleton state
        }
        |> remove_unreachable_from_final
      in
      let nfa'' =
        { is_dfa = false
        ; deg = nfa.deg
        ; transitions = nfa.transitions
        ; start = Set.singleton state
        ; final = nfa.final
        }
        (*|> remove_unreachable_from_start*)
      in
      (* Debug.dump_nfa ~msg:"ONE %s" format_nfa nfa';
      Debug.dump_nfa ~msg:"TWO %s" format_nfa nfa''; *)
      nfa'', nfa')
  ;;

  let equal_start_and_final nfa nfa' =
    Set.equal nfa.start nfa'.start && Set.equal nfa.final nfa'.final
  ;;

  let of_regex (r : Label.u list Regex.t) =
    let rec traverse visited = function
      | [] -> []
      | r :: tl ->
        if List.exists (fun r' -> r' = r) visited
        then traverse visited tl
        else (
          let visited = r :: visited in
          let symbols = Regex.symbols r in
          let delta = List.map (fun symbol -> symbol, Regex.deriv symbol r) symbols in
          let tl = List.append (List.map snd delta) tl in
          (r, delta) :: traverse visited tl)
    in
    let transitions = traverse [] [ r ] in
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
    (*let q =
      let visited = Array.make (length nfa) false in
      let rec dfs len q =
        if visited.(q)
        then None
        else if Set.mem nfa.final q && (nozero |> not || len > 0)
        then Some ([], q, len)
        else (
          if nozero |> not || len > 0 then visited.(q) <- true;
          let delta = Array.get transitions q in
          let qs = delta |> List.map snd in
          match List.find_map (fun q -> dfs (len + 1) q) qs with
          | Some (path, q', len) ->
            Some (List.find (fun (_, q'') -> q' = q'') delta :: path, q, len)
          | None ->
            visited.(q) <- false;
            None)
      in
      nfa.start |> Set.to_list |> List.find_map (dfs 0)
    in*)
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
            begin
              match path' with
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
end

module Lsb (Label : L) = struct
  include
    Make
      (Label)
      (struct
        let update_invariants (nfa : Graph(Label).t _t) =
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
          }
        ;;
      end)

  type u = t

  let zero_any_path = any_path ~nozero:false
  let any_path = any_path ~nozero:false
  let run nfa = any_path nfa [] |> Option.is_some

  let get_exponent_sub_nfa nfa ~(res : deg) ~(temp : deg) =
    let zero_lbl = Label.zero_with_mask [ res; temp ] in
    let res_lbl = Label.singleton_with_mask res [ res; temp ] in
    let pow_lbl = Label.singleton_with_mask temp [ res; temp ] in
    let one_lbl = Label.one_with_mask [ res; temp ] in
    let reversed_transitions = nfa.transitions |> Graph.reverse in
    let end_transitions =
      reversed_transitions
      |> Array.mapi (fun src list ->
        if Set.mem nfa.final src
        then list |> List.filter (fun (lbl, _) -> Label.equal lbl res_lbl)
        else [])
    in
    let pre_final =
      end_transitions |> Array.to_list |> List.concat |> List.map snd |> Set.of_list
    in
    let zero_transitions, states =
      let all_zero_transitions =
        reversed_transitions
        |> Array.map (List.filter (fun (lbl, _) -> Label.equal lbl zero_lbl))
      in
      let rec helper acc visited cur =
        if Set.is_empty cur
        then acc, visited
        else (
          let next_transitions =
            all_zero_transitions
            |> Base.Array.mapi ~f:(fun i x -> if Set.mem cur i then x else [])
          in
          next_transitions
          |> Base.Array.iteri ~f:(fun i list -> acc.(i) <- list @ acc.(i));
          let visited = Set.union visited cur in
          let next =
            Set.diff
              (next_transitions
               |> Array.to_list
               |> List.concat_map (List.map snd)
               |> Set.of_list)
              visited
          in
          helper acc visited next)
      in
      helper (Array.map (Fun.const []) all_zero_transitions) Set.empty pre_final
    in
    let start =
      states
      |> Set.filter ~f:(fun i ->
        reversed_transitions.(i)
        |> List.filter (fun (lbl, _) -> Label.equal lbl pow_lbl)
        |> List.is_empty
        |> not)
    in
    let start_final =
      nfa.final
      |> Set.filter ~f:(fun i ->
        reversed_transitions.(i)
        |> List.filter (fun (lbl, _) -> Label.equal lbl one_lbl)
        |> List.is_empty
        |> not)
    in
    let start = Set.union start start_final in
    let transitions =
      Graph.union_list [ end_transitions; zero_transitions ] |> Graph.reverse
    in
    let result =
      { transitions; final = nfa.final; start; deg = nfa.deg; is_dfa = false }
    in
    result
  ;;

  let chrobak nfa =
    Debug.dump_nfa ~msg:"Chrobak input: %s" format_nfa nfa;
    let important =
      Graph.find_important_verticies nfa.transitions
      |> List.filter (fun (_, b) -> b <> 0)
      |> Map.of_alist_exn
    in
    Debug.printfln
      "important verticies: [%a]"
      (Format.pp_print_list ~pp_sep:Format.pp_print_space (fun fmt (a, b) ->
         Format.fprintf fmt "(%d: %d)" a b))
      (Map.to_alist important);
    let result = find_c_d nfa important in
    (* Debug.printf "Chrobak output: "; *)
    (* Debug.printf *)
    (*   "%a\n" *)
    (*   (Format.pp_print_list *)
    (*      ~pp_sep:(fun fmt () -> Format.fprintf fmt "; ") *)
    (*      (fun fmt (a, b) -> Format.fprintf fmt "(%d, %d)" a b)) *)
    (*   result; *)
    result
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

  let path_of_len (nfa : t) ~vars ~exp total_len : (v list list * int) option =
    Debug.printfln "path_of_len entrance: len=%d%!" total_len;
    Debug.dump_nfa ~msg:"path_of_len nfa: %s" format_nfa nfa;
    let exp_lbl = Label.singleton_with_mask exp [ exp ] in
    let transitions = nfa.transitions in
    let zero_transitions =
      transitions
      |> Array.map (List.filter (fun (lbl, dst) -> not (Label.equal exp_lbl lbl)))
    in
    let start =
      nfa.start |> Set.to_list |> List.map (fun x -> x, []) |> Map.of_alist_exn
    in
    let intermediate =
      if total_len = 0
      then start
      else Graph.all_paths_of_len zero_transitions start (pred total_len)
    in
    Debug.printfln "path_of_len intermediate results:";
    Debug.printfln
      "%a"
      (Format.pp_print_list ~pp_sep:Format.pp_print_newline (fun fmt (a, b) ->
         Format.fprintf
           fmt
           "%d -> [%a]"
           a
           (Format.pp_print_list ~pp_sep:Format.pp_print_space Label.pp)
           b))
      (Map.to_alist intermediate);
    let find_answer map = nfa.final |> Set.to_list |> List.find_map (Map.find map) in
    (if total_len = 0
     then intermediate
     else
       intermediate
       |> Map.to_sequence
       |> Sequence.concat_map ~f:(fun (state, path) ->
         transitions.(state)
         |> Sequence.of_list
         |> Sequence.filter ~f:(fun (lbl, _) -> Label.equal exp_lbl lbl)
         |> Sequence.map ~f:(fun (lbl, state) -> state, lbl :: path))
       |> Map.of_sequence_reduce ~f:Fun.const
       |> Graph.all_paths zero_transitions)
    |> find_answer
    |> Option.map (fun p ->
      let len = List.length p in
      let p = List.rev p in
      Debug.printfln
        "path_of_len: found path of len %d: [%a]"
        len
        (Format.pp_print_list ~pp_sep:Format.pp_print_space Label.pp)
        p;
      ( vars |> List.map (fun var -> List.init len (fun i -> Label.get (List.nth p i) var))
      , len ))
  ;;

  let get_chrobaks_sub_nfas nfa ~res ~temp ~vars ~no_model =
    let temp_lbl = Label.singleton_with_mask temp [ temp ] in
    let exp_nfa = get_exponent_sub_nfa nfa ~res ~temp in
    exp_nfa.start
    |> Set.to_sequence
    |> Sequence.to_seq
    |> Seq.filter_map (fun mid ->
      let* path = zero_any_path { nfa with start = Set.singleton mid } vars in
      let chrobak_nfa =
        { exp_nfa with start = Set.singleton mid } |> remove_unreachable_from_start
      in
      let nfa =
        { nfa with
          final = Set.singleton mid
        ; transitions =
            nfa.transitions
            |> Array.map
                 (List.filter (fun (lbl, fin) -> fin <> mid || Label.equal lbl temp_lbl))
        }
      in
      Debug.printfln "Calculating chrobak for var %d" res;
      Debug.dump_nfa ~msg:"Chrobak input: %s" format_nfa chrobak_nfa;
      Debug.dump_nfa ~msg:"Corresponding nfa: %s" format_nfa nfa;
      let model_piece =
        if no_model then fun _ -> Some ([], 0) else path_of_len chrobak_nfa ~vars ~exp:res
      in
      return (nfa, chrobak chrobak_nfa, model_piece))
  ;;

  let to_nat (nfa : t) : u = nfa

  let combine_model_pieces (model, len1) (model2, len2) =
    (*let len = max len1 len2 in
      let model = List.init len (fun i -> List.nth_opt model i |> Option.value ~default:[]) in
      let model2 = List.init len (fun i -> List.nth_opt model2 i |> Option.value ~default:[]) in*)
    let len = max (List.length model) (List.length model2) in
    let model =
      List.init len (fun i ->
        List.nth_opt model i
        |> Option.value ~default:(List.init len1 (Fun.const Label.u_zero)))
    in
    let model2 =
      List.init len (fun i ->
        List.nth_opt model2 i
        |> Option.value ~default:(List.init len2 (Fun.const Label.u_zero)))
    in
    Base.List.zip_exn model model2 |> List.map (fun (x, y) -> x @ y), len1 + len2
  ;;

  (*let len = max (List.length model) (List.length model2) in
      (List.init len (fun i ->
        let x = List.nth_opt model i |> Option.value ~default:[ Label.u_zero ] in
        let y = List.nth_opt model2 i |> Option.value ~default:[ Label.u_zero ] in *)
  (* ) *)

  let filter_map (nfa : t) (f : Label.t * int -> (Label.t * int) option) =
    { nfa with
      transitions = nfa.transitions |> Array.map (fun delta -> List.filter_map f delta)
    }
  ;;

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
end

module MsbNat (Label : L) = struct
  include
    Make
      (Label)
      (struct
        let update_invariants nfa =
          let filter = fun (lbl, _) -> Label.is_zero lbl in
          let rec helper front visited =
            if Set.is_empty front
            then visited
            else (
              let next =
                front
                |> Set.to_sequence
                |> Sequence.concat_map ~f:(fun state ->
                  nfa.transitions.(state)
                  |> Sequence.of_list
                  |> Sequence.filter ~f:filter
                  |> Sequence.map ~f:snd
                  |> Sequence.filter ~f:(fun state -> not (Set.mem visited state)))
                |> Set.of_sequence
              in
              let visited = Set.union visited front in
              helper next visited)
          in
          let front = nfa.start in
          { nfa with start = helper front Set.empty }
        ;;
      end)

  module Lsb = Lsb (Label)

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

  let minimize_strong nfa = nfa |> reverse |> to_dfa |> reverse |> to_dfa
  let any_path = any_path ~nozero:false
  let run nfa = any_path nfa [] |> Option.is_some

  let get_exponent_sub_nfa nfa ~(res : deg) ~(temp : deg) =
    (*Debug.dump_nfa ~msg:"Exponent sub_nfa input: %s" format_nfa nfa;*)
    let zero_lbl = Label.zero_with_mask [ res; temp ] in
    let res_lbl = Label.singleton_with_mask res [ res; temp ] in
    let pow_lbl = Label.singleton_with_mask temp [ res; temp ] in
    let one_lbl = Label.one_with_mask [ res; temp ] in
    let all_zero_transitions =
      nfa.transitions
      |> Array.map (List.filter (fun (lbl, _) -> Label.equal lbl zero_lbl))
    in
    let find_reachable transitions start =
      let rec helper acc visited cur =
        if Set.is_empty cur
        then acc, visited
        else (
          let next_transitions =
            transitions |> Base.Array.mapi ~f:(fun i x -> if Set.mem cur i then x else [])
          in
          next_transitions
          |> Base.Array.iteri ~f:(fun i list -> acc.(i) <- list @ acc.(i));
          let visited = Set.union visited cur in
          let next =
            Set.diff
              (next_transitions
               |> Array.to_list
               |> List.concat_map (List.map snd)
               |> Set.of_list)
              visited
          in
          helper acc visited next)
      in
      helper (Array.map (Fun.const []) transitions) Set.empty start
    in
    let before_transitions, pre_start = find_reachable all_zero_transitions nfa.start in
    let end_transitions =
      nfa.transitions
      |> Array.mapi (fun src list ->
        if Set.mem pre_start src
        then list |> List.filter (fun (lbl, _) -> Label.equal lbl res_lbl)
        else [])
    in
    let pre_final =
      end_transitions |> Array.to_list |> List.concat |> List.map snd |> Set.of_list
    in
    let zero_transitions, states = find_reachable all_zero_transitions pre_final in
    let start_transitions =
      nfa.transitions
      |> Array.mapi (fun src list ->
        if Set.mem states src
        then list |> List.filter (fun (lbl, _) -> Label.equal lbl pow_lbl)
        else [])
    in
    let start =
      start_transitions
      |> Array.to_list
      |> List.mapi (fun src list -> list |> List.map (fun (lbl, dst) -> dst, (src, lbl)))
      |> List.concat
    in
    let start_final_transitions =
      nfa.transitions
      |> Array.mapi (fun src list ->
        if Set.mem nfa.start src
        then list |> List.filter (fun (lbl, _) -> Label.equal lbl one_lbl)
        else [])
    in
    let start_final =
      start_final_transitions
      |> Array.to_list
      |> List.mapi (fun src list -> list |> List.map (fun (lbl, dst) -> dst, (src, lbl)))
      |> List.concat
    in
    let start = List.concat [ start; start_final ] |> Map.of_alist_multi in
    let transitions =
      Graph.union_list [ start_transitions; start_final_transitions; zero_transitions ]
      |> Graph.reverse
    in
    let result =
      { transitions
      ; final = Set.union pre_final (start_final |> List.map fst |> Set.of_list)
      ; start = Set.empty
      ; deg = nfa.deg
      ; is_dfa = false
      }
    in
    let path_nfa =
      { transitions =
          Graph.union_list [ zero_transitions; end_transitions; before_transitions ]
      ; start = nfa.start
      ; final = Set.empty
      ; deg = nfa.deg
      ; is_dfa = false
      }
    in
    (*Debug.dump_nfa ~msg:"Exponent sub_nfa output: %s" format_nfa result;*)
    result, start, path_nfa
  ;;

  let chrobak nfa =
    Debug.dump_nfa ~msg:"Chrobak input: %s" format_nfa nfa;
    let important =
      Graph.find_important_verticies nfa.transitions
      |> List.filter (fun (_, b) -> b <> 0)
      |> Map.of_alist_exn
    in
    Debug.printfln
      "important verticies: [%a]"
      (Format.pp_print_list ~pp_sep:Format.pp_print_space (fun fmt (a, b) ->
         Format.fprintf fmt "(%d: %d)" a b))
      (Map.to_alist important);
    let result = find_c_d nfa important in
    (* Debug.printf "Chrobak output: "; *)
    (* Debug.printf *)
    (*   "%a\n" *)
    (*   (Format.pp_print_list *)
    (*      ~pp_sep:(fun fmt () -> Format.fprintf fmt "; ") *)
    (*      (fun fmt (a, b) -> Format.fprintf fmt "(%d, %d)" a b)) *)
    (*   result; *)
    result
  ;;

  let path_of_len (nfa : t) ~vars ~exp total_len : (v list list * int) option =
    Debug.printfln "path_of_len entrance: len=%d" total_len;
    Debug.dump_nfa ~msg:"path_of_len nfa: %s" format_nfa nfa;
    let exp_lbl = Label.singleton_with_mask exp [ exp ] in
    let transitions = nfa.transitions in
    let intermediate =
      nfa.start
      |> Set.to_list
      |> List.map (fun x -> x, [])
      |> Map.of_alist_exn
      |> Graph.all_paths
           (transitions
            |> Array.map (List.filter (fun (lbl, dst) -> not (Label.equal exp_lbl lbl))))
    in
    Debug.printfln "path_of_len intermediate results:";
    Debug.printfln
      "%a"
      (Format.pp_print_list ~pp_sep:Format.pp_print_newline (fun fmt (a, b) ->
         Format.fprintf
           fmt
           "%d -> [%a]"
           a
           (Format.pp_print_list ~pp_sep:Format.pp_print_space Label.pp)
           b))
      (Map.to_alist intermediate);
    let find_answer map = nfa.final |> Set.to_list |> List.find_map (Map.find map) in
    (if total_len = 0
     then find_answer intermediate
     else (
       let intermediate =
         intermediate
         |> Map.to_sequence
         |> Sequence.concat_map ~f:(fun (state, path) ->
           transitions.(state)
           |> Sequence.of_list
           |> Sequence.filter ~f:(fun (lbl, _) -> Label.equal exp_lbl lbl)
           |> Sequence.map ~f:(fun (lbl, state) -> state, lbl :: path))
         |> Map.of_sequence_reduce ~f:Fun.const
       in
       Graph.all_paths_of_len transitions intermediate (pred total_len) |> find_answer))
    |> Option.map (fun p ->
      let p = List.rev p in
      let len = List.length p in
      Debug.printfln
        "path_of_len: found path of len %d: [%a]"
        len
        (Format.pp_print_list ~pp_sep:Format.pp_print_space Label.pp)
        p;
      ( vars |> List.map (fun var -> List.init len (fun i -> Label.get (List.nth p i) var))
      , len ))
  ;;

  let get_chrobaks_sub_nfas nfa ~res ~temp ~vars ~no_model =
    match nfa.start |> Set.find ~f:(Fun.const true) with
    | None -> Seq.empty
    | Some nfa_start ->
      let exp_nfa, start, path_nfa = get_exponent_sub_nfa nfa ~res ~temp in
      Debug.dump_nfa ~msg:"exp_nfa: %s" format_nfa exp_nfa;
      start
      |> Map.to_sequence
      |> Sequence.to_seq
      |> Seq.filter_map (fun (mid, lbls) ->
        let chrobak_nfa =
          { exp_nfa with start = Set.singleton mid } |> remove_unreachable_from_start
        in
        let* path =
          any_path { path_nfa with final = lbls |> List.map fst |> Set.of_list } vars
        in
        let transitions = Array.copy nfa.transitions in
        transitions.(nfa_start) <- lbls |> List.map (fun (_, lbl) -> lbl, mid);
        let nfa =
          { nfa with start = Set.singleton nfa_start; transitions }
          |> remove_unreachable_from_start
        in
        Debug.printfln "Calculating chrobak for var %d" res;
        Debug.dump_nfa ~msg:"Chrobak input: %s" format_nfa chrobak_nfa;
        Debug.dump_nfa ~msg:"Corresponding nfa: %s" format_nfa nfa;
        Debug.dump_nfa ~msg:"Corresponding path_nfa: %s" format_nfa path_nfa;
        let model_piece =
          if no_model
          then fun _ -> Some ([], 0)
          else
            path_of_len
              { path_nfa with final = lbls |> List.map fst |> Set.of_list }
              ~vars
              ~exp:res
        in
        return (nfa, chrobak chrobak_nfa, model_piece))
  ;;

  (*let to_nat (nfa : t) : u =
    let zero_lbl = bv_init nfa.deg (Fun.const false), bv_init nfa.deg (Fun.const true) in
    let start =
      nfa.start
      |> Set.to_list
      |> List.concat_map (fun state ->
        nfa.transitions.(state)
        |> List.filter (fun (lbl, _) -> Label.equal lbl zero_lbl)
        |> List.map snd)
      |> Set.of_list
    in
    { nfa with start }
  ;;*)
  let to_nat (nfa : t) : u = nfa

  let combine_model_pieces (model, len1) (model2, len2) : v list list * int =
    let len = max (List.length model) (List.length model2) in
    let model =
      List.init len (fun i ->
        List.nth_opt model i
        |> Option.value ~default:(List.init len1 (Fun.const Label.u_zero)))
    in
    let model2 =
      List.init len (fun i ->
        List.nth_opt model2 i
        |> Option.value ~default:(List.init len2 (Fun.const Label.u_zero)))
    in
    Base.List.zip_exn model model2 |> List.map (fun (x, y) -> y @ x), len1 + len2
  ;;
end

let%expect_test "find_c_d smoke test" =
  let module MsbNat = MsbNat (Bv) in
  let find_c_d = MsbNat.find_c_d in
  let print =
    Format.printf
      "%a\n"
      (Format.pp_print_list
         ~pp_sep:(fun fmt () -> Format.fprintf fmt "; ")
         (fun fmt (a, b) -> Format.fprintf fmt "%d, %d" a b))
  in
  let nfa =
    { transitions =
        [| [ 1; 2 ]; [ 0 ]; [] |] |> Array.map (List.map (fun x -> (Z.zero, Z.zero), x))
    ; start = Set.singleton 0
    ; final = Set.singleton 2
    ; deg = 0
    ; is_dfa = false
    }
  in
  let imp = Map.of_alist_exn [ 0, 2; 1, 2 ] in
  print (find_c_d nfa imp |> List.of_seq);
  [%expect {|1, 2|}]
;;

module Msb (Label : L) = struct
  include
    Make
      (Label)
      (struct
        let update_invariants (nfa : Graph(Label).t _t) =
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

  module MsbNat = MsbNat (Label)

  type u = MsbNat.t

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

  let minimize_strong nfa = nfa |> reverse |> to_dfa |> reverse |> to_dfa

  let any_path nfa =
    Debug.dump_nfa ~msg:"ANY PATH INPUT: %s" format_nfa nfa;
    any_path ~nozero:true nfa
  ;;

  let run nfa = any_path nfa [] |> Option.is_some

  let to_nat (nfa : t) : u =
    let start =
      nfa.start
      |> Set.to_sequence
      |> Sequence.concat_map ~f:(fun state ->
        nfa.transitions.(state)
        |> Sequence.of_list
        |> Sequence.filter ~f:(fun (lbl, _) -> lbl |> Label.is_zero_soft)
        |> Sequence.map ~f:snd)
      |> Set.of_sequence
    in
    { transitions = nfa.transitions
    ; final = nfa.final
    ; start
    ; deg = nfa.deg
    ; is_dfa = nfa.is_dfa
    }
    |> fun nfa ->
    Debug.dump_nfa ~msg:"after to_nat nfa %s" MsbNat.format_nfa nfa;
    nfa
  ;;

  let filter_map (nfa : t) (f : Label.t * int -> (Label.t * int) option) =
    { nfa with
      transitions = nfa.transitions |> Array.map (fun delta -> List.filter_map f delta)
    }
  ;;

  let of_lsb (nfa : Lsb(Label).t) : t =
    { start = nfa.final
    ; is_dfa = false
    ; final = nfa.start
    ; transitions = Graph.reverse nfa.transitions
    ; deg = nfa.deg
    }
  ;;
end
