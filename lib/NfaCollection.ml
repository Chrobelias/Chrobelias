let trace_log fmt = Debug.trace "nfa_collection" fmt
let _config = Config.config
let _base = _config.enc_base

module Map = Nfa.Map
module Set = Base.Set.Poly

type varpos = int

module type Type = sig
  type t
  type v

  val n : unit -> t
  val z : unit -> t
  val power_of_base : int -> t
  val buchi : int -> int -> t
  val eq : (Ir.atom, int) Map.t -> (Ir.atom, Z.t) Map.t -> Z.t -> t
  val neq : (Ir.atom, int) Map.t -> (Ir.atom, Z.t) Map.t -> Z.t -> t
  val leq : (Ir.atom, int) Map.t -> (Ir.atom, Z.t) Map.t -> Z.t -> t
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
  let alphabet = Str.alphabet |> List.to_seq |> Seq.take _base |> List.of_seq
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

  let buchi var exp = failwith "Unimplemented"

  let powerset term =
    let rec helper = function
      | [] -> []
      | [ x ] ->
        ([ Str.u_eos ], [ Z.zero ])
        :: (0 -- (_base - 1) |> List.map (fun c -> [ itoc c ], [ Z.(x * of_int c) ]))
      | hd :: tl ->
        let open Base.List.Let_syntax in
        let ( let* ) = ( >>= ) in
        let* n, thing = helper tl in
        (Str.u_eos :: n, Z.zero :: thing)
        :: (0 -- (_base - 1)
            |> List.map (fun c -> itoc c :: n, Z.(hd * of_int c) :: thing))
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
              |> List.filter (fun (_, sum) -> Z.((hd - sum) mod Z.of_int _base = zero))
              |> List.map (fun (bits, sum) -> hd, bits, Z.((hd - sum) / Z.of_int _base))
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
                , match Z.((hd - sum) mod Z.of_int _base) with
                  | i when Z.(zero <= i) && i < Z.of_int _base ->
                    Z.((hd - sum) / Z.of_int _base)
                  | i when Z.(-Z.of_int _base < i && i < zero) ->
                    Z.(((hd - sum) / Z.of_int _base) - one)
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

