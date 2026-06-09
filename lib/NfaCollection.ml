(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)
let trace_log fmt = Debug.trace "nfa_collection" fmt

module Map = Nfa.Map
module Set = Base.Set.Poly

type varpos = int

module type Type = sig
  type t
  type v

  val n : unit -> t
  val z : unit -> t
  val power_of_base : int -> t
  val eq : (Ir.atom, int) Map.t -> (Ir.atom, Z.t) Map.t -> Z.t -> t
  val neq : (Ir.atom, int) Map.t -> (Ir.atom, Z.t) Map.t -> Z.t -> t
  val leq : (Ir.atom, int) Map.t -> (Ir.atom, Z.t) Map.t -> Z.t -> t
  val base : Z.t
end

let gcd a b = Z.gcd a b
(*if a < zero || b < zero then gcd (abs a) (abs b) else if b = zero then a else gcd b (a mod b)*)

let div_ a b = if Z.(a mod b >= zero) then Z.(a / b) else Z.((a / b) - one)

let ( -- ) i j =
  let rec aux n acc = if n < i then acc else aux (n - 1) (n :: acc) in
  aux j []
;;

let both f (a, b) = f a, f b
let rec get_list lb ub step = if lb > ub then [] else lb :: get_list Z.(lb + step) ub step

module LsbStr = struct
  module Str = Nfa.Str
  module Nfa = Nfa.Lsb (Nfa.Str)

  type t = Nfa.t
  type v = Str.u

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

  let power_of_base exp =
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
end

