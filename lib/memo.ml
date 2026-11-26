(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2026, Chrobelias. *)

(* Memo tables for automaton construction. If [x = rename r x'] and the
   builder commutes with [rename], we cache the result for [x'] and rename it
   on every use (see [equivariant]). [-memo-stats] prints hit rates and
   timers. *)

type layer =
  [ `Atoms (* atoms up to a permutation of tracks *)
  | `Consts (* one state space per term, shared by all constants *)
  | `Alpha (* subformulas up to renaming of variables *)
  | `Prims (* powers of two and friends *)
  | `Ops (* intersect/minimize/project keyed by the contents of their inputs *)
  ]

let all_layers = [ `Atoms; `Consts; `Alpha; `Prims; `Ops ]

let layer_of_string = function
  | "atoms" -> [ `Atoms ]
  | "consts" -> [ `Consts ]
  | "alpha" -> [ `Alpha ]
  | "prims" -> [ `Prims ]
  | "ops" -> [ `Ops ]
  | "all" -> all_layers
  | "none" | "" -> []
  | s -> failwith (Printf.sprintf "Unknown memo layer %S" s)
;;

let parse_layers s =
  String.split_on_char ',' s |> List.map String.trim |> List.concat_map layer_of_string
;;

let default_layers : layer list = [ `Consts; `Ops ]

let layers =
  ref
    (match Sys.getenv_opt "CHRO_MEMO" with
     | Some s -> parse_layers s
     | None -> default_layers)
;;

let set_layers s = layers := parse_layers s
let enabled (l : layer) = List.mem l !layers
let stats_enabled = ref (Sys.getenv_opt "CHRO_MEMO_STATS" <> None)

type timer =
  { mutable calls : int
  ; mutable total : float
  ; mutable depth : int (* nested calls are counted once *)
  }

let timers : (string, timer) Hashtbl.t = Hashtbl.create 16

let timer name =
  match Hashtbl.find_opt timers name with
  | Some t -> t
  | None ->
    let t = { calls = 0; total = 0.; depth = 0 } in
    Hashtbl.replace timers name t;
    t
;;

let time name f =
  if not !stats_enabled
  then f ()
  else (
    let t = timer name in
    t.calls <- t.calls + 1;
    if t.depth > 0
    then f ()
    else (
      let start = Unix.gettimeofday () in
      t.depth <- 1;
      Fun.protect
        ~finally:(fun () ->
          t.depth <- 0;
          t.total <- t.total +. (Unix.gettimeofday () -. start))
        f))
;;

let count name n =
  if !stats_enabled
  then (
    let t = timer name in
    t.calls <- t.calls + n)
;;

type stats =
  { name : string
  ; mutable hits : int
  ; mutable misses : int
  ; mutable build_time : float
  ; mutable hit_time : float
  ; mutable evictions : int
  ; mutable size : unit -> int
  }

let all_stats : stats list ref = ref []

module H = Hashtbl.Make (struct
    type t = Obj.t

    (* [=] raises on the comparator closure inside a [Map.Poly.t]. *)
    let equal a b = compare a b = 0
    let hash = Hashtbl.hash_param 64 256
  end)

type ('k, 'v) t =
  { tbl : 'v H.t
  ; stats : stats
  ; cost : 'v -> int
  ; max_cost : int
  ; mutable total_cost : int
  }

let create ?(max_cost = 50_000_000) ?(cost = fun _ -> 1) name : ('k, 'v) t =
  let stats =
    { name
    ; hits = 0
    ; misses = 0
    ; build_time = 0.
    ; hit_time = 0.
    ; evictions = 0
    ; size = (fun () -> 0)
    }
  in
  let tbl = H.create 64 in
  stats.size <- (fun () -> H.length tbl);
  all_stats := stats :: !all_stats;
  { tbl; stats; cost; max_cost; total_cost = 0 }
;;

let clear t =
  H.reset t.tbl;
  t.total_cost <- 0
;;

let now () = if !stats_enabled then Unix.gettimeofday () else 0.

let find (t : ('k, 'v) t) (k : 'k) = H.find_opt t.tbl (Obj.repr k)

let add (t : ('k, 'v) t) (k : 'k) (v : 'v) =
  let c = t.cost v in
  if c <= t.max_cost
  then (
    if t.total_cost + c > t.max_cost
    then (
      clear t;
      t.stats.evictions <- t.stats.evictions + 1);
    t.total_cost <- t.total_cost + c;
    H.replace t.tbl (Obj.repr k) v)
;;

let find_or_build ?(use = Fun.id) (t : ('k, 'v) t) (k : 'k) (build : unit -> 'v) =
  let start = now () in
  match find t k with
  | Some v ->
    let r = use v in
    t.stats.hits <- t.stats.hits + 1;
    t.stats.hit_time <- t.stats.hit_time +. (now () -. start);
    r
  | None ->
    let v = build () in
    add t k v;
    let r = use v in
    t.stats.misses <- t.stats.misses + 1;
    t.stats.build_time <- t.stats.build_time +. (now () -. start);
    r
;;

(* [canon x = (x', r)] with [rename r (build x') = f x]. *)
let equivariant
      (t : ('k, 'v) t)
      ~(canon : 'a -> 'k * 'r)
      ~(build : 'k -> 'v)
      ~(rename : 'r -> 'v -> 'w)
      (x : 'a)
  : 'w
  =
  let k, r = canon x in
  find_or_build t k (fun () -> build k) ~use:(rename r)
;;

(* A digest of a value's contents. The same physical value is often hashed
   many times in a row (one big automaton intersected with many small ones),
   so the last few digests are remembered by physical identity. Only valid
   for values that are never mutated, which holds for automata. *)
let recent = Array.make 16 (Obj.repr 0, "")
let recent_pos = ref 0

let fingerprint (x : 'a) =
  let o = Obj.repr x in
  let rec find i =
    if i = Array.length recent
    then None
    else if fst recent.(i) == o
    then Some (snd recent.(i))
    else find (i + 1)
  in
  match find 0 with
  | Some d -> d
  | None ->
    let d = Digest.string (Marshal.to_string x [ Marshal.No_sharing; Marshal.Closures ]) in
    recent.(!recent_pos) <- o, d;
    recent_pos := (!recent_pos + 1) mod Array.length recent;
    d
;;

let report ppf =
  let open Format in
  fprintf
    ppf
    "memo: layers=[%s]@."
    (!layers
     |> List.map (function
       | `Atoms -> "atoms"
       | `Consts -> "consts"
       | `Alpha -> "alpha"
       | `Prims -> "prims"
       | `Ops -> "ops")
     |> String.concat ",");
  (* Tables with the same name (one per functor instance) are summed. *)
  List.rev !all_stats
  |> List.fold_left
       (fun acc s ->
          match List.find_opt (fun t -> t.name = s.name) acc with
          | None -> acc @ [ { s with name = s.name } ]
          | Some t ->
            t.hits <- t.hits + s.hits;
            t.misses <- t.misses + s.misses;
            t.build_time <- t.build_time +. s.build_time;
            t.hit_time <- t.hit_time +. s.hit_time;
            t.evictions <- t.evictions + s.evictions;
            let size = t.size in
            t.size <- (fun () -> size () + s.size ());
            acc)
       []
  |> List.iter (fun s ->
    if s.hits + s.misses > 0
    then (
      let avg_build = if s.misses = 0 then 0. else s.build_time /. float s.misses in
      let avg_hit = if s.hits = 0 then 0. else s.hit_time /. float s.hits in
      fprintf
        ppf
        "memo-table %-16s hits=%d misses=%d build=%.3fs hit=%.3fs saved~%.3fs size=%d \
         evictions=%d@."
        s.name
        s.hits
        s.misses
        s.build_time
        s.hit_time
        (float s.hits *. (avg_build -. avg_hit))
        (s.size ())
        s.evictions));
  Hashtbl.to_seq timers
  |> List.of_seq
  |> List.sort compare
  |> List.iter (fun (name, t) ->
    fprintf ppf "memo-timer %-16s calls=%d total=%.3fs@." name t.calls t.total)
;;

let () =
  at_exit (fun () -> if !stats_enabled then report Format.err_formatter)
;;