module MsbSym = struct
  module Sym = Nfa.Sym
  module Nfa = Nfa.Symbolic (Nfa.Sym)

  type t = Nfa.t
  type v = Sym.u

  (** returns an nfa recognizing every integer base [_base]*)
  let n () =
    Nfa.create_nfa ~transitions:[ 0, [], 0 ] ~start:[ 0 ] ~final:[ 0 ] ~vars:[] ~deg:1
  ;;

  (** returns an nfa recognizing the empty language. *)

  let z () = Nfa.create_nfa ~transitions:[] ~start:[ 0 ] ~final:[] ~vars:[] ~deg:1

  (** [power_of_base exp] returns an nfa recognizing Pow([exp]). *)
  let power_of_base exp = failwith "TODO"

  let buchi var exp =
    let open AstL in
    let open AstL.Lia in
    let _base = _config.enc_base in
    (* trace_log "Base in symbolic Buchi: %d" _base; *)
    let get_const v value = Lia (eq (get v) value) in
    let get_label d1 d2 = land_ [ get_const var d1; get_const exp d2 ] in
    Nfa.create_nfa2
      ~transitions:
        [ 2, get_label (const Z.zero) (const Z.zero), 1
        ; 2, get_label (const Z.(of_int _base - one)) (const Z.zero), 1
        ; 1, get_label (const Z.zero) (const Z.zero), 1
        ; 1, get_label (const Z.(of_int _base - one)) (const Z.zero), 1
        ; 1, land_ [ Lia (geq (get var) (const Z.one)); get_const exp (const Z.one) ], 0
        ; 0, get_const exp (const Z.zero), 0
        ]
      ~start:[ 2 ]
      ~final:[ 0 ]
      ~vars:[ var; exp ]
      ~deg:(max var exp + 1)
  ;;

  let get_label base t' v' op v =
    let open AstL.Lia in
    AstL.Lia
      (op
         (Atom t')
         (* (add
            (* (mul [ const v'; AstL.get_par 0 ] *)
            (* (const Z.(v' * base)
             ::  *)
            (List.map (fun (var, coeff) -> mul [ const coeff; AstL.get var ]) term)) *)
         (const Z.(v - (v' * Z.of_int base))))
  ;;

  let get_extra t' term =
    let open AstL.Lia in
    AstL.Lia
      (eq
         (Atom t')
         (add (List.map (fun (var, coeff) -> mul [ const coeff; AstL.get var ]) term)))
  ;;

  let get_sign_label base t' v term op =
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
            (const Z.(v * (one - Z.of_int base))))
       :: List.map
            (fun (var, _) ->
               lor_
                 [ Lia (eq (get var) (const Z.zero))
                 ; Lia (eq (get var) (const Z.(Z.of_int base - one)))
                 ])
            term)
  ;;

  (** [eq vars term c] returns an nfa recognizing the equality [term]*[vars] = [c]. 
  Here, [term] is a list of [Z.t] coefficients and [vars] is a list of variables 
  (having the same length). *)
  let eq vars term c =
    let _base = _config.enc_base in
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
          |> both (fun x -> Z.(state - (x * (Z.of_int _base - one))))
        in
        let lb =
          if Z.(lower mod (Z.of_int _base * gcd_) = zero)
          then div_ lower (Z.of_int _base)
          else Z.((div_ lower (Z.of_int _base * gcd_) + one) * gcd_)
        in
        let ub =
          if Z.(upper mod (Z.of_int _base * gcd_) = zero)
          then div_ upper (Z.of_int _base)
          else Z.(div_ upper (Z.of_int _base * gcd_) * gcd_)
        in
        trace_log
          "lb and up for the state %d are %d and %d"
          (Z.to_int state)
          (Z.to_int lb)
          (Z.to_int ub);
        get_list lb ub gcd_
        |> List.map (fun prev -> prev, get_label _base t' prev eq state, state)
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
           | Some idv ->
             Some (start, get_sign_label _base t' Z.(sum / minus_one) term eq, idv)))
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
    let _base = _config.enc_base in
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
          |> both (fun x -> Z.(state - (x * (Z.of_int _base - one))))
          |> both (fun x -> Z.(div_ x (Z.of_int _base * gcd_) * gcd_))
        in
        trace_log
          "lb and up for the state %d are %d and %d"
          (Z.to_int state)
          (Z.to_int lb)
          (Z.to_int ub);
        get_list lb ub gcd_
        |> List.map (fun prev ->
          ( prev
          , AstL.land_
              [ get_label _base t' prev leq state
              ; get_label _base t' Z.(prev + gcd_) geq state
              ]
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
           then Some (start, get_sign_label _base t' v term geq, idv)
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

module MsbPar = struct
  module Sym = Nfa.Sym
  module Nfa = Nfa.Parametric (Nfa.Sym)

  type t = Nfa.t
  type v = Sym.u

  (** returns an nfa recognizing every integer base [_base]*)
  let n () =
    Nfa.create_nfa ~transitions:[ 0, [], 0 ] ~start:[ 0 ] ~final:[ 0 ] ~vars:[] ~deg:1
  ;;

  (** returns an nfa recognizing the empty language. *)

  let z () = Nfa.create_nfa ~transitions:[] ~start:[ 0 ] ~final:[] ~vars:[] ~deg:1

  (** [power_of_base exp] returns an nfa recognizing Pow([exp]). *)
  let power_of_base exp = failwith "TODO"

  let buchi var exp =
    let open AstL in
    let open AstL.Lia in
    let get_const v value = Lia (eq (get v) value) in
    let get_label d1 d2 = land_ [ get_const var d1; get_const exp d2 ] in
    Nfa.create_nfa2
      ~transitions:
        [ 2, get_label (const Z.zero) (const Z.zero), 1
        ; 2, get_label get_max_digit (const Z.zero), 1
        ; 1, get_label (const Z.zero) (const Z.zero), 1
        ; 1, get_label get_max_digit (const Z.zero), 1
        ; 1, land_ [ Lia (geq (get var) (const Z.one)); get_const exp (const Z.one) ], 0
        ; 0, get_const exp (const Z.zero), 0
        ]
      ~start:[ 2 ]
      ~final:[ 0 ]
      ~vars:[ var; exp ]
      ~deg:(max var exp + 1)
  ;;

  let get_label t' v' op v =
    let open AstL in
    let open AstL.Lia in
    Lia (op (Atom t') (add [ const v; mul [ const Z.(-v'); get_par 0 ] ]))
  ;;

  let get_extra t' term =
    let open AstL in
    let open AstL.Lia in
    Lia
      (eq
         (Atom t')
         (add (List.map (fun (var, coeff) -> mul [ const coeff; AstL.get var ]) term)))
  ;;

  let get_sign_label_par t' v term op =
    let open AstL in
    let open AstL.Lia in
    land_
      (Lia
         (op
            (Atom t')
            (mul [ const v; add [ const Z.one; mul [ get_par 0; const Z.minus_one ] ] ]))
       :: List.map
            (fun (var, _) ->
               lor_
                 [ Lia (eq (get var) (const Z.zero)); Lia (eq (get var) get_max_digit) ])
            term)
  ;;

  (** [eq vars term c] returns an nfa recognizing the equality [term]*[vars] = [c]. 
  Here, [term] is a list of [Z.t] coefficients and [vars] is a list of variables 
  (having the same length). *)
  let eq vars term c =
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
      assert (Z.(gcd_ = one));
      let states = ref Set.empty in
      let transitions = ref [] in
      let get_incoming state =
        let ap, an =
          List.fold_left
            (fun (p, n) (_, a) -> if Z.(a > zero) then Z.(p + a), n else p, Z.(n + a))
            (Z.zero, Z.zero)
            term
        in
        let bmin, bmax = Z.of_int _config.base_min, Z.of_int _config.base_max in
        let lb =
          if Z.(state < zero)
          then Z.(div_ state bmin - div_ (ap * (bmax - one)) bmax)
          else Z.(div_ state bmax - div_ (ap * (bmax - one)) bmax)
        in
        let ub =
          if Z.(state < zero)
          then Z.(div_ state bmax - div_ (an * (bmin - one)) bmin)
          else Z.(div_ state bmin - div_ (an * (bmin - one)) bmin - one)
        in
        trace_log
          "lb and up for the state %d are %d and %d"
          (Z.to_int state)
          (Z.to_int lb)
          (Z.to_int ub);
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
        (Map.to_alist states
         |> List.map (fun (v, idv) -> start, get_sign_label_par t' v term eq, idv))
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
      assert (Z.(gcd_ = one));
      let states = ref Set.empty in
      let transitions = ref [] in
      let get_incoming state =
        let ap, an =
          List.fold_left
            (fun (p, n) (_, a) -> if Z.(a > zero) then Z.(p + a), n else p, Z.(n + a))
            (Z.zero, Z.zero)
            term
        in
        let bmin, bmax = Z.of_int _config.base_min, Z.of_int _config.base_max in
        let lb =
          if Z.(state < zero)
          then Z.(div_ state bmin - div_ (ap * (bmax - one)) bmax)
          else Z.(div_ state bmax - div_ (ap * (bmax - one)) bmax)
        in
        let ub =
          if Z.(state < zero)
          then Z.(div_ state bmax - div_ (an * (bmin - one)) bmin)
          else Z.(div_ state bmin - div_ (an * (bmin - one)) bmin - one)
        in
        trace_log
          "lb and up for the state %d are %d and %d"
          (Z.to_int state)
          (Z.to_int lb)
          (Z.to_int ub);
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
        (Map.to_alist states
         |> List.map (fun (v, idv) -> start, get_sign_label_par t' v term geq, idv))
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