module MsbPar = struct
  module Par = Nfa.Par
  module Nfa = Nfa.Parametric (Nfa.Par)

  type t = Nfa.t
  type v = Par.u

  let base = Config.config.enc_base

  (** returns an nfa recognizing every integer base [base]*)
  let n () =
    Nfa.create_nfa ~transitions:[ 0, [], 0 ] ~start:[ 0 ] ~final:[ 0 ] ~vars:[] ~deg:1
  ;;

  (** returns an nfa recognizing the empty language. *)

  let z () = Nfa.create_nfa ~transitions:[] ~start:[ 0 ] ~final:[] ~vars:[] ~deg:1

  (** [power_of_base exp] returns an nfa recognizing Pow([exp]). *)
  let power_of_base exp = failwith "TODO"

  let get_label t' v' op v =
    let open AstL.Lia in
    AstL.Lia
      (op
         (Atom t')
         (* (add
            (* (mul [ const v'; AstL.get_par 0 ] *)
            (* (const Z.(v' * base)
             ::  *)
            (List.map (fun (var, coeff) -> mul [ const coeff; AstL.get var ]) term)) *)
         (const Z.(v - (v' * base))))
  ;;

  let get_extra t' term =
    let open AstL.Lia in
    AstL.Lia
      (eq
         (Atom t')
         (add (List.map (fun (var, coeff) -> mul [ const coeff; AstL.get var ]) term)))
  ;;

  let get_sign_label t' v term op =
    let open AstL in
    let open AstL.Lia in
    land_
      (Lia
         (op
            (Atom t')
            (* (add
               (* (mul [ const v; add [ get_par 0; const Z.minus_one ] ] *)
               (* (const Z.(v * (base - one))
                ::  *)
               (List.map (fun (var, coeff) -> mul [ const coeff; get var ]) term)) *)
            (const Z.(v * (one - base))))
       :: List.map
            (fun (var, _) ->
               lor_
                 [ Lia (eq (get var) (const Z.zero))
                 ; Lia (eq (get var) (const Z.(base - one)))
                 ])
            term)
  ;;

  (** [eq vars term c] returns an nfa recognizing the equality [term]*[vars] = [c]. 
  Here, [term] is a list of [Z.t] coefficients and [vars] is a list of variables 
  (having the same length). *)
  let eq vars term c =
    trace_log "Base in Boigelot-eq: %a" Z.pp_print base;
    let open AstL.Lia in
    let t' = AstL.genpar () in
    let term =
      Map.map_keys_exn ~f:(Map.find_exn vars) term
      |> Map.to_alist
      |> List.filter (fun (_, coeff) -> Z.(coeff <> zero))
    in
    let gcd_ = List.fold_left (fun acc (_, data) -> gcd data acc) Z.zero term in
    if gcd_ = Z.zero
    then if Z.(zero = c) then n () else z ()
    else (
      let states = ref Set.empty in
      let transitions = ref [] in
      let get_incoming state =
        let lower, upper =
          List.fold_left
            (fun (p, n) (_, a) -> if Z.(a > zero) then Z.(p + a), n else p, Z.(n + a))
            (Z.zero, Z.zero)
            term
          |> both (fun x -> Z.(state - (x * (base - one))))
        in
        let lb =
          if Z.(lower mod (base * gcd_) = zero)
          then div_ lower base
          else Z.((div_ lower (base * gcd_) + one) * gcd_)
        in
        let ub =
          if Z.(upper mod (base * gcd_) = zero)
          then div_ upper base
          else Z.(div_ upper (base * gcd_) * gcd_)
        in
        get_list lb ub gcd_
        |> List.map (fun prev -> prev, get_label t' prev eq state, state)
      in
      let rec lp front =
        match front with
        | [] -> ()
        | hd :: tl ->
          if Set.mem !states hd
          then lp tl
          else begin
            let t = get_incoming hd in
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
        (term
         |> List.map snd
         |> Utils.powerset
         |> List.map (fun x -> Base.List.sum (module Z) ~f:Fun.id x)
         |> Base.List.dedup_and_sort ~compare:Z.compare
         |> List.filter_map (fun sum ->
           match Map.find states Z.(sum / minus_one) with
           | None -> None
           | Some idv -> Some (start, get_sign_label t' Z.(sum / minus_one) term eq, idv))
        )
        @ transitions
      in
      Nfa.create_nfa3
        ~transitions
        ~start:[ start ]
        ~final:[ idx c ]
        ~vars:(List.map fst term)
        ~deg:(1 + List.fold_left Int.max 0 (List.map fst term))
        ~is_dfa:true
        ~ph:(get_extra t' term)
      |> fun x -> x)
  ;;

  (** [eq vars term c] returns an nfa recognizing the dis-equality [term]*[vars] <> [c]. 
  Here, [term] is a list of [Z.t] coefficients and [vars] is a list of variables 
  (having the same length). *)
  let neq vars term c = eq vars term c |> Nfa.invert

  (** [eq vars term c] returns an nfa recognizing the inequality [term]*[vars] <= [c]. 
  Here, [term] is a list of [Z.t] coefficients and [vars] is a list of variables 
  (having the same length). *)
  let leq vars term c =
    (* trace_log "Base in Boigelot-leq: %a" Z.pp_print base; *)
    let open AstL.Lia in
    let t' = AstL.genpar () in
    let term =
      Map.map_keys_exn ~f:(Map.find_exn vars) term
      |> Map.to_alist
      |> List.filter (fun (_, coeff) -> Z.(coeff <> zero))
    in
    let gcd_ = List.fold_left (fun acc (_, data) -> gcd data acc) Z.zero term in
    if Z.(gcd_ = zero)
    then if Z.(zero <= c) then n () else z ()
    else (
      let states = ref Set.empty in
      let transitions = ref [] in
      let get_incoming state =
        let lb, ub =
          List.fold_left
            (fun (p, n) (_, a) -> if Z.(a > zero) then Z.(p + a), n else p, Z.(n + a))
            (Z.zero, Z.zero)
            term
          |> both (fun x -> Z.(state - (x * (base - one))))
          |> both (fun x -> Z.(div_ x (base * gcd_) * gcd_))
        in
        get_list lb ub gcd_
        |> List.map (fun prev ->
          ( prev
          , AstL.land_
              [ get_label t' prev leq state; get_label t' Z.(prev + gcd_) geq state ]
          , state ))
      in
      let rec lp front =
        match front with
        | [] -> ()
        | hd :: tl ->
          if Set.mem !states hd
          then lp tl
          else begin
            let t = get_incoming hd in
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
        (let sums =
           term
           |> List.map snd
           |> Utils.powerset
           |> List.map (fun x -> Base.List.sum (module Z) ~f:Fun.id x)
           |> Base.List.dedup_and_sort ~compare:Z.compare
         in
         Map.to_alist states
         |> List.filter_map (fun (v, idv) ->
           if List.exists (fun sum -> Z.(sum / minus_one <= v)) sums
           then Some (start, get_sign_label t' v term geq, idv)
           else None))
        @ transitions
      in
      Nfa.create_nfa3
        ~transitions
        ~start:[ start ]
        ~final:(states |> Map.filter_keys ~f:(fun x -> x <= c) |> Map.data)
        ~vars:(List.map fst term)
        ~deg:(1 + List.fold_left Int.max 0 (List.map fst term))
        ~is_dfa:false
        ~ph:(get_extra t' term)
      |> fun x -> x)
  ;;
end
