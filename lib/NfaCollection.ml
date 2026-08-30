(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

module Map = Nfa.Map
module Set = Base.Set.Poly

let trace_log fmt = Debug.trace "nfa_collection" fmt

type varpos = int

module type Type = sig
  type t
  type v

  val n : unit -> t
  val z : unit -> t
  val power_of_two : int -> t
  val eq : (Ir.atom, int) Map.t -> (Ir.atom, Z.t) Map.t -> Z.t -> t
  val neq : (Ir.atom, int) Map.t -> (Ir.atom, Z.t) Map.t -> Z.t -> t
  val leq : (Ir.atom, int) Map.t -> (Ir.atom, Z.t) Map.t -> Z.t -> t

  (** [mod_eq vars term m c] recognises [sum term = c (mod m)]. [m = 0] is
      read as plain equality. *)
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

let gcd a b = Z.gcd a b
(*if a < zero || b < zero then gcd (abs a) (abs b) else if b = zero then a else gcd b (a mod b)*)

let ( -- ) i j =
  let rec aux n acc = if n < i then acc else aux (n - 1) (n :: acc) in
  aux j []
;;

(* ------------------------------------------------------------- *)
(* ------------------ Congruence ("divides") ------------------- *)
(* ------------------------------------------------------------- *)

(* The constructions below recognise the solutions of

     sum_i a_i * x_i  =  c   (mod m),     m > 0

   as number decision diagrams, in the style of Boigelot and Wolper ("An
   Automata-Theoretic Approach to Presburger Arithmetic Constraints", SAS'95,
   and Boigelot, "Symbolic Methods for Exploring Infinite State Spaces",
   ch. 5, where congruences are Algorithm 3 alongside the equation/inequation
   ones already implemented as [eq] and [leq] here).

   Having a dedicated construction matters a lot.  Encoding [t = c (mod m)] as
   [exists q. t - m * q = c] -- which is what lowering [mod] to an equation
   does -- introduces a fresh *unbounded* variable, i.e. one more automaton
   track plus a projection that has to determinise.  A congruence, on the
   other hand, only ever needs a residue to be remembered, so its state space
   is bounded a priori: [m] states reading most-significant digit first, and
   [(e + 1) * m] reading least-significant digit first (see [split_modulus]).

   Both automata are deterministic -- every digit vector has exactly one
   successor -- which keeps the subsequent intersections cheap. *)

(* Explore the reachable part of a deterministic transition system whose
   alphabet is [thing], a list of (digit vector, weighted digit sum) pairs,
   and renumber the reachable states as consecutive integers.  Returns the
   renumbered transitions, the state->index map, and the lookup itself. *)
let explore_det ~start ~step ~thing =
  let seen = ref Map.empty in
  let transitions = ref [] in
  let rec lp = function
    | [] -> ()
    | st :: tl when Map.mem !seen st -> lp tl
    | st :: tl ->
      seen := Map.set !seen ~key:st ~data:(Map.length !seen);
      let succs = List.map (fun (digits, s) -> digits, step st s) thing in
      transitions
      := List.fold_left (fun acc (d, dst) -> (st, d, dst) :: acc) !transitions succs;
      lp (List.fold_left (fun acc (_, dst) -> dst :: acc) tl succs)
  in
  lp [ start ];
  let seen = !seen in
  let idx st = Map.find_exn seen st in
  List.map (fun (a, d, b) -> idx a, d, idx b) !transitions, seen, idx
;;

(* Most-significant-digit-first.  Appending a digit vector of weighted sum [s]
   maps the value [v] read so far to [v * base + s], so carrying [v mod m] is
   enough: at most [m] states, for any [base] -- no coprimality needed.  In
   the two's-complement encoding of the [Msb] modules the leading digit has a
   *negative* weight, hence the distinguished initial state [None] out of
   which the first digit lands on [-s]. *)
let mod_eq_msb_parts ~base ~m ~c ~thing =
  let c = Z.erem c m in
  let step st s =
    match st with
    | None -> Some (Z.erem (Z.neg s) m)
    | Some v -> Some (Z.erem Z.((v * base) + s) m)
  in
  let transitions, seen, idx = explore_det ~start:None ~step ~thing in
  let finals = Map.find seen (Some c) |> Option.to_list in
  transitions, [ idx None ], finals
;;

(* [split_modulus ~base m] factors [m = mb * mc] so that every prime factor of
   [mb] divides [base] while [gcd (mc, base) = 1], and returns the least [e]
   with [mb | base^e].  The factors are coprime, so by CRT a congruence modulo
   [m] is the conjunction of the ones modulo [mb] and modulo [mc]. *)
let split_modulus ~base m =
  let rec strip mc =
    let g = Z.gcd mc base in
    if Z.equal g Z.one then mc else strip Z.(mc / g)
  in
  let mc = strip m in
  let mb = Z.(m / mc) in
  let rec expo e p = if Z.(erem p mb = zero) then e else expo (e + 1) Z.(p * base) in
  let e = if Z.equal mb Z.one then 0 else expo 0 Z.one in
  mb, mc, e
;;

(* Least-significant-digit-first.  Split the number being read as
   [V_j + base^j * R_j]: the digits already consumed, and the ones still to
   come.  Against the two coprime factors of [m]:

   - modulo [mb], [base^j = 0] as soon as [j >= e], so only the [e] lowest
     digits can ever matter; we accumulate [v = V_j mod mb] forwards and
     freeze it at [j = e];
   - modulo [mc] the base is invertible, which lets us carry instead the
     residue [k] that the *unread* part is required to have.  Expanding
     [R_j = s + base * R_(j+1)] gives [k' = (k - s) * base^-1 (mod mc)].
     This is the "residual" state, and it costs [mc] states -- against the
     [mc * |{base^j mod mc}|] that a naive (value, weight) pair would need,
     which for e.g. [m = 67], [base = 2] is 67 states instead of 67*66.

   The word ends with the unread part equal to zero, so the accepting states
   are exactly those with [k = 0] and [v = c (mod mb)]. *)
let mod_eq_lsb_parts ~base ~m ~c ~thing =
  let mb, mc, e = split_modulus ~base m in
  let binv = if Z.equal mc Z.one then Z.one else Z.invert base mc in
  let cb = Z.erem c mb
  and cc = Z.erem c mc in
  let pow_mb = Array.init (max e 1) (fun j -> Z.erem (Z.pow base j) mb) in
  let step (j, v, k) s =
    ( (if j < e then j + 1 else j)
    , (if j < e then Z.erem Z.(v + (s * pow_mb.(j))) mb else v)
    , Z.erem Z.((k - s) * binv) mc )
  in
  let start = 0, Z.zero, cc in
  let transitions, seen, idx = explore_det ~start ~step ~thing in
  let finals =
    Map.to_alist seen
    |> List.filter_map (fun ((_, v, k), i) ->
      if Z.equal v cb && Z.equal k Z.zero then Some i else None)
  in
  transitions, [ idx start ], finals
;;

(* Normalise a congruence's left-hand side: reduce every coefficient modulo
   [m] (this only shifts the weighted digit sums by multiples of [m], which is
   invisible to the automaton) and drop the ones that vanish, since a variable
   with coefficient [0 (mod m)] cannot influence the congruence.  Dropping
   them shrinks the alphabet, which is the dominant cost. *)
let mod_eq_prepare vars term m =
  Map.map_keys_exn ~f:(Map.find_exn vars) term
  |> Map.to_alist
  |> List.filter_map (fun (v, a) ->
    let a = Z.erem a m in
    if Z.equal a Z.zero then None else Some (v, a))
;;

(* ------------------------------------------------------------- *)
(* ------------------------- MSB types ------------------------- *)
(* ------------------------------------------------------------- *)

module Msb = struct
  module Bv = Nfa.Bv
  module Nfa = Nfa.Msb (Bv)

  type t = Nfa.t
  type v = bool

  let base = Bv.base
  let o = false
  let i = true

  let n () =
    Nfa.create_nfa ~transitions:[ 0, [], 0 ] ~start:[ 0 ] ~final:[ 0 ] ~vars:[] ~deg:1
  ;;

  let z () = Nfa.create_nfa ~transitions:[] ~start:[ 0 ] ~final:[] ~vars:[] ~deg:1

  let power_of_two exp =
    Nfa.create_nfa
      ~transitions:[ 0, [ o ], 0; 0, [ i ], 1; 1, [ o ], 1; 2, [ o ], 0 ]
      ~start:[ 2 ]
      ~final:[ 1 ]
      ~vars:[ exp ]
      ~deg:(exp + 1)
  ;;

  let div_ a b = if Z.(a mod b >= zero) then Z.(a / b) else Z.((a / b) - one)

  let powerset term =
    let rec helper = function
      | [] -> []
      | [ x ] -> [ [ o ], [ Z.zero ]; [ i ], [ x ] ]
      | hd :: tl ->
        let open Base.List.Let_syntax in
        let ( let* ) = ( >>= ) in
        let* n, thing = helper tl in
        [ o :: n, Z.zero :: thing; i :: n, hd :: thing ]
    in
    term
    |> List.map snd
    |> helper
    |> List.map (fun (a, x) -> a, Base.List.sum (module Z) ~f:Fun.id x)
  ;;

  let eq vars term c =
    let term =
      Map.map_keys_exn ~f:(Map.find_exn vars) term
      |> Map.to_alist
      |> List.filter (fun (_, v) -> Z.(v <> zero))
    in
    let gcd_ = List.fold_left (fun acc (_, data) -> gcd data acc) Z.zero term in
    if gcd_ = Z.zero
    then if Z.(zero = c) then n () else z ()
    else (
      let thing = powerset term in
      let states = ref Set.empty in
      let transitions = ref [] in
      let rec lp front =
        match front with
        | [] -> ()
        | hd :: tl ->
          if Set.mem !states hd
          then lp tl
          else begin
            let t =
              thing
              |> List.filter (fun (_, sum) -> Z.((hd - sum) mod (base * gcd_) = zero))
              |> List.map (fun (bits, sum) -> Z.(div_ (hd - sum) base), bits, hd)
            in
            states := Set.add !states hd;
            transitions := t @ !transitions;
            lp (List.map (fun (x, _, _) -> x) t @ tl)
          end
      in
      lp [ c ];
      let states = Set.to_list !states in
      let start = List.length states in
      let states = states |> List.mapi (fun i x -> x, i) |> Map.of_alist_exn in
      let idx c = Map.find states c |> Option.get in
      let transitions = List.map (fun (a, b, c) -> idx a, b, idx c) !transitions in
      let transitions =
        (thing
         |> List.filter_map (fun (d, sum) ->
           match Map.find states Z.(-sum) with
           | None -> None
           | Some v -> Some (start, d, v)))
        @ transitions
      in
      Nfa.create_nfa
        ~transitions
        ~start:[ start ]
        ~final:[ idx c ]
        ~vars:(List.map fst term)
        ~deg:(1 + List.fold_left Int.max 0 (List.map fst term))
      |> fun x -> x)
  ;;

  let neq vars term c = eq vars term c |> Nfa.invert

  let leq vars term c =
    let term =
      Map.map_keys_exn ~f:(Map.find_exn vars) term
      |> Map.to_alist
      |> List.filter (fun (_, v) -> Z.(v <> zero))
    in
    let gcd_ = List.fold_left (fun acc (_, data) -> gcd data acc) Z.zero term in
    if Z.(gcd_ = zero)
    then if Z.(zero <= c) then n () else z ()
    else
      (let thing = powerset term in
       let states = ref Set.empty in
       let transitions = ref [] in
       let rec lp front =
         match front with
         | [] -> ()
         | hd :: tl ->
           if Set.mem !states hd
           then lp tl
           else begin
             let t =
               thing
               |> List.map (fun (bits, sum) ->
                 Z.(gcd_ * div_ (hd - sum) (base * gcd_)), bits, hd)
             in
             states := Set.add !states hd;
             transitions := t @ !transitions;
             lp (List.map (fun (x, _, _) -> x) t @ tl)
           end
       in
       lp [ c ];
       let states = Set.to_list !states in
       let start = List.length states in
       let states = states |> List.mapi (fun i x -> x, i) |> Map.of_alist_exn in
       let idx c = Map.find states c |> Option.get in
       let transitions = List.map (fun (a, b, c) -> idx a, b, idx c) !transitions in
       let transitions =
         (thing
          |> List.concat_map (fun (d, sum) ->
            Map.to_alist states
            |> List.filter_map (fun (v, idv) ->
              if Z.(-sum <= v) then Some (start, d, idv) else None)))
         @ transitions
       in
       Nfa.create_nfa
         ~transitions
         ~start:[ start ]
         ~final:(states |> Map.filter_keys ~f:(fun x -> x <= c) |> Map.data)
         ~vars:(List.map fst term)
         ~deg:(1 + List.fold_left Int.max 0 (List.map fst term))
       |> fun x -> x)
      |> Nfa.minimize_strong
  ;;

  let mod_eq vars term m c =
    let m = Z.abs m in
    if Z.(equal m zero)
    then eq vars term c
    else if Z.(equal m one)
    then n ()
    else (
      match mod_eq_prepare vars term m with
      | [] -> if Z.(erem c m = zero) then n () else z ()
      | term ->
        let thing = powerset term in
        let transitions, start, final = mod_eq_msb_parts ~base ~m ~c ~thing in
        Nfa.create_nfa
          ~transitions
          ~start
          ~final
          ~vars:(List.map fst term)
          ~deg:(1 + List.fold_left Int.max 0 (List.map fst term)))
  ;;

  (* Remark by Bernard Boigelot from "Symbolic methods and automata":

  An important difference between Algorithm 1 and Algorithm 2 is that the latter
  generally produces nondeterministic NDD. This may be problematic in some applications,
  in particular if automata need to be minimised in order to obtain canonical set
  representations.*)
  let strlen ~alpha ~(dest : int) ~(src : int) () =
    failwith "Unimplemented for string bitvectors"
  ;;

  let strlen_const ~alpha specs =
    ignore (alpha, specs);
    failwith "Unimplemented for string bitvectors"
  ;;
end

module MsbStr (B : Nfa.Base) = struct
  module Str = Nfa.Str (B)

  type t = Nfa.Msb(Nfa.Str(B)).t
  type v = Str.u

  (* OCaml handles this strange if we use module Nfa = <alias> *)
  module Nfa = struct
    include Nfa.Msb (Nfa.Str (B))
  end

  let o = Str.u_zero
  let i = Str.u_one
  let base = Str.base
  let basei = Z.to_int base
  let alphabet = Str.alphabet |> List.to_seq |> Seq.take basei |> List.of_seq
  let () = assert (List.nth alphabet 0 = Str.u_zero)
  let itoc i = List.nth alphabet i

  let n () =
    Nfa.create_nfa ~transitions:[ 0, [], 0 ] ~start:[ 0 ] ~final:[ 0 ] ~vars:[] ~deg:1
  ;;

  let z () = Nfa.create_nfa ~transitions:[] ~start:[ 0 ] ~final:[] ~vars:[] ~deg:1

  let power_of_two exp =
    Nfa.create_nfa
      ~transitions:
        [ 0, [ o ], 0; 0, [ Str.u_eos ], 0; 0, [ o ], 1; 1, [ i ], 2; 2, [ o ], 2 ]
      ~start:[ 0 ]
      ~final:[ 2 ]
      ~vars:[ exp ]
      ~deg:(exp + 1)
  ;;

  let powerset digits term =
    let rec helper = function
      | [] -> []
      | [ x ] ->
        ([ Str.u_eos ], [ Z.zero ])
        :: (digits |> List.map (fun c -> [ itoc c ], [ Z.(x * of_int c) ]))
      | hd :: tl ->
        let open Base.List.Let_syntax in
        let ( let* ) = ( >>= ) in
        let* n, thing = helper tl in
        (Str.u_eos :: n, Z.zero :: thing)
        :: (digits |> List.map (fun c -> itoc c :: n, Z.(hd * of_int c) :: thing))
    in
    term
    |> List.map snd
    |> helper
    |> List.map (fun (a, x) -> a, Base.List.sum (module Z) ~f:Fun.id x)
  ;;

  let div_ a b = if Z.(a mod b >= zero) then Z.(a / b) else Z.((a / b) - one)

  let eq vars term c =
    let term =
      Map.map_keys_exn ~f:(Map.find_exn vars) term
      |> Map.to_alist
      |> List.filter (fun (_, v) -> Z.(v <> zero))
    in
    let gcd_ = List.fold_left (fun acc (_, data) -> gcd data acc) Z.zero term in
    if gcd_ = Z.zero
    then if Z.(zero = c) then n () else z ()
    else (
      let states = ref Set.empty in
      let transitions = ref [] in
      let thing = powerset (0 -- (basei - 1)) term in
      let rec lp front =
        match front with
        | s when Set.is_empty s -> ()
        | s ->
          let hd = Set.nth s 0 |> Option.get in
          let tl = Set.remove_index s 0 in
          if Set.mem !states hd
          then lp tl
          else begin
            let t =
              thing
              |> List.filter (fun (_, sum) -> Z.((hd - sum) mod (base * gcd_) = zero))
              |> List.map (fun (bits, sum) -> Z.(div_ (hd - sum) base), bits, hd)
            in
            states := Set.add !states hd;
            transitions := t @ !transitions;
            lp (Set.union (List.map (fun (x, _, _) -> x) t |> Set.of_list) tl)
          end
      in
      lp (Set.singleton c);
      let states = Set.to_list !states in
      let start = List.length states in
      let states = states |> List.mapi (fun i x -> x, i) |> Map.of_alist_exn in
      let idx c = Map.find states c |> Option.get in
      let transitions = List.map (fun (a, b, c) -> idx a, b, idx c) !transitions in
      let transitions =
        (powerset [ 0; basei - 1 ] term
         |> List.filter_map (fun (d, sum) ->
           match Map.find states Z.(sum / (one - base)) with
           | None -> None
           | Some v -> Some (start, d, v)))
        @ transitions
      in
      Nfa.create_nfa
        ~transitions
        ~start:[ start ]
        ~final:[ idx c ]
        ~vars:(List.map fst term)
        ~deg:(1 + List.fold_left Int.max 0 (List.map fst term))
      |> fun x -> x)
  ;;

  let neq vars term c = eq vars term c |> Nfa.invert

  let leq vars term c =
    let term =
      Map.map_keys_exn ~f:(Map.find_exn vars) term
      |> Map.to_alist
      |> List.filter (fun (_, v) -> Z.(v <> zero))
    in
    let gcd_ = List.fold_left (fun acc (_, data) -> gcd data acc) Z.zero term in
    if Z.(gcd_ = zero)
    then if Z.(zero <= c) then n () else z ()
    else
      (let states = ref Set.empty in
       let transitions = ref [] in
       let thing = powerset (0 -- (basei - 1)) term in
       let rec lp front =
         match front with
         | s when Set.is_empty s -> ()
         | s ->
           let hd = Set.nth s 0 |> Option.get in
           let tl = Set.remove_index s 0 in
           if Set.mem !states hd
           then lp tl
           else begin
             let t =
               thing
               |> List.map (fun (bits, sum) ->
                 Z.(gcd_ * div_ (hd - sum) (base * gcd_)), bits, hd)
             in
             states := Set.add !states hd;
             transitions := t @ !transitions;
             lp (Set.union (List.map (fun (x, _, _) -> x) t |> Set.of_list) tl)
           end
       in
       lp (Set.singleton c);
       let states = Set.to_list !states in
       let start = List.length states in
       let states = states |> List.mapi (fun i x -> x, i) |> Map.of_alist_exn in
       let idx c = Map.find states c |> Option.get in
       let transitions = List.map (fun (a, b, c) -> idx a, b, idx c) !transitions in
       let transitions =
         (powerset [ 0; basei - 1 ] term
          |> List.concat_map (fun (d, sum) ->
            Map.to_alist states
            |> List.filter_map (fun (v, idv) ->
              if Z.(sum / (one - base) <= v) then Some (start, d, idv) else None)))
         @ transitions
       in
       Nfa.create_nfa
         ~transitions
         ~start:[ start ]
         ~final:(states |> Map.filter_keys ~f:(fun x -> x <= c) |> Map.data)
         ~vars:(List.map fst term)
         ~deg:(1 + List.fold_left Int.max 0 (List.map fst term))
       |> fun x -> x)
      |> Nfa.minimize_not_very_strong
  ;;

  let mod_eq vars term m c =
    let m = Z.abs m in
    if Z.(equal m zero)
    then eq vars term c
    else if Z.(equal m one)
    then n ()
    else (
      match mod_eq_prepare vars term m with
      | [] -> if Z.(erem c m = zero) then n () else z ()
      | term ->
        let thing = powerset (0 -- (basei - 1)) term in
        let transitions, start, final = mod_eq_msb_parts ~base ~m ~c ~thing in
        Nfa.create_nfa
          ~transitions
          ~start
          ~final
          ~vars:(List.map fst term)
          ~deg:(1 + List.fold_left Int.max 0 (List.map fst term)))
  ;;

  let strlen ~alpha ~(dest : int) ~(src : int) () =
    let alpha = Option.value ~default:alphabet alpha in
    let alpha_transitions = List.map (fun c -> 0, [ c; Str.u_zero ], 0) alpha in
    let transitions =
      alpha_transitions @ [ 1, [ Str.u_eos; i ], 0 ] @ [ 1, [ Str.u_eos; Str.u_zero ], 1 ]
    in
    Nfa.create_nfa ~transitions ~start:[ 1 ] ~final:[ 0 ] ~vars:[ src; dest ] ~deg:2
  ;;

  let strlen_const ~alpha specs =
    let alpha = Option.value ~default:alphabet alpha in
    let specs =
      Base.List.dedup_and_sort ~compare:Stdlib.compare specs
      |> List.sort (fun (_, a) (_, b) -> Stdlib.compare b a)
    in
    let tracks = List.map fst specs in
    if Base.List.contains_dup tracks ~compare:Stdlib.compare
    then (* the same string pinned to two different lengths *) z ()
    else if List.is_empty specs
    then n ()
    else (
      let lens = List.map snd specs in
      let maxn = List.fold_left max 0 lens in
      (* State [s]: the longest string has consumed [s] characters. Msb
       strings are end-anchored (chars run to the word end behind the eos
       padding), so their mutual offsets are rigid: one linear chain of
       [maxn] steps replaces the quadratic product of per-string chains
       that made the reconstruction blow past the size limit. A string of
       length [n] is still padding while [s < maxn - n]. *)
      let rec combos = function
        | [] -> [ [] ]
        | `Any :: tl ->
          List.concat_map (fun c -> List.map (fun rest -> c :: rest) (combos tl)) alpha
        | `Eos :: tl -> List.map (fun rest -> Str.u_eos :: rest) (combos tl)
      in
      (* Chain position [p] lives in state [p + 1]: state 0 is the padding
         loop, and the only way into the chain is the all-eos boundary step
         0 -> 1. The Msb invariant closure shortcuts equal-label runs that
         start AT the start state -- char steps hanging directly off the
         start would let a run of equal characters skip chain positions and
         void the length pin (observed: a 5031-pin accepting a ~1000-char
         string zero-padded by the printer). Behind the eos boundary the
         char runs are not start-adjacent, so the closure only ever adds
         harmless pad-to-boundary jumps, exactly like [strlen]'s own
         eos-labelled boundary. *)
      let step p =
        lens
        |> List.map (fun n -> if p >= maxn - n then `Any else `Eos)
        |> combos
        |> List.map (fun l -> p + 1, l, p + 2)
      in
      let all_eos = List.map (Fun.const Str.u_eos) lens in
      let pad = 0, all_eos, 0 in
      let boundary = 0, all_eos, 1 in
      let transitions = pad :: boundary :: List.concat_map step (List.init maxn Fun.id) in
      Nfa.create_nfa
        ~transitions
        ~start:[ 0 ]
        ~final:[ maxn + 1 ]
        ~vars:tracks
        ~deg:(List.length tracks))
  ;;
end

module MsbStrBv (B : Nfa.Base) = struct
  module Str = Nfa.StrBv (B)

  type t = Nfa.Msb(Nfa.StrBv(B)).t
  type v = Str.u

  (* OCaml handles this strange if we use module Nfa = <alias> *)
  module Nfa = struct
    include Nfa.Msb (Nfa.StrBv (B))
  end

  let o = Str.u_zero
  let i = Str.u_one
  let base = Str.base
  let basei = Z.to_int base
  let alphabet = Str.alphabet |> List.to_seq |> Seq.take basei |> List.of_seq
  let () = assert (List.nth alphabet 0 = Str.u_zero)
  let itoc i = List.nth alphabet i

  let n () =
    Nfa.create_nfa ~transitions:[ 0, [], 0 ] ~start:[ 0 ] ~final:[ 0 ] ~vars:[] ~deg:1
  ;;

  let z () = Nfa.create_nfa ~transitions:[] ~start:[ 0 ] ~final:[] ~vars:[] ~deg:1

  let power_of_two exp =
    Nfa.create_nfa
      ~transitions:
        [ 0, [ o ], 0; 0, [ Str.u_eos ], 0; 0, [ o ], 1; 1, [ i ], 2; 2, [ o ], 2 ]
      ~start:[ 0 ]
      ~final:[ 2 ]
      ~vars:[ exp ]
      ~deg:(exp + 1)
  ;;

  let powerset digits term =
    let rec helper = function
      | [] -> []
      | [ x ] ->
        ([ Str.u_eos ], [ Z.zero ])
        :: (digits |> List.map (fun c -> [ itoc c ], [ Z.(x * of_int c) ]))
      | hd :: tl ->
        let open Base.List.Let_syntax in
        let ( let* ) = ( >>= ) in
        let* n, thing = helper tl in
        (Str.u_eos :: n, Z.zero :: thing)
        :: (digits |> List.map (fun c -> itoc c :: n, Z.(hd * of_int c) :: thing))
    in
    term
    |> List.map snd
    |> helper
    |> List.map (fun (a, x) -> a, Base.List.sum (module Z) ~f:Fun.id x)
  ;;

  let div_ a b = if Z.(a mod b >= zero) then Z.(a / b) else Z.((a / b) - one)

  let eq vars term c =
    let term =
      Map.map_keys_exn ~f:(Map.find_exn vars) term
      |> Map.to_alist
      |> List.filter (fun (_, v) -> Z.(v <> zero))
    in
    let gcd_ = List.fold_left (fun acc (_, data) -> gcd data acc) Z.zero term in
    if gcd_ = Z.zero
    then if Z.(zero = c) then n () else z ()
    else (
      let states = ref Set.empty in
      let transitions = ref [] in
      let thing = powerset (0 -- (basei - 1)) term in
      let rec lp front =
        match front with
        | s when Set.is_empty s -> ()
        | s ->
          let hd = Set.nth s 0 |> Option.get in
          let tl = Set.remove_index s 0 in
          if Set.mem !states hd
          then lp tl
          else begin
            let t =
              thing
              |> List.filter (fun (_, sum) -> Z.((hd - sum) mod (base * gcd_) = zero))
              |> List.map (fun (bits, sum) -> Z.(div_ (hd - sum) base), bits, hd)
            in
            states := Set.add !states hd;
            transitions := t @ !transitions;
            lp (Set.union (List.map (fun (x, _, _) -> x) t |> Set.of_list) tl)
          end
      in
      lp (Set.singleton c);
      let states = Set.to_list !states in
      let start = List.length states in
      let states = states |> List.mapi (fun i x -> x, i) |> Map.of_alist_exn in
      let idx c = Map.find states c |> Option.get in
      let transitions = List.map (fun (a, b, c) -> idx a, b, idx c) !transitions in
      let transitions =
        (powerset [ 0; basei - 1 ] term
         |> List.filter_map (fun (d, sum) ->
           match Map.find states Z.(sum / (one - base)) with
           | None -> None
           | Some v -> Some (start, d, v)))
        @ transitions
      in
      Nfa.create_nfa
        ~transitions
        ~start:[ start ]
        ~final:[ idx c ]
        ~vars:(List.map fst term)
        ~deg:(1 + List.fold_left Int.max 0 (List.map fst term))
      |> fun x -> x)
  ;;

  let neq vars term c = eq vars term c |> Nfa.invert

  let leq vars term c =
    let term =
      Map.map_keys_exn ~f:(Map.find_exn vars) term
      |> Map.to_alist
      |> List.filter (fun (_, v) -> Z.(v <> zero))
    in
    let gcd_ = List.fold_left (fun acc (_, data) -> gcd data acc) Z.zero term in
    if Z.(gcd_ = zero)
    then if Z.(zero <= c) then n () else z ()
    else
      (let states = ref Set.empty in
       let transitions = ref [] in
       let thing = powerset (0 -- (basei - 1)) term in
       let rec lp front =
         match front with
         | s when Set.is_empty s -> ()
         | s ->
           let hd = Set.nth s 0 |> Option.get in
           let tl = Set.remove_index s 0 in
           if Set.mem !states hd
           then lp tl
           else begin
             let t =
               thing
               |> List.map (fun (bits, sum) ->
                 Z.(gcd_ * div_ (hd - sum) (base * gcd_)), bits, hd)
             in
             states := Set.add !states hd;
             transitions := t @ !transitions;
             lp (Set.union (List.map (fun (x, _, _) -> x) t |> Set.of_list) tl)
           end
       in
       lp (Set.singleton c);
       let states = Set.to_list !states in
       let start = List.length states in
       let states = states |> List.mapi (fun i x -> x, i) |> Map.of_alist_exn in
       let idx c = Map.find states c |> Option.get in
       let transitions = List.map (fun (a, b, c) -> idx a, b, idx c) !transitions in
       let transitions =
         (powerset [ 0; basei - 1 ] term
          |> List.concat_map (fun (d, sum) ->
            Map.to_alist states
            |> List.filter_map (fun (v, idv) ->
              if Z.(sum / (one - base) <= v) then Some (start, d, idv) else None)))
         @ transitions
       in
       Nfa.create_nfa
         ~transitions
         ~start:[ start ]
         ~final:(states |> Map.filter_keys ~f:(fun x -> x <= c) |> Map.data)
         ~vars:(List.map fst term)
         ~deg:(1 + List.fold_left Int.max 0 (List.map fst term))
       |> fun x -> x)
      |> Nfa.minimize_not_very_strong
  ;;

  let mod_eq vars term m c =
    let m = Z.abs m in
    if Z.(equal m zero)
    then eq vars term c
    else if Z.(equal m one)
    then n ()
    else (
      match mod_eq_prepare vars term m with
      | [] -> if Z.(erem c m = zero) then n () else z ()
      | term ->
        let thing = powerset (0 -- (basei - 1)) term in
        let transitions, start, final = mod_eq_msb_parts ~base ~m ~c ~thing in
        Nfa.create_nfa
          ~transitions
          ~start
          ~final
          ~vars:(List.map fst term)
          ~deg:(1 + List.fold_left Int.max 0 (List.map fst term)))
  ;;

  let strlen ~alpha ~(dest : int) ~(src : int) () =
    let alpha = Option.value ~default:alphabet alpha in
    let alpha_transitions = List.map (fun c -> 0, [ c; Str.u_zero ], 0) alpha in
    let transitions =
      alpha_transitions
      @ [ 1, [ Str.u_eos; i ], 0 ]
      @ [ 1, [ Str.u_eos; Str.u_zero ], 1; 1, [ Str.u_eos; Str.u_eos ], 1 ]
    in
    Nfa.create_nfa ~transitions ~start:[ 1 ] ~final:[ 0 ] ~vars:[ src; dest ] ~deg:2
  ;;

  let strlen_const ~alpha specs =
    let alpha = Option.value ~default:alphabet alpha in
    let specs =
      Base.List.dedup_and_sort ~compare:Stdlib.compare specs
      |> List.sort (fun (_, a) (_, b) -> Stdlib.compare b a)
    in
    let tracks = List.map fst specs in
    if Base.List.contains_dup tracks ~compare:Stdlib.compare
    then (* the same string pinned to two different lengths *) z ()
    else if List.is_empty specs
    then n ()
    else (
      let lens = List.map snd specs in
      let maxn = List.fold_left max 0 lens in
      (* State [s]: the longest string has consumed [s] characters. Msb
       strings are end-anchored (chars run to the word end behind the eos
       padding), so their mutual offsets are rigid: one linear chain of
       [maxn] steps replaces the quadratic product of per-string chains
       that made the reconstruction blow past the size limit. A string of
       length [n] is still padding while [s < maxn - n]. *)
      let rec combos = function
        | [] -> [ [] ]
        | `Any :: tl ->
          List.concat_map (fun c -> List.map (fun rest -> c :: rest) (combos tl)) alpha
        | `Eos :: tl -> List.map (fun rest -> Str.u_eos :: rest) (combos tl)
      in
      (* Chain position [p] lives in state [p + 1]: state 0 is the padding
         loop, and the only way into the chain is the all-eos boundary step
         0 -> 1. The Msb invariant closure shortcuts equal-label runs that
         start AT the start state -- char steps hanging directly off the
         start would let a run of equal characters skip chain positions and
         void the length pin (observed: a 5031-pin accepting a ~1000-char
         string zero-padded by the printer). Behind the eos boundary the
         char runs are not start-adjacent, so the closure only ever adds
         harmless pad-to-boundary jumps, exactly like [strlen]'s own
         eos-labelled boundary. *)
      let step p =
        lens
        |> List.map (fun n -> if p >= maxn - n then `Any else `Eos)
        |> combos
        |> List.map (fun l -> p + 1, l, p + 2)
      in
      let all_eos = List.map (Fun.const Str.u_eos) lens in
      let pad = 0, all_eos, 0 in
      let boundary = 0, all_eos, 1 in
      let transitions = pad :: boundary :: List.concat_map step (List.init maxn Fun.id) in
      Nfa.create_nfa
        ~transitions
        ~start:[ 0 ]
        ~final:[ maxn + 1 ]
        ~vars:tracks
        ~deg:(List.length tracks))
  ;;
end

(* ------------------------------------------------------------- *)
(* ----------------------- MSB(IN) types ----------------------- *)
(* ------------------------------------------------------------- *)

module MsbNat = struct
  module Bv = Nfa.Bv
  module NfaMsb = Nfa.Msb (Bv)
  module NfaMsbNat = Nfa.MsbNat (Bv)

  type t = NfaMsbNat.t
  type v = bool

  let base = Bv.base
  let o = false
  let i = true

  let n () =
    NfaMsbNat.create_nfa
      ~transitions:[ 0, [], 0 ]
      ~start:[ 0 ]
      ~final:[ 0 ]
      ~vars:[]
      ~deg:1
  ;;

  let z () = NfaMsbNat.create_nfa ~transitions:[] ~start:[ 0 ] ~final:[] ~vars:[] ~deg:1

  let div_in_pow var a c =
    if c = 0
    then (
      let trans1 = List.init a Fun.id |> List.map (fun x -> x + 1, [ o ], x) in
      let nfa =
        NfaMsbNat.create_nfa
          ~transitions:([ a + 1, [ i ], a; a + 1, [ o ], a + 1 ] @ trans1)
          ~start:[ a + 1 ]
          ~final:[ 0 ]
          ~vars:[ var ]
          ~deg:(var + 1)
      in
      trace_log "Building div_in_pow nfa: var=%d, a=%d, c=%d" var a c;
      Debug.dump_nfa ~msg:"Nfa: %s" NfaMsbNat.format_nfa nfa;
      nfa)
    else (
      let trans1 = List.init (a + c - 1) Fun.id |> List.map (fun x -> x + 1, [ o ], x) in
      NfaMsbNat.create_nfa
        ~transitions:
          ([ a, [ o ], a + c - 1; a + c, [ i ], a; a + c, [ o ], a + c ] @ trans1)
        ~start:[ a + c ]
        ~final:[ 0 ]
        ~vars:[ var ]
        ~deg:(var + 1))
  ;;

  let pow_of_log_var var exp =
    NfaMsbNat.create_nfa
      ~transitions:[ 0, [ i; o ], 0; 0, [ o; o ], 0; 1, [ i; i ], 0; 1, [ o; o ], 1 ]
      ~start:[ 1 ]
      ~final:[ 0 ]
      ~vars:[ var; exp ]
      ~deg:(max var exp + 1)
  ;;

  let power_of_two exp =
    NfaMsbNat.create_nfa
      ~transitions:[ 0, [ o ], 0; 0, [ i ], 1; 1, [ o ], 1 ]
      ~start:[ 0 ]
      ~final:[ 1 ]
      ~vars:[ exp ]
      ~deg:(exp + 1)
  ;;

  let eq vars term c = Msb.eq vars term c |> NfaMsb.to_nat
  let neq vars term c = Msb.neq vars term c |> NfaMsb.to_nat
  let leq vars term c = Msb.leq vars term c |> NfaMsb.to_nat
  let mod_eq vars term m c = Msb.mod_eq vars term m c |> NfaMsb.to_nat

  let strlen ~alpha ~(dest : int) ~(src : int) () =
    failwith "Unimplemented for string bitvectors"
  ;;

  let strlen_const ~alpha specs =
    ignore (alpha, specs);
    failwith "Unimplemented for string bitvectors"
  ;;
end

module MsbNatStr (B : Nfa.Base) = struct
  module Str = Nfa.Str (B)
  module NfaMsb = Nfa.Msb (Nfa.Str (B))
  module NfaMsbNat = Nfa.MsbNat (Nfa.Str (B))

  type t = NfaMsbNat.t
  type v = Str.u

  let o = Str.u_zero
  let i = Str.u_one
  let base = Str.base
  let basei = Z.to_int Str.base
  let alphabet = Str.alphabet |> List.to_seq |> Seq.take basei |> List.of_seq
  let () = assert (List.nth alphabet 0 = Str.u_zero)
  let itoc i = List.nth alphabet i
  let alphabet = Str.alphabet |> List.to_seq |> Seq.take basei |> List.of_seq
  let () = assert (List.nth alphabet 0 = Str.u_zero)

  let n () =
    NfaMsbNat.create_nfa
      ~transitions:[ 0, [], 0 ]
      ~start:[ 0 ]
      ~final:[ 0 ]
      ~vars:[]
      ~deg:1
  ;;

  let z () = NfaMsbNat.create_nfa ~transitions:[] ~start:[ 0 ] ~final:[] ~vars:[] ~deg:1

  let div_in_pow var a c =
    if c = 0
    then (
      let trans1 = List.init a Fun.id |> List.map (fun x -> x + 1, [ o ], x) in
      let nfa =
        NfaMsbNat.create_nfa
          ~transitions:
            ([ a + 1, [ i ], a; a + 1, [ o ], a + 1; a + 1, [ Str.u_eos ], a + 1 ]
             @ trans1)
          ~start:[ a + 1 ]
          ~final:[ 0 ]
          ~vars:[ var ]
          ~deg:(var + 1)
      in
      trace_log "Building div_in_pow nfa: var=%d, a=%d, c=%d" var a c;
      Debug.dump_nfa ~msg:"Nfa: %s" NfaMsbNat.format_nfa nfa;
      nfa)
    else (
      let trans1 = List.init (a + c - 1) Fun.id |> List.map (fun x -> x + 1, [ o ], x) in
      NfaMsbNat.create_nfa
        ~transitions:
          ([ a, [ o ], a + c - 1
           ; a + c, [ i ], a
           ; a + c, [ o ], a + c
           ; a + c, [ Str.u_eos ], a + c
           ]
           @ trans1)
        ~start:[ a + c ]
        ~final:[ 0 ]
        ~vars:[ var ]
        ~deg:(var + 1))
  ;;

  let pow_of_log_var var exp =
    NfaMsbNat.create_nfa
      ~transitions:
        ((0 -- (basei - 1) |> List.map (fun c -> 0, [ itoc c; o ], 0))
         @ (1 -- (basei - 1) |> List.map (fun c -> 1, [ itoc c; i ], 0))
         @ [ 1, [ Str.u_eos; Str.u_eos ], 1; 1, [ o; Str.u_eos ], 1; 1, [ o; o ], 1 ])
      ~start:[ 1 ]
      ~final:[ 0 ]
      ~vars:[ var; exp ]
      ~deg:(max var exp + 1)
  ;;

  let power_of_two exp =
    NfaMsbNat.create_nfa
      ~transitions:[ 0, [ o ], 0; 0, [ Str.u_eos ], 0; 0, [ i ], 1; 1, [ o ], 1 ]
      ~start:[ 0 ]
      ~final:[ 1 ]
      ~vars:[ exp ]
      ~deg:(exp + 1)
  ;;

  (* type t = Nfa.Msb(Str).t*)

  module MsbStr = MsbStr (B)

  let eq vars term c = MsbStr.eq vars term c |> NfaMsb.to_nat
  let neq vars term c = MsbStr.neq vars term c |> NfaMsb.to_nat
  let leq vars term c = MsbStr.leq vars term c |> NfaMsb.to_nat
  let mod_eq vars term m c = MsbStr.mod_eq vars term m c |> NfaMsb.to_nat

  let strlen ~alpha ~(dest : int) ~(src : int) () =
    let alpha = Option.value ~default:alphabet alpha in
    let alpha_transitions = List.map (fun c -> 0, [ c; Str.u_zero ], 0) alpha in
    let transitions =
      alpha_transitions @ [ 1, [ Str.u_eos; i ], 0 ] @ [ 1, [ Str.u_eos; Str.u_zero ], 1 ]
    in
    NfaMsbNat.create_nfa ~transitions ~start:[ 1 ] ~final:[ 0 ] ~vars:[ src; dest ] ~deg:2
  ;;

  let strlen_const ~alpha specs =
    let alpha = Option.value ~default:alphabet alpha in
    let specs =
      Base.List.dedup_and_sort ~compare:Stdlib.compare specs
      |> List.sort (fun (_, a) (_, b) -> Stdlib.compare b a)
    in
    let tracks = List.map fst specs in
    if Base.List.contains_dup tracks ~compare:Stdlib.compare
    then (* the same string pinned to two different lengths *) z ()
    else if List.is_empty specs
    then n ()
    else (
      let lens = List.map snd specs in
      let maxn = List.fold_left max 0 lens in
      (* State [s]: the longest string has consumed [s] characters. Msb
       strings are end-anchored (chars run to the word end behind the eos
       padding), so their mutual offsets are rigid: one linear chain of
       [maxn] steps replaces the quadratic product of per-string chains
       that made the reconstruction blow past the size limit. A string of
       length [n] is still padding while [s < maxn - n]. *)
      let rec combos = function
        | [] -> [ [] ]
        | `Any :: tl ->
          List.concat_map (fun c -> List.map (fun rest -> c :: rest) (combos tl)) alpha
        | `Eos :: tl -> List.map (fun rest -> Str.u_eos :: rest) (combos tl)
      in
      (* Chain position [p] lives in state [p + 1]: state 0 is the padding
         loop, and the only way into the chain is the all-eos boundary step
         0 -> 1. The Msb invariant closure shortcuts equal-label runs that
         start AT the start state -- char steps hanging directly off the
         start would let a run of equal characters skip chain positions and
         void the length pin (observed: a 5031-pin accepting a ~1000-char
         string zero-padded by the printer). Behind the eos boundary the
         char runs are not start-adjacent, so the closure only ever adds
         harmless pad-to-boundary jumps, exactly like [strlen]'s own
         eos-labelled boundary. *)
      let step p =
        lens
        |> List.map (fun n -> if p >= maxn - n then `Any else `Eos)
        |> combos
        |> List.map (fun l -> p + 1, l, p + 2)
      in
      let all_eos = List.map (Fun.const Str.u_eos) lens in
      let pad = 0, all_eos, 0 in
      let boundary = 0, all_eos, 1 in
      let transitions = pad :: boundary :: List.concat_map step (List.init maxn Fun.id) in
      NfaMsbNat.create_nfa
        ~transitions
        ~start:[ 0 ]
        ~final:[ maxn + 1 ]
        ~vars:tracks
        ~deg:(List.length tracks))
  ;;
end

module MsbNatStrBv (B : Nfa.Base) = struct
  module Str = Nfa.StrBv (B)
  module NfaMsb = Nfa.Msb (Nfa.StrBv (B))
  module NfaMsbNat = Nfa.MsbNat (Nfa.StrBv (B))

  type t = NfaMsbNat.t
  type v = Str.u

  let o = Str.u_zero
  let i = Str.u_one
  let base = Str.base
  let basei = Z.to_int Str.base
  let alphabet = Str.alphabet |> List.to_seq |> Seq.take basei |> List.of_seq
  let () = assert (List.nth alphabet 0 = Str.u_zero)
  let itoc i = List.nth alphabet i

  let n () =
    NfaMsbNat.create_nfa
      ~transitions:[ 0, [], 0 ]
      ~start:[ 0 ]
      ~final:[ 0 ]
      ~vars:[]
      ~deg:1
  ;;

  let z () = NfaMsbNat.create_nfa ~transitions:[] ~start:[ 0 ] ~final:[] ~vars:[] ~deg:1

  let div_in_pow var a c =
    if c = 0
    then (
      let trans1 = List.init a Fun.id |> List.map (fun x -> x + 1, [ o ], x) in
      let nfa =
        NfaMsbNat.create_nfa
          ~transitions:
            ([ a + 1, [ i ], a; a + 1, [ o ], a + 1; a + 1, [ Str.u_eos ], a + 1 ]
             @ trans1)
          ~start:[ a + 1 ]
          ~final:[ 0 ]
          ~vars:[ var ]
          ~deg:(var + 1)
      in
      trace_log "Building div_in_pow nfa: var=%d, a=%d, c=%d" var a c;
      Debug.dump_nfa ~msg:"Nfa: %s" NfaMsbNat.format_nfa nfa;
      nfa)
    else (
      let trans1 = List.init (a + c - 1) Fun.id |> List.map (fun x -> x + 1, [ o ], x) in
      NfaMsbNat.create_nfa
        ~transitions:
          ([ a, [ o ], a + c - 1
           ; a + c, [ i ], a
           ; a + c, [ o ], a + c
           ; a + c, [ Str.u_eos ], a + c
           ]
           @ trans1)
        ~start:[ a + c ]
        ~final:[ 0 ]
        ~vars:[ var ]
        ~deg:(var + 1))
  ;;

  let pow_of_log_var var exp =
    NfaMsbNat.create_nfa
      ~transitions:
        ((0 -- (basei - 1) |> List.map (fun c -> 0, [ itoc c; o ], 0))
         @ (1 -- (basei - 1) |> List.map (fun c -> 1, [ itoc c; i ], 0))
         @ [ 1, [ Str.u_eos; Str.u_eos ], 1; 1, [ o; Str.u_eos ], 1; 1, [ o; o ], 1 ])
      ~start:[ 1 ]
      ~final:[ 0 ]
      ~vars:[ var; exp ]
      ~deg:(max var exp + 1)
  ;;

  let power_of_two exp =
    NfaMsbNat.create_nfa
      ~transitions:[ 0, [ o ], 0; 0, [ Str.u_eos ], 0; 0, [ i ], 1; 1, [ o ], 1 ]
      ~start:[ 0 ]
      ~final:[ 1 ]
      ~vars:[ exp ]
      ~deg:(exp + 1)
  ;;

  module MsbStrBv = MsbStrBv (B)

  let eq vars term c = MsbStrBv.eq vars term c |> NfaMsb.to_nat
  let neq vars term c = MsbStrBv.neq vars term c |> NfaMsb.to_nat
  let leq vars term c = MsbStrBv.leq vars term c |> NfaMsb.to_nat
  let mod_eq vars term m c = MsbStrBv.mod_eq vars term m c |> NfaMsb.to_nat

  let strlen ~alpha ~(dest : int) ~(src : int) () =
    let alpha = Option.value ~default:alphabet alpha in
    let alpha_transitions = List.map (fun c -> 0, [ c; Str.u_zero ], 0) alpha in
    let transitions =
      alpha_transitions @ [ 1, [ Str.u_eos; i ], 0 ] @ [ 1, [ Str.u_eos; Str.u_zero ], 1 ]
    in
    NfaMsbNat.create_nfa ~transitions ~start:[ 1 ] ~final:[ 0 ] ~vars:[ src; dest ] ~deg:2
  ;;

  let strlen_const ~alpha specs =
    let alpha = Option.value ~default:alphabet alpha in
    let specs =
      Base.List.dedup_and_sort ~compare:Stdlib.compare specs
      |> List.sort (fun (_, a) (_, b) -> Stdlib.compare b a)
    in
    let tracks = List.map fst specs in
    if Base.List.contains_dup tracks ~compare:Stdlib.compare
    then (* the same string pinned to two different lengths *) z ()
    else if List.is_empty specs
    then n ()
    else (
      let lens = List.map snd specs in
      let maxn = List.fold_left max 0 lens in
      (* State [s]: the longest string has consumed [s] characters. Msb
       strings are end-anchored (chars run to the word end behind the eos
       padding), so their mutual offsets are rigid: one linear chain of
       [maxn] steps replaces the quadratic product of per-string chains
       that made the reconstruction blow past the size limit. A string of
       length [n] is still padding while [s < maxn - n]. *)
      let rec combos = function
        | [] -> [ [] ]
        | `Any :: tl ->
          List.concat_map (fun c -> List.map (fun rest -> c :: rest) (combos tl)) alpha
        | `Eos :: tl -> List.map (fun rest -> Str.u_eos :: rest) (combos tl)
      in
      (* Chain position [p] lives in state [p + 1]: state 0 is the padding
         loop, and the only way into the chain is the all-eos boundary step
         0 -> 1. The Msb invariant closure shortcuts equal-label runs that
         start AT the start state -- char steps hanging directly off the
         start would let a run of equal characters skip chain positions and
         void the length pin (observed: a 5031-pin accepting a ~1000-char
         string zero-padded by the printer). Behind the eos boundary the
         char runs are not start-adjacent, so the closure only ever adds
         harmless pad-to-boundary jumps, exactly like [strlen]'s own
         eos-labelled boundary. *)
      let step p =
        lens
        |> List.map (fun n -> if p >= maxn - n then `Any else `Eos)
        |> combos
        |> List.map (fun l -> p + 1, l, p + 2)
      in
      let all_eos = List.map (Fun.const Str.u_eos) lens in
      let pad = 0, all_eos, 0 in
      let boundary = 0, all_eos, 1 in
      let transitions = pad :: boundary :: List.concat_map step (List.init maxn Fun.id) in
      NfaMsbNat.create_nfa
        ~transitions
        ~start:[ 0 ]
        ~final:[ maxn + 1 ]
        ~vars:tracks
        ~deg:(List.length tracks))
  ;;
end

(* ------------------------------------------------------------- *)
(* ------------------------- LSB types ------------------------- *)
(* ------------------------------------------------------------- *)

module Lsb = struct
  module Bv = Nfa.Bv
  module Nfa = Nfa.Lsb (Bv)

  type t = Nfa.t
  type v = bool

  let base = Bv.base
  let o = false
  let i = true

  let n () =
    Nfa.create_nfa ~transitions:[ 0, [], 0 ] ~start:[ 0 ] ~final:[ 0 ] ~vars:[] ~deg:1
  ;;

  let z () = Nfa.create_nfa ~transitions:[] ~start:[ 0 ] ~final:[] ~vars:[] ~deg:1

  let div_in_pow var a c =
    if c = 0
    then (
      let trans1 = List.init a Fun.id |> List.map (fun x -> x, [ o ], x + 1) in
      Nfa.create_nfa
        ~transitions:([ a, [ i ], a + 1; a + 1, [ o ], a + 1 ] @ trans1)
        ~start:[ 0 ]
        ~final:[ a + 1 ]
        ~vars:[ var ]
        ~deg:(var + 1))
    else (
      let trans1 = List.init (a + c - 1) Fun.id |> List.map (fun x -> x, [ o ], x + 1) in
      Nfa.create_nfa
        ~transitions:
          ([ a + c - 1, [ o ], a; a, [ i ], a + c; a + c, [ o ], a + c ] @ trans1)
        ~start:[ 0 ]
        ~final:[ a + c ]
        ~vars:[ var ]
        ~deg:(var + 1))
  ;;

  let pow_of_log_var var exp =
    Nfa.create_nfa
      ~transitions:[ 0, [ i; o ], 0; 0, [ o; o ], 0; 0, [ i; i ], 1; 1, [ o; o ], 1 ]
      ~start:[ 0 ]
      ~final:[ 1 ]
      ~vars:[ var; exp ]
      ~deg:(max var exp + 1)
  ;;

  let power_of_two exp =
    Nfa.create_nfa
      ~transitions:[ 0, [ o ], 0; 0, [ i ], 1; 1, [ o ], 1 ]
      ~start:[ 0 ]
      ~final:[ 1 ]
      ~vars:[ exp ]
      ~deg:(exp + 1)
  ;;

  let powerset term =
    let rec helper = function
      | [] -> []
      | [ x ] -> [ [ o ], [ Z.zero ]; [ i ], [ x ] ]
      | hd :: tl ->
        let open Base.List.Let_syntax in
        let ( let* ) = ( >>= ) in
        let* n, thing = helper tl in
        [ o :: n, Z.zero :: thing; i :: n, hd :: thing ]
    in
    term
    |> List.map snd
    |> helper
    |> List.map (fun (a, x) -> a, Base.List.sum (module Z) ~f:Fun.id x)
  ;;

  let eq vars term c =
    let term =
      Map.map_keys_exn ~f:(Map.find_exn vars) term
      |> Map.to_alist
      |> List.filter (fun (_, v) -> Z.(v <> zero))
    in
    let gcd_ = List.fold_left (fun acc (_, data) -> gcd data acc) Z.zero term in
    if Z.(gcd_ = zero)
    then if Z.(zero = c) then n () else z ()
    else (
      let thing = powerset term in
      let states = ref Set.empty in
      let transitions = ref [] in
      let rec lp front =
        match front with
        | [] -> ()
        | hd :: tl ->
          if Set.mem !states hd
          then lp tl
          else begin
            let t =
              thing
              |> List.filter (fun (_, sum) -> Z.((hd - sum) mod base = zero))
              |> List.map (fun (bits, sum) -> hd, bits, Z.((hd - sum) / base))
            in
            states := Set.add !states hd;
            transitions := t @ !transitions;
            lp (List.map (fun (_, _, x) -> x) t @ tl)
          end
      in
      lp [ c ];
      let states = Set.to_list !states in
      trace_log
        "states:[%a]"
        (Format.pp_print_list
           ~pp_sep:(fun fmt () -> Format.fprintf fmt "; ")
           (fun fmt a -> Format.fprintf fmt "%a" Z.pp_print a))
        states;
      let states = states |> List.mapi (fun i x -> x, i) |> Map.of_alist_exn in
      let idx c = Map.find states c |> Option.get in
      let idxs c =
        Map.find states c |> Option.map (fun c -> [ c ]) |> Option.value ~default:[]
      in
      let transitions = List.map (fun (a, b, c) -> idx a, b, idx c) !transitions in
      Nfa.create_nfa
        ~transitions
        ~start:(idxs c)
        ~final:(idxs Z.zero)
        ~vars:(List.map fst term)
        ~deg:(1 + List.fold_left Int.max 0 (List.map fst term)))
  ;;

  let neq vars term c = eq vars term c |> Nfa.invert

  let leq vars term c =
    let term = Map.map_keys_exn ~f:(Map.find_exn vars) term |> Map.to_alist in
    let gcd_ = List.fold_left (fun acc (_, data) -> gcd data acc) Z.zero term in
    if Z.(gcd_ = zero)
    then if Z.(zero <= c) then n () else z ()
    else (
      let thing = powerset term in
      let states = ref Set.empty in
      let transitions = ref [] in
      let rec lp front =
        match front with
        | [] -> ()
        | hd :: tl ->
          if Set.mem !states hd
          then lp tl
          else begin
            let t =
              thing
              |> List.map (fun (bits, sum) ->
                ( hd
                , bits
                , match Z.((hd - sum) mod base) with
                  | x when x = Z.one || x = Z.zero -> Z.((hd - sum) / base)
                  | x when x = Z.minus_one -> Z.(((hd - sum) / base) - one)
                  | _ -> failwith "Should be unreachable" ))
            in
            states := Set.add !states hd;
            transitions := t @ !transitions;
            lp (List.map (fun (_, _, x) -> x) t @ tl)
          end
      in
      lp [ c ];
      let states = Set.to_list !states in
      trace_log
        "states:[%a]"
        (Format.pp_print_list
           ~pp_sep:(fun fmt () -> Format.fprintf fmt "; ")
           (fun fmt a -> Format.fprintf fmt "%a" Z.pp_print a))
        states;
      let states = states |> List.mapi (fun i x -> x, i) |> Map.of_alist_exn in
      let idx c = Map.find states c |> Option.get in
      let transitions = List.map (fun (a, b, c) -> idx a, b, idx c) !transitions in
      Nfa.create_nfa
        ~transitions
        ~start:[ idx c ]
        ~final:(states |> Map.filter_keys ~f:(fun x -> Z.(x >= zero)) |> Map.data)
        ~vars:(List.map fst term)
        ~deg:(1 + List.fold_left Int.max 0 (List.map fst term)))
  ;;

  let mod_eq vars term m c =
    let m = Z.abs m in
    if Z.(equal m zero)
    then eq vars term c
    else if Z.(equal m one)
    then n ()
    else (
      match mod_eq_prepare vars term m with
      | [] -> if Z.(erem c m = zero) then n () else z ()
      | term ->
        let thing = powerset term in
        let transitions, start, final = mod_eq_lsb_parts ~base ~m ~c ~thing in
        Nfa.create_nfa
          ~transitions
          ~start
          ~final
          ~vars:(List.map fst term)
          ~deg:(1 + List.fold_left Int.max 0 (List.map fst term)))
  ;;

  let strlen ~alpha ~(dest : int) ~(src : int) () =
    failwith "Unimplemented for string bitvectors"
  ;;

  let strlen_const ~alpha specs =
    ignore (alpha, specs);
    failwith "Unimplemented for string bitvectors"
  ;;
end

(* ------------------------------------------------------------- *)
(* -------------------- Congruence tests ----------------------- *)
(* ------------------------------------------------------------- *)

(* [mod_eq] is cross-checked against plain arithmetic: pin the variables with
   [eq] automata and ask whether the intersection is still non-empty. *)

module NLsb = Nfa.Lsb (Nfa.Bv)
module NMsb = Nfa.Msb (Nfa.Bv)

let%expect_test "lsb mod_eq agrees with arithmetic (naturals)" =
  let x = Ir.Var "x" in
  let vars = Map.of_alist_exn [ x, 0 ] in
  let term = Map.of_alist_exn [ x, Z.one ] in
  let bad = ref [] in
  for m = 1 to 12 do
    for c = 0 to m - 1 do
      for v = 0 to 32 do
        let got =
          NLsb.intersect
            (Lsb.mod_eq vars term (Z.of_int m) (Z.of_int c))
            (Lsb.eq vars term (Z.of_int v))
          |> NLsb.run
        in
        if got <> (v mod m = c) then bad := (m, c, v, got) :: !bad
      done
    done
  done;
  (match List.rev !bad with
   | [] -> print_string "ok"
   | l ->
     List.iter (fun (m, c, v, got) -> Printf.printf "m=%d c=%d v=%d got=%b\n" m c v got) l);
  [%expect {| ok |}]
;;

let%expect_test "msb mod_eq agrees with arithmetic (signed)" =
  let x = Ir.Var "x" in
  let vars = Map.of_alist_exn [ x, 0 ] in
  let term = Map.of_alist_exn [ x, Z.one ] in
  let bad = ref [] in
  for m = 1 to 12 do
    for c = 0 to m - 1 do
      for v = -20 to 20 do
        let got =
          NMsb.intersect
            (Msb.mod_eq vars term (Z.of_int m) (Z.of_int c))
            (Msb.eq vars term (Z.of_int v))
          |> NMsb.run
        in
        if got <> (((v mod m) + m) mod m = c) then bad := (m, c, v, got) :: !bad
      done
    done
  done;
  (match List.rev !bad with
   | [] -> print_string "ok"
   | l ->
     List.iter (fun (m, c, v, got) -> Printf.printf "m=%d c=%d v=%d got=%b\n" m c v got) l);
  [%expect {| ok |}]
;;

let%expect_test "lsb mod_eq with several variables and mixed signs" =
  let x = Ir.Var "x"
  and y = Ir.Var "y" in
  let vars = Map.of_alist_exn [ x, 0; y, 1 ] in
  let term = Map.of_alist_exn [ x, Z.of_int 3; y, Z.of_int (-2) ] in
  let bad = ref [] in
  let m = 7 in
  for c = 0 to m - 1 do
    for vx = 0 to 10 do
      for vy = 0 to 10 do
        let pin =
          NLsb.intersect
            (Lsb.eq vars (Map.of_alist_exn [ x, Z.one ]) (Z.of_int vx))
            (Lsb.eq vars (Map.of_alist_exn [ y, Z.one ]) (Z.of_int vy))
        in
        let got =
          NLsb.intersect (Lsb.mod_eq vars term (Z.of_int m) (Z.of_int c)) pin |> NLsb.run
        in
        let want = ((((3 * vx) - (2 * vy)) mod m) + m) mod m = c in
        if got <> want then bad := (c, vx, vy, got) :: !bad
      done
    done
  done;
  (match List.rev !bad with
   | [] -> print_string "ok"
   | l ->
     List.iter
       (fun (c, vx, vy, got) -> Printf.printf "c=%d x=%d y=%d got=%b\n" c vx vy got)
       l);
  [%expect {| ok |}]
;;

(* The size table is the whole point of the dedicated construction: the state
   count stays linear in the modulus, instead of the [m * ord(base)] a naive
   (value, weight) pair would need or the extra unbounded track that encoding
   [exists q. t - m*q = c] would add. *)
let%expect_test "congruence automata stay small" =
  let x = Ir.Var "x" in
  let vars = Map.of_alist_exn [ x, 0 ] in
  let term = Map.of_alist_exn [ x, Z.one ] in
  List.iter
    (fun m ->
       Printf.printf
         "m=%-3d lsb=%-3d msb=%-3d\n"
         m
         (Lsb.mod_eq vars term (Z.of_int m) Z.zero |> NLsb.length)
         (Msb.mod_eq vars term (Z.of_int m) Z.zero |> NMsb.length))
    [ 3; 4; 8; 12; 67 ];
  [%expect
    {|
    m=3   lsb=3   msb=4
    m=4   lsb=7   msb=5
    m=8   lsb=15  msb=9
    m=12  lsb=15  msb=13
    m=67  lsb=67  msb=68
    |}]
;;

(* Property-style checks: the algebra of congruences, verified as *language*
   identities over exhaustive small parameter ranges. [same_lang a b] is
   genuine automata equivalence -- both differences [a \ b] and [b \ a] must
   be empty -- not just agreement on a few pinned values. *)

let lsb_same_lang a b =
  (not (NLsb.run (NLsb.intersect a (NLsb.invert b))))
  && not (NLsb.run (NLsb.intersect b (NLsb.invert a)))
;;

let msb_same_lang a b =
  (not (NMsb.run (NMsb.intersect a (NMsb.invert b))))
  && not (NMsb.run (NMsb.intersect b (NMsb.invert a)))
;;

(* e.g. [x = 1 (mod 3)] and [x = 2 (mod 3)] have an empty intersection. *)
let%expect_test "congruences modulo m intersect iff the residues agree" =
  let x = Ir.Var "x" in
  let vars = Map.of_alist_exn [ x, 0 ] in
  let term = Map.of_alist_exn [ x, Z.one ] in
  let bad = ref [] in
  for m = 1 to 10 do
    for c1 = 0 to m - 1 do
      for c2 = 0 to m - 1 do
        let want = c1 = c2 in
        let lsb =
          NLsb.intersect
            (Lsb.mod_eq vars term (Z.of_int m) (Z.of_int c1))
            (Lsb.mod_eq vars term (Z.of_int m) (Z.of_int c2))
          |> NLsb.run
        in
        let msb =
          NMsb.intersect
            (Msb.mod_eq vars term (Z.of_int m) (Z.of_int c1))
            (Msb.mod_eq vars term (Z.of_int m) (Z.of_int c2))
          |> NMsb.run
        in
        if lsb <> want || msb <> want then bad := (m, c1, c2, lsb, msb) :: !bad
      done
    done
  done;
  (match List.rev !bad with
   | [] -> print_string "ok"
   | l ->
     List.iter
       (fun (m, c1, c2, lsb, msb) ->
          Printf.printf "m=%d c1=%d c2=%d lsb=%b msb=%b\n" m c1 c2 lsb msb)
       l);
  [%expect {| ok |}]
;;

(* e.g. [x = 1 (mod 3)] and [x = 4 (mod 3)] are the same set. *)
let%expect_test "congruence depends only on c modulo m" =
  let x = Ir.Var "x" in
  let vars = Map.of_alist_exn [ x, 0 ] in
  let term = Map.of_alist_exn [ x, Z.one ] in
  let bad = ref [] in
  for m = 1 to 8 do
    for c = 0 to m - 1 do
      for k = -3 to 3 do
        let c' = c + (k * m) in
        let lsb =
          lsb_same_lang
            (Lsb.mod_eq vars term (Z.of_int m) (Z.of_int c))
            (Lsb.mod_eq vars term (Z.of_int m) (Z.of_int c'))
        in
        let msb =
          msb_same_lang
            (Msb.mod_eq vars term (Z.of_int m) (Z.of_int c))
            (Msb.mod_eq vars term (Z.of_int m) (Z.of_int c'))
        in
        if not (lsb && msb) then bad := (m, c, c', lsb, msb) :: !bad
      done
    done
  done;
  (match List.rev !bad with
   | [] -> print_string "ok"
   | l ->
     List.iter
       (fun (m, c, c', lsb, msb) ->
          Printf.printf "m=%d c=%d c'=%d lsb=%b msb=%b\n" m c c' lsb msb)
       l);
  [%expect {| ok |}]
;;

(* Chinese remaindering, in both directions: [x = c1 (mod m1)] together with
   [x = c2 (mod m2)] is unsatisfiable when [c1 <> c2 (mod gcd m1 m2)], and
   otherwise is exactly the single congruence [x = c0 (mod lcm m1 m2)] for the
   [c0] solving both.  E.g. [x = 1 (mod 2) and x = 2 (mod 3)] is
   [x = 5 (mod 6)], while [x = 0 (mod 2) and x = 1 (mod 4)] is empty. *)
let%expect_test "conjoined congruences are one congruence modulo the lcm" =
  let x = Ir.Var "x" in
  let vars = Map.of_alist_exn [ x, 0 ] in
  let term = Map.of_alist_exn [ x, Z.one ] in
  let bad = ref [] in
  for m1 = 1 to 6 do
    for m2 = 1 to 6 do
      let l = m1 * m2 / Z.(to_int (gcd (of_int m1) (of_int m2))) in
      for c1 = 0 to m1 - 1 do
        for c2 = 0 to m2 - 1 do
          let c0 =
            List.find_opt (fun c -> c mod m1 = c1 && c mod m2 = c2) (0 -- (l - 1))
          in
          let lsb_inter =
            NLsb.intersect
              (Lsb.mod_eq vars term (Z.of_int m1) (Z.of_int c1))
              (Lsb.mod_eq vars term (Z.of_int m2) (Z.of_int c2))
          in
          let msb_inter =
            NMsb.intersect
              (Msb.mod_eq vars term (Z.of_int m1) (Z.of_int c1))
              (Msb.mod_eq vars term (Z.of_int m2) (Z.of_int c2))
          in
          let lsb, msb =
            match c0 with
            | None -> not (NLsb.run lsb_inter), not (NMsb.run msb_inter)
            | Some c0 ->
              ( lsb_same_lang lsb_inter (Lsb.mod_eq vars term (Z.of_int l) (Z.of_int c0))
              , msb_same_lang msb_inter (Msb.mod_eq vars term (Z.of_int l) (Z.of_int c0))
              )
          in
          if not (lsb && msb) then bad := (m1, c1, m2, c2, lsb, msb) :: !bad
        done
      done
    done
  done;
  (match List.rev !bad with
   | [] -> print_string "ok"
   | l ->
     List.iter
       (fun (m1, c1, m2, c2, lsb, msb) ->
          Printf.printf "m1=%d c1=%d m2=%d c2=%d lsb=%b msb=%b\n" m1 c1 m2 c2 lsb msb)
       l);
  [%expect {| ok |}]
;;

module LsbStr (B : Nfa.Base) = struct
  type t = Nfa.Lsb(Nfa.Str(B)).t
  type v = Nfa.Str(B).u

  module Str = Nfa.Str (B)
  module Nfa = Nfa.Lsb (Nfa.Str (B))

  let o = Str.u_zero
  let i = Str.u_one
  let base = Str.base
  let basei = Z.to_int base
  let alphabet = Str.alphabet |> List.to_seq |> Seq.take basei |> List.of_seq
  let () = assert (List.nth alphabet 0 = Str.u_zero)
  let itoc i = List.nth alphabet i

  let n () =
    Nfa.create_nfa ~transitions:[ 0, [], 0 ] ~start:[ 0 ] ~final:[ 0 ] ~vars:[] ~deg:1
  ;;

  let z () = Nfa.create_nfa ~transitions:[] ~start:[ 0 ] ~final:[] ~vars:[] ~deg:1

  let div_in_pow var a c =
    if c = 0
    then (
      let trans1 = List.init a Fun.id |> List.map (fun x -> x, [ o ], x + 1) in
      Nfa.create_nfa
        ~transitions:
          ([ a, [ i ], a + 1; a + 1, [ o ], a + 1; a + 1, [ Str.u_eos ], a + 1 ] @ trans1)
        ~start:[ 0 ]
        ~final:[ a + 1 ]
        ~vars:[ var ]
        ~deg:(var + 1))
    else (
      let trans1 = List.init (a + c - 1) Fun.id |> List.map (fun x -> x, [ o ], x + 1) in
      Nfa.create_nfa
        ~transitions:
          ([ a + c - 1, [ o ], a
           ; a, [ i ], a + c
           ; a + c, [ o ], a + c
           ; a + c, [ Str.u_eos ], a + c
           ]
           @ trans1)
        ~start:[ 0 ]
        ~final:[ a + c ]
        ~vars:[ var ]
        ~deg:(var + 1))
  ;;

  let pow_of_log_var var exp =
    let base = basei in
    Nfa.create_nfa
      ~transitions:
        ((0 -- (base - 1) |> List.map (fun c -> 0, [ itoc c; o ], 0))
         @ (1 -- (base - 1) |> List.map (fun c -> 0, [ itoc c; i ], 1))
         @ [ 1, [ o; o ], 1; 1, [ Str.u_eos; Str.u_eos ], 1 ])
      ~start:[ 0 ]
      ~final:[ 1 ]
      ~vars:[ var; exp ]
      ~deg:(max var exp + 1)
  ;;

  let power_of_two exp =
    Nfa.create_nfa
      ~transitions:[ 0, [ o ], 0; 0, [ i ], 1; 1, [ o ], 1; 1, [ Str.u_eos ], 1 ]
      ~start:[ 0 ]
      ~final:[ 1 ]
      ~vars:[ exp ]
      ~deg:(exp + 1)
  ;;

  let powerset term =
    let base = basei in
    let rec helper = function
      | [] -> []
      | [ x ] ->
        ([ Str.u_eos ], [ Z.zero ])
        :: (0 -- (base - 1) |> List.map (fun c -> [ itoc c ], [ Z.(x * of_int c) ]))
      | hd :: tl ->
        let open Base.List.Let_syntax in
        let ( let* ) = ( >>= ) in
        let* n, thing = helper tl in
        (Str.u_eos :: n, Z.zero :: thing)
        :: (0 -- (base - 1) |> List.map (fun c -> itoc c :: n, Z.(hd * of_int c) :: thing))
    in
    term
    |> List.map snd
    |> helper
    |> List.map (fun (a, x) -> a, Base.List.sum (module Z) ~f:Fun.id x)
  ;;

  let eq vars term c =
    let term =
      Map.map_keys_exn ~f:(Map.find_exn vars) term
      |> Map.to_alist
      |> List.filter (fun (_, v) -> Z.(v <> zero))
    in
    let gcd = List.fold_left (fun acc (_, data) -> gcd data acc) Z.zero term in
    if gcd = Z.zero
    then if Z.(zero = c) then n () else z ()
    else (
      let thing = powerset term in
      let states = ref Set.empty in
      let transitions = ref [] in
      let rec lp front =
        match front with
        | s when Set.is_empty s -> ()
        | s ->
          let hd = Set.nth s 0 |> Option.get in
          let tl = Set.remove_index s 0 in
          if Set.mem !states hd
          then lp tl
          else begin
            let t =
              thing
              |> List.filter (fun (_, sum) -> Z.((hd - sum) mod base = zero))
              |> List.map (fun (bits, sum) -> hd, bits, Z.((hd - sum) / base))
            in
            states := Set.add !states hd;
            transitions := t @ !transitions;
            lp (Set.union (List.map (fun (_, _, x) -> x) t |> Set.of_list) tl)
          end
      in
      lp (Set.singleton c);
      let states = Set.to_list !states in
      trace_log
        "states:[%a]"
        (Format.pp_print_list
           ~pp_sep:(fun fmt () -> Format.fprintf fmt "; ")
           (fun fmt a -> Format.fprintf fmt "%a" Z.pp_print a))
        states;
      let states = states |> List.mapi (fun i x -> x, i) |> Map.of_alist_exn in
      let idx c = Map.find states c |> Option.get in
      let idxs c =
        Map.find states c |> Option.map (fun c -> [ c ]) |> Option.value ~default:[]
      in
      let transitions = List.map (fun (a, b, c) -> idx a, b, idx c) !transitions in
      Nfa.create_nfa
        ~transitions
        ~start:(idxs c)
        ~final:(idxs Z.zero)
        ~vars:(List.map fst term)
        ~deg:(1 + List.fold_left Int.max 0 (List.map fst term)))
  ;;

  let neq vars term c = eq vars term c |> Nfa.invert

  let leq : ('a, int) Map.t -> ('a, Z.t) Map.t -> Z.t -> t =
    fun vars term c ->
    let term = Map.map_keys_exn ~f:(Map.find_exn vars) term |> Map.to_alist in
    let gcd = List.fold_left (fun acc (_, data) -> gcd data acc) Z.zero term in
    if gcd = Z.zero
    then if Z.(zero <= c) then n () else z ()
    else (
      let thing = powerset term in
      let states = ref Set.empty in
      let transitions = ref [] in
      let rec lp front =
        match front with
        | s when Set.is_empty s -> ()
        | s ->
          let hd = Set.nth s 0 |> Option.get in
          let tl = Set.remove_index s 0 in
          if Set.mem !states hd
          then lp tl
          else begin
            let t =
              thing
              |> List.map (fun (bits, sum) ->
                ( hd
                , bits
                , match Z.((hd - sum) mod base) with
                  | i when Z.(zero <= i) && i < base -> Z.((hd - sum) / base)
                  | i when Z.(-base < i && i < zero) -> Z.(((hd - sum) / base) - one)
                  | _ -> failwith "Should be unreachable" ))
            in
            states := Set.add !states hd;
            transitions := t @ !transitions;
            lp (Set.union (List.map (fun (_, _, x) -> x) t |> Set.of_list) tl)
          end
      in
      lp (Set.singleton c);
      let states = Set.to_list !states in
      trace_log
        "states:[%a]"
        (Format.pp_print_list
           ~pp_sep:(fun fmt () -> Format.fprintf fmt "; ")
           (fun fmt a -> Format.fprintf fmt "%a" Z.pp_print a))
        states;
      let states = states |> List.mapi (fun i x -> x, i) |> Map.of_alist_exn in
      let idx c = Map.find states c |> Option.get in
      let transitions = List.map (fun (a, b, c) -> idx a, b, idx c) !transitions in
      Nfa.create_nfa
        ~transitions
        ~start:[ idx c ]
        ~final:(states |> Map.filter_keys ~f:(fun x -> Z.(x >= zero)) |> Map.data)
        ~vars:(List.map fst term)
        ~deg:(1 + List.fold_left Int.max 0 (List.map fst term)))
  ;;

  let mod_eq vars term m c =
    let m = Z.abs m in
    if Z.(equal m zero)
    then eq vars term c
    else if Z.(equal m one)
    then n ()
    else (
      match mod_eq_prepare vars term m with
      | [] -> if Z.(erem c m = zero) then n () else z ()
      | term ->
        let thing = powerset term in
        let transitions, start, final = mod_eq_lsb_parts ~base ~m ~c ~thing in
        Nfa.create_nfa
          ~transitions
          ~start
          ~final
          ~vars:(List.map fst term)
          ~deg:(1 + List.fold_left Int.max 0 (List.map fst term)))
  ;;

  let strlen ~alpha ~(dest : int) ~(src : int) () =
    let alpha = Option.value ~default:alphabet alpha in
    let alpha_transitions = List.map (fun c -> 0, [ c; Str.u_zero ], 0) alpha in
    let transitions =
      alpha_transitions @ [ 0, [ Str.u_eos; i ], 1 ] @ [ 1, [ Str.u_eos; Str.u_zero ], 1 ]
    in
    Nfa.create_nfa ~transitions ~start:[ 0 ] ~final:[ 1 ] ~vars:[ src; dest ] ~deg:2
  ;;

  let strlen_const ~alpha specs =
    let alpha = Option.value ~default:alphabet alpha in
    let specs =
      Base.List.dedup_and_sort ~compare:Stdlib.compare specs
      |> List.sort (fun (_, a) (_, b) -> Stdlib.compare b a)
    in
    let tracks = List.map fst specs in
    if Base.List.contains_dup tracks ~compare:Stdlib.compare
    then (* the same string pinned to two different lengths *) z ()
    else if List.is_empty specs
    then n ()
    else (
      let lens = List.map snd specs in
      let maxn = List.fold_left max 0 lens in
      (* CAVEAT: the Lsb invariant closure extends the start set along
       zero-labelled runs, so a pinned string whose model starts with '0'
       characters can skip chain positions; extraction-only machinery, and
       the Msb pipeline is the one the string benchmarks exercise. *)
      (* State [s]: [s] characters consumed. Lsb strings are start-anchored
       (chars first, eos padding trails), so their mutual offsets are
       rigid: one linear chain of [maxn] steps replaces the quadratic
       product of per-string chains. A string of length [n] is done once
       [s >= n]. *)
      let rec combos = function
        | [] -> [ [] ]
        | `Any :: tl ->
          List.concat_map (fun c -> List.map (fun rest -> c :: rest) (combos tl)) alpha
        | `Eos :: tl -> List.map (fun rest -> Str.u_eos :: rest) (combos tl)
      in
      let step s =
        lens
        |> List.map (fun n -> if s < n then `Any else `Eos)
        |> combos
        |> List.map (fun l -> s, l, s + 1)
      in
      let pad = maxn, List.map (Fun.const Str.u_eos) lens, maxn in
      let transitions = pad :: List.concat_map step (List.init maxn Fun.id) in
      Nfa.create_nfa
        ~transitions
        ~start:[ 0 ]
        ~final:[ maxn ]
        ~vars:tracks
        ~deg:(List.length tracks))
  ;;
end

module LsbStrBv (B : Nfa.Base) = struct
  type t = Nfa.Lsb(Nfa.StrBv(B)).t
  type v = Nfa.StrBv(B).u

  module Str = Nfa.StrBv (B)
  module Nfa = Nfa.Lsb (Nfa.StrBv (B))

  let o = Str.u_zero
  let i = Str.u_one
  let base = Str.base
  let basei = Z.to_int base
  let alphabet = Str.alphabet |> List.to_seq |> Seq.take basei |> List.of_seq
  let () = assert (List.nth alphabet 0 = Str.u_zero)
  let itoc i = List.nth alphabet i

  let n () =
    Nfa.create_nfa ~transitions:[ 0, [], 0 ] ~start:[ 0 ] ~final:[ 0 ] ~vars:[] ~deg:1
  ;;

  let z () = Nfa.create_nfa ~transitions:[] ~start:[ 0 ] ~final:[] ~vars:[] ~deg:1

  let div_in_pow var a c =
    if c = 0
    then (
      let trans1 = List.init a Fun.id |> List.map (fun x -> x, [ o ], x + 1) in
      Nfa.create_nfa
        ~transitions:
          ([ a, [ i ], a + 1; a + 1, [ o ], a + 1; a + 1, [ Str.u_eos ], a + 1 ] @ trans1)
        ~start:[ 0 ]
        ~final:[ a + 1 ]
        ~vars:[ var ]
        ~deg:(var + 1))
    else (
      let trans1 = List.init (a + c - 1) Fun.id |> List.map (fun x -> x, [ o ], x + 1) in
      Nfa.create_nfa
        ~transitions:
          ([ a + c - 1, [ o ], a
           ; a, [ i ], a + c
           ; a + c, [ o ], a + c
           ; a + c, [ Str.u_eos ], a + c
           ]
           @ trans1)
        ~start:[ 0 ]
        ~final:[ a + c ]
        ~vars:[ var ]
        ~deg:(var + 1))
  ;;

  let pow_of_log_var var exp =
    let base = basei in
    Nfa.create_nfa
      ~transitions:
        ((0 -- (base - 1) |> List.map (fun c -> 0, [ itoc c; o ], 0))
         @ (1 -- (base - 1) |> List.map (fun c -> 0, [ itoc c; i ], 1))
         @ [ 1, [ o; o ], 1; 1, [ Str.u_eos; Str.u_eos ], 1 ])
      ~start:[ 0 ]
      ~final:[ 1 ]
      ~vars:[ var; exp ]
      ~deg:(max var exp + 1)
  ;;

  let power_of_two exp =
    Nfa.create_nfa
      ~transitions:[ 0, [ o ], 0; 0, [ i ], 1; 1, [ o ], 1; 1, [ Str.u_eos ], 1 ]
      ~start:[ 0 ]
      ~final:[ 1 ]
      ~vars:[ exp ]
      ~deg:(exp + 1)
  ;;

  let powerset term =
    let base = basei in
    let rec helper = function
      | [] -> []
      | [ (var, x) ] ->
        let range = if Ir.is_exp var then 0 -- 1 else 0 -- (base - 1) in
        ([ Str.u_eos ], [ Z.zero ])
        :: (range |> List.map (fun c -> [ itoc c ], [ Z.(x * of_int c) ]))
      | (var, x) :: tl ->
        let range = if Ir.is_exp var then 0 -- 1 else 0 -- (base - 1) in
        let open Base.List.Let_syntax in
        let ( let* ) = ( >>= ) in
        let* n, thing = helper tl in
        (Str.u_eos :: n, Z.zero :: thing)
        :: (range |> List.map (fun c -> itoc c :: n, Z.(x * of_int c) :: thing))
    in
    term |> helper |> List.map (fun (a, x) -> a, Base.List.sum (module Z) ~f:Fun.id x)
  ;;

  let eq vars term c =
    let term' = term |> Map.to_alist in
    let term =
      Map.map_keys_exn ~f:(Map.find_exn vars) term
      |> Map.to_alist
      |> List.filter (fun (_, v) -> Z.(v <> zero))
    in
    let gcd = List.fold_left (fun acc (_, data) -> gcd data acc) Z.zero term in
    if gcd = Z.zero
    then if Z.(zero = c) then n () else z ()
    else (
      let thing = powerset term' in
      let states = ref Set.empty in
      let transitions = ref [] in
      let rec lp front =
        match front with
        | s when Set.is_empty s -> ()
        | s ->
          let hd = Set.nth s 0 |> Option.get in
          let tl = Set.remove_index s 0 in
          if Set.mem !states hd
          then lp tl
          else begin
            let t =
              thing
              |> List.filter (fun (_, sum) -> Z.((hd - sum) mod base = zero))
              |> List.map (fun (bits, sum) -> hd, bits, Z.((hd - sum) / base))
            in
            states := Set.add !states hd;
            transitions := t @ !transitions;
            lp (Set.union (List.map (fun (_, _, x) -> x) t |> Set.of_list) tl)
          end
      in
      lp (Set.singleton c);
      let states = Set.to_list !states in
      trace_log
        "states:[%a]"
        (Format.pp_print_list
           ~pp_sep:(fun fmt () -> Format.fprintf fmt "; ")
           (fun fmt a -> Format.fprintf fmt "%a" Z.pp_print a))
        states;
      let states = states |> List.mapi (fun i x -> x, i) |> Map.of_alist_exn in
      let idx c = Map.find states c |> Option.get in
      let idxs c =
        Map.find states c |> Option.map (fun c -> [ c ]) |> Option.value ~default:[]
      in
      let transitions = List.map (fun (a, b, c) -> idx a, b, idx c) !transitions in
      Nfa.create_nfa
        ~transitions
        ~start:(idxs c)
        ~final:(idxs Z.zero)
        ~vars:(List.map fst term)
        ~deg:(1 + List.fold_left Int.max 0 (List.map fst term)))
  ;;

  let neq vars term c = eq vars term c |> Nfa.invert

  let leq : ('a, int) Map.t -> ('a, Z.t) Map.t -> Z.t -> t =
    fun vars term c ->
    let term' = term |> Map.to_alist in
    let term = Map.map_keys_exn ~f:(Map.find_exn vars) term |> Map.to_alist in
    let gcd = List.fold_left (fun acc (_, data) -> gcd data acc) Z.zero term in
    if gcd = Z.zero
    then if Z.(zero <= c) then n () else z ()
    else (
      let thing = powerset term' in
      let states = ref Set.empty in
      let transitions = ref [] in
      let rec lp front =
        match front with
        | s when Set.is_empty s -> ()
        | s ->
          let hd = Set.nth s 0 |> Option.get in
          let tl = Set.remove_index s 0 in
          if Set.mem !states hd
          then lp tl
          else begin
            let t =
              thing
              |> List.map (fun (bits, sum) ->
                ( hd
                , bits
                , match Z.((hd - sum) mod base) with
                  | i when Z.(zero <= i) && i < base -> Z.((hd - sum) / base)
                  | i when Z.(-base < i && i < zero) -> Z.(((hd - sum) / base) - one)
                  | _ -> failwith "Should be unreachable" ))
            in
            states := Set.add !states hd;
            transitions := t @ !transitions;
            lp (Set.union (List.map (fun (_, _, x) -> x) t |> Set.of_list) tl)
          end
      in
      lp (Set.singleton c);
      let states = Set.to_list !states in
      trace_log
        "states:[%a]"
        (Format.pp_print_list
           ~pp_sep:(fun fmt () -> Format.fprintf fmt "; ")
           (fun fmt a -> Format.fprintf fmt "%a" Z.pp_print a))
        states;
      let states = states |> List.mapi (fun i x -> x, i) |> Map.of_alist_exn in
      let idx c = Map.find states c |> Option.get in
      let transitions = List.map (fun (a, b, c) -> idx a, b, idx c) !transitions in
      Nfa.create_nfa
        ~transitions
        ~start:[ idx c ]
        ~final:(states |> Map.filter_keys ~f:(fun x -> Z.(x >= zero)) |> Map.data)
        ~vars:(List.map fst term)
        ~deg:(1 + List.fold_left Int.max 0 (List.map fst term)))
  ;;

  let mod_eq vars term m c =
    let m = Z.abs m in
    if Z.(equal m zero)
    then eq vars term c
    else if Z.(equal m one)
    then n ()
    else (
      (* [powerset] is keyed by atoms rather than by track index here: it needs
         [Ir.is_exp] to know that a [pow2] variable only has digits 0 and 1. *)
      let term =
        Map.filter_map term ~f:(fun a ->
          let a = Z.erem a m in
          if Z.equal a Z.zero then None else Some a)
        |> Map.to_alist
      in
      match term with
      | [] -> if Z.(erem c m = zero) then n () else z ()
      | term ->
        let thing = powerset term in
        (* keep the track list in step with the digit positions [powerset]
           emitted, which follow the order of [term] *)
        let places = List.map (fun (atom, _) -> Map.find_exn vars atom) term in
        let transitions, start, final = mod_eq_lsb_parts ~base ~m ~c ~thing in
        Nfa.create_nfa
          ~transitions
          ~start
          ~final
          ~vars:places
          ~deg:(1 + List.fold_left Int.max 0 places))
  ;;

  let strlen ~alpha ~(dest : int) ~(src : int) () =
    let alpha = Option.value ~default:alphabet alpha in
    let alpha_transitions = List.map (fun c -> 0, [ c; Str.u_zero ], 0) alpha in
    let transitions =
      alpha_transitions @ [ 0, [ Str.u_eos; i ], 1 ] @ [ 1, [ Str.u_eos; Str.u_zero ], 1 ]
    in
    Nfa.create_nfa ~transitions ~start:[ 0 ] ~final:[ 1 ] ~vars:[ src; dest ] ~deg:2
  ;;

  let strlen_const ~alpha specs =
    let alpha = Option.value ~default:alphabet alpha in
    let specs =
      Base.List.dedup_and_sort ~compare:Stdlib.compare specs
      |> List.sort (fun (_, a) (_, b) -> Stdlib.compare b a)
    in
    let tracks = List.map fst specs in
    if Base.List.contains_dup tracks ~compare:Stdlib.compare
    then (* the same string pinned to two different lengths *) z ()
    else if List.is_empty specs
    then n ()
    else (
      let lens = List.map snd specs in
      let maxn = List.fold_left max 0 lens in
      (* CAVEAT: the Lsb invariant closure extends the start set along
       zero-labelled runs, so a pinned string whose model starts with '0'
       characters can skip chain positions; extraction-only machinery, and
       the Msb pipeline is the one the string benchmarks exercise. *)
      (* State [s]: [s] characters consumed. Lsb strings are start-anchored
       (chars first, eos padding trails), so their mutual offsets are
       rigid: one linear chain of [maxn] steps replaces the quadratic
       product of per-string chains. A string of length [n] is done once
       [s >= n]. *)
      let rec combos = function
        | [] -> [ [] ]
        | `Any :: tl ->
          List.concat_map (fun c -> List.map (fun rest -> c :: rest) (combos tl)) alpha
        | `Eos :: tl -> List.map (fun rest -> Str.u_eos :: rest) (combos tl)
      in
      let step s =
        lens
        |> List.map (fun n -> if s < n then `Any else `Eos)
        |> combos
        |> List.map (fun l -> s, l, s + 1)
      in
      let pad = maxn, List.map (Fun.const Str.u_eos) lens, maxn in
      let transitions = pad :: List.concat_map step (List.init maxn Fun.id) in
      Nfa.create_nfa
        ~transitions
        ~start:[ 0 ]
        ~final:[ maxn ]
        ~vars:tracks
        ~deg:(List.length tracks))
  ;;
end

module LsbString = LsbStr (Nfa.Base10)
