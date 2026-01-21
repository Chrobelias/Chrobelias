(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

module Map = Nfa.Map
module Set = Base.Set.Poly

type varpos = int

module type Type = sig
  type t
  type v

  val n : unit -> t
  val z : unit -> t
  val power_of_two : int -> t
  val eq : ('a, int) Map.t -> ('a, Z.t) Map.t -> Z.t -> t
  val leq : ('a, int) Map.t -> ('a, Z.t) Map.t -> Z.t -> t
  val strlen : alpha:v list option -> dest:int -> src:int -> unit -> t
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
(* ------------------------- MSB types ------------------------- *)
(* ------------------------------------------------------------- *)

module Msb = struct
  module Bv = Nfa.Bv
  module Nfa = Nfa.Msb (Bv)

  type t = Nfa.t
  type v = unit

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

  (* Remark by Bernard Boigelot from "Symbolic methods and automata":

  An important difference between Algorithm 1 and Algorithm 2 is that the latter
  generally produces nondeterministic NDD. This may be problematic in some applications,
  in particular if automata need to be minimised in order to obtain canonical set
  representations.*)
  let strlen ~alpha ~(dest : int) ~(src : int) () =
    failwith "Unimplemented for string bitvectors"
  ;;
end

module MsbStr = struct
  module Str = Nfa.Str
  module Nfa = Nfa.Msb (Nfa.Str)

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
      let rec lp front =
        match front with
        | [] -> ()
        | hd :: tl ->
          if Set.mem !states hd
          then lp tl
          else begin
            let t =
              powerset (0 -- (basei - 1)) term
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
       let rec lp front =
         match front with
         | [] -> ()
         | hd :: tl ->
           if Set.mem !states hd
           then lp tl
           else begin
             let t =
               powerset (0 -- (basei - 1)) term
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

  let strlen ~alpha ~(dest : int) ~(src : int) () =
    let alpha = Option.value ~default:alphabet alpha in
    let alpha_transitions = List.map (fun c -> 0, [ c; Str.u_zero ], 0) alpha in
    let transitions =
      alpha_transitions @ [ 1, [ Str.u_eos; i ], 0 ] @ [ 1, [ Str.u_eos; Str.u_zero ], 1 ]
    in
    Nfa.create_nfa ~transitions ~start:[ 1 ] ~final:[ 0 ] ~vars:[ src; dest ] ~deg:2
  ;;
end

module MsbStrBv = struct
  module Str = Nfa.StrBv
  module Nfa = Nfa.Msb (Nfa.StrBv)

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
      let rec lp front =
        match front with
        | [] -> ()
        | hd :: tl ->
          if Set.mem !states hd
          then lp tl
          else begin
            let t =
              powerset (0 -- (basei - 1)) term
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
       let rec lp front =
         match front with
         | [] -> ()
         | hd :: tl ->
           if Set.mem !states hd
           then lp tl
           else begin
             let t =
               powerset (0 -- (basei - 1)) term
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
end

(* ------------------------------------------------------------- *)
(* ----------------------- MSB(IN) types ----------------------- *)
(* ------------------------------------------------------------- *)

module MsbNat = struct
  module Bv = Nfa.Bv
  module NfaMsb = Nfa.Msb (Bv)
  module NfaMsbNat = Nfa.MsbNat (Bv)

  type t = NfaMsbNat.t
  type v = unit

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
      Debug.printfln "Building div_in_pow nfa: var=%d, a=%d, c=%d" var a c;
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
  let leq vars term c = Msb.leq vars term c |> NfaMsb.to_nat

  let strlen ~alpha ~(dest : int) ~(src : int) () =
    failwith "Unimplemented for string bitvectors"
  ;;
end

module MsbNatStr = struct
  module Str = Nfa.Str
  module NfaMsb = Nfa.Msb (Str)
  module NfaMsbNat = Nfa.MsbNat (Str)

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
      Debug.printfln "Building div_in_pow nfa: var=%d, a=%d, c=%d" var a c;
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

  let eq vars term c = MsbStr.eq vars term c |> NfaMsb.to_nat
  let leq vars term c = MsbStr.leq vars term c |> NfaMsb.to_nat

  let strlen ~alpha ~(dest : int) ~(src : int) () =
    let alpha = Option.value ~default:alphabet alpha in
    let alpha_transitions = List.map (fun c -> 0, [ c; Str.u_zero ], 0) alpha in
    let transitions =
      alpha_transitions @ [ 1, [ Str.u_eos; i ], 0 ] @ [ 1, [ Str.u_eos; Str.u_zero ], 1 ]
    in
    NfaMsbNat.create_nfa ~transitions ~start:[ 1 ] ~final:[ 0 ] ~vars:[ src; dest ] ~deg:2
  ;;
end

module MsbNatStrBv = struct
  module Str = Nfa.StrBv
  module NfaMsb = Nfa.Msb (Str)
  module NfaMsbNat = Nfa.MsbNat (Str)

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
      Debug.printfln "Building div_in_pow nfa: var=%d, a=%d, c=%d" var a c;
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

  let eq vars term c = MsbStrBv.eq vars term c |> NfaMsb.to_nat
  let leq vars term c = MsbStrBv.leq vars term c |> NfaMsb.to_nat

  let strlen ~alpha ~(dest : int) ~(src : int) () =
    let alpha = Option.value ~default:alphabet alpha in
    let alpha_transitions = List.map (fun c -> 0, [ c; Str.u_zero ], 0) alpha in
    let transitions =
      alpha_transitions @ [ 1, [ Str.u_eos; i ], 0 ] @ [ 1, [ Str.u_eos; Str.u_zero ], 1 ]
    in
    NfaMsbNat.create_nfa ~transitions ~start:[ 1 ] ~final:[ 0 ] ~vars:[ src; dest ] ~deg:2
  ;;
end

(* ------------------------------------------------------------- *)
(* ------------------------- LSB types ------------------------- *)
(* ------------------------------------------------------------- *)

module Lsb = struct
  module Bv = Nfa.Bv
  module Nfa = Nfa.Lsb (Bv)

  type t = Nfa.t
  type v = unit

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
      Debug.printfln
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
      Debug.printfln
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

  let strlen ~alpha ~(dest : int) ~(src : int) () =
    failwith "Unimplemented for string bitvectors"
  ;;
end

module type STR = sig
  include Nfa.L

  val u_eos : u
  val u_one : u
end

module Make_Lsb_Str (Str : STR) : sig
  include NatType with type t = Nfa.Lsb(Str).t and type v = Str.u
end = struct
  module Nfa = Nfa.Lsb (Str)

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
      Debug.printfln
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
                  | i when Z.(zero <= i) && i < base -> Z.((hd - sum) / base)
                  | i when Z.(-base < i && i < zero) -> Z.(((hd - sum) / base) - one)
                  | _ -> failwith "Should be unreachable" ))
            in
            states := Set.add !states hd;
            transitions := t @ !transitions;
            lp (List.map (fun (_, _, x) -> x) t @ tl)
          end
      in
      lp [ c ];
      let states = Set.to_list !states in
      Debug.printfln
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

  let strlen ~alpha ~(dest : int) ~(src : int) () =
    let alpha = Option.value ~default:alphabet alpha in
    let alpha_transitions = List.map (fun c -> 0, [ c; Str.u_zero ], 0) alpha in
    let transitions =
      alpha_transitions @ [ 0, [ Str.u_eos; i ], 1 ] @ [ 1, [ Str.u_eos; Str.u_zero ], 1 ]
    in
    Nfa.create_nfa ~transitions ~start:[ 0 ] ~final:[ 1 ] ~vars:[ src; dest ] ~deg:2
  ;;
end

module LsbStr = Make_Lsb_Str (Nfa.Str)
module LsbStrBv = Make_Lsb_Str (Nfa.StrBv)
