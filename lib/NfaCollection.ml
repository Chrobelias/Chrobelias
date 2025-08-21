(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

module Map = Nfa.Map
module Set = Base.Set.Poly

type varpos = int

module type Type = sig
  type t

  val add : lhs:varpos -> rhs:varpos -> res:varpos -> t
  val eq_const : varpos -> int -> t
  val n : unit -> t
  val z : unit -> t
  val geq : varpos -> varpos -> t
  val lt : varpos -> varpos -> t
  val gt : varpos -> varpos -> t
  val power_of_two : int -> t
  val eq : ('a, int) Map.t -> ('a, int) Map.t -> int -> t
  val leq : ('a, int) Map.t -> ('a, int) Map.t -> int -> t
end

module type NatType = sig
  include Type

  val torename : varpos -> int -> int -> t
  val torename2 : int -> int -> t
  val mul : res:varpos -> lhs:int -> rhs:varpos -> t
end

let rec gcd a b =
  if a < 0 || b < 0 then gcd (abs a) (abs b) else if b = 0 then a else gcd b (a mod b)
;;

module Lsb = struct
  module Nfa = Nfa.Lsb

  type t = Nfa.t

  let add ~lhs ~rhs ~res =
    Nfa.create_nfa
      ~transitions:
        [ 0, 0b000, 0
        ; 0, 0b101, 0
        ; 0, 0b110, 0
        ; 0, 0b011, 1
        ; 1, 0b111, 1
        ; 1, 0b010, 1
        ; 1, 0b001, 1
        ; 1, 0b100, 0
        ]
      ~start:[ 0 ]
      ~final:[ 0 ]
      ~vars:[ res; rhs; lhs ]
      ~deg:((max lhs rhs |> max res) + 1)
  ;;

  let eq lhs rhs =
    Nfa.create_nfa
      ~transitions:[ 0, 0b00, 0; 0, 0b11, 0 ]
      ~start:[ 0 ]
      ~final:[ 0 ]
      ~vars:[ lhs; rhs ]
      ~deg:(max lhs rhs + 1)
  ;;

  let eq_const var (n : int) =
    let vec = Bitv.of_int_us n |> Bitv.to_list |> Bitv.of_list in
    let max = Bitv.length vec in
    let transitions =
      Bitv.foldi_right
        (fun i bit acc -> (i, (if bit then 1 else 0), i + 1) :: acc)
        vec
        [ max, 0, max ]
    in
    Nfa.create_nfa ~start:[ 0 ] ~final:[ max ] ~transitions ~vars:[ var ] ~deg:(var + 1)
  ;;

  let n () =
    Nfa.create_nfa ~transitions:[ 0, 0, 0 ] ~start:[ 0 ] ~final:[ 0 ] ~vars:[] ~deg:1
  ;;

  let z () = Nfa.create_nfa ~transitions:[] ~start:[ 0 ] ~final:[] ~vars:[] ~deg:1

  let leq lhs rhs =
    Nfa.create_nfa
      ~transitions:
        [ 0, 0b00, 0
        ; 0, 0b11, 0
        ; 0, 0b10, 0
        ; 0, 0b01, 1
        ; 1, 0b11, 1
        ; 1, 0b00, 1
        ; 1, 0b01, 1
        ; 1, 0b10, 0
        ]
      ~start:[ 0 ]
      ~final:[ 0 ]
      ~vars:[ rhs; lhs ]
      ~deg:(max lhs rhs + 1)
  ;;

  let geq x y = leq y x

  let lt lhs rhs =
    Nfa.create_nfa
      ~transitions:
        [ 0, 0b01, 1
        ; 0, 0b11, 0
        ; 0, 0b10, 0
        ; 0, 0b00, 0
        ; 1, 0b11, 1
        ; 1, 0b01, 1
        ; 1, 0b00, 1
        ; 1, 0b10, 0
        ]
      ~start:[ 0 ]
      ~final:[ 1 ]
      ~vars:[ lhs; rhs ]
      ~deg:(max lhs rhs + 1)
  ;;

  let gt x y = lt y x

  let torename var a c =
    if c = 0
    then (
      let trans1 = List.init a Fun.id |> List.map (fun x -> x, 0b0, x + 1) in
      Nfa.create_nfa
        ~transitions:([ a, 0b1, a + 1; a + 1, 0b0, a + 1 ] @ trans1)
        ~start:[ 0 ]
        ~final:[ a + 1 ]
        ~vars:[ var ]
        ~deg:(var + 1))
    else (
      let trans1 = List.init (a + c - 1) Fun.id |> List.map (fun x -> x, 0b0, x + 1) in
      Nfa.create_nfa
        ~transitions:([ a + c - 1, 0b0, a; a, 0b1, a + c; a + c, 0b0, a + c ] @ trans1)
        ~start:[ 0 ]
        ~final:[ a + c ]
        ~vars:[ var ]
        ~deg:(var + 1))
  ;;

  let torename2 var exp =
    Nfa.create_nfa
      ~transitions:[ 0, 0b10, 0; 0, 0b00, 0; 0, 0b11, 1; 1, 0b00, 1 ]
      ~start:[ 0 ]
      ~final:[ 1 ]
      ~vars:[ var; exp ]
      ~deg:(max var exp + 1)
  ;;

  let power_of_two exp =
    Nfa.create_nfa
      ~transitions:[ 0, 0b0, 0; 0, 0b1, 1; 1, 0b0, 1 ]
      ~start:[ 0 ]
      ~final:[ 1 ]
      ~vars:[ exp ]
      ~deg:(exp + 1)
  ;;

  let mul ~res ~lhs ~rhs =
    let rec helper ~res ~lhs ~rhs =
      match lhs with
      | 0 -> eq_const res 0
      | 1 -> eq res rhs
      | _ when lhs mod 2 = 0 ->
        let newvar = max (max res lhs) rhs + 1 in
        let a = helper ~res:newvar ~lhs:(lhs / 2) ~rhs in
        let b = add ~res ~lhs:newvar ~rhs:newvar in
        Nfa.intersect a b |> Nfa.project [ newvar ]
      | _ ->
        let newvar = max (max res lhs) rhs + 1 in
        let a = helper ~res:newvar ~lhs:(lhs - 1) ~rhs in
        let b = add ~res ~lhs:newvar ~rhs in
        Nfa.intersect a b |> Nfa.project [ newvar ]
    in
    helper ~res ~lhs ~rhs |> Nfa.minimize
  ;;

  let powerset term =
    let rec helper = function
      | [] -> []
      | [ x ] -> [ 0, [ 0 ]; 1, [ x ] ]
      | hd :: tl ->
        let open Base.List.Let_syntax in
        let ( let* ) = ( >>= ) in
        let* n, thing = helper tl in
        [ n, 0 :: thing; n + Int.shift_left 1 (List.length thing), hd :: thing ]
    in
    term
    |> List.map snd
    |> helper
    |> List.map (fun (a, x) -> a, Base.List.sum (module Base.Int) ~f:Fun.id x)
  ;;

  let eq vars term c =
    let term =
      Map.map_keys_exn ~f:(Map.find_exn vars) term
      |> Map.to_alist
      |> List.filter (fun (_, v) -> v <> 0)
    in
    let gcd = List.fold_left (fun acc (_, data) -> gcd data acc) 0 term in
    if gcd = 0
    then if 0 = c then n () else z ()
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
              |> List.filter (fun (_, sum) -> (hd - sum) mod 2 = 0)
              |> List.map (fun (bits, sum) -> hd, bits, (hd - sum) / 2)
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
           (fun fmt a -> Format.fprintf fmt "%d" a))
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
        ~final:(idxs 0)
        ~vars:(List.map fst term)
        ~deg:(1 + List.fold_left Int.max 0 (List.map fst term)))
  ;;

  let leq vars term c =
    let term = Map.map_keys_exn ~f:(Map.find_exn vars) term |> Map.to_alist in
    let gcd = List.fold_left (fun acc (_, data) -> gcd data acc) 0 term in
    if gcd = 0
    then if 0 <= c then n () else z ()
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
                , match (hd - sum) mod 2 with
                  | 0 | 1 -> (hd - sum) / 2
                  | -1 -> ((hd - sum) / 2) - 1
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
           (fun fmt a -> Format.fprintf fmt "%d" a))
        states;
      let states = states |> List.mapi (fun i x -> x, i) |> Map.of_alist_exn in
      let idx c = Map.find states c |> Option.get in
      let transitions = List.map (fun (a, b, c) -> idx a, b, idx c) !transitions in
      Nfa.create_nfa
        ~transitions
        ~start:[ idx c ]
        ~final:(states |> Map.filter_keys ~f:(fun x -> x >= 0) |> Map.data)
        ~vars:(List.map fst term)
        ~deg:(1 + List.fold_left Int.max 0 (List.map fst term)))
  ;;
end

module Msb = struct
  module Nfa = Nfa.Msb

  type t = Nfa.t

  let add ~lhs ~rhs ~res =
    Nfa.create_nfa
      ~transitions:
        [ 0, 0b000, 0
        ; 0, 0b101, 0
        ; 0, 0b001, 1
        ; 0, 0b011, 0
        ; 1, 0b111, 1
        ; 1, 0b010, 1
        ; 1, 0b100, 1
        ; 1, 0b110, 0
        ; 2, 0b000, 0
        ; 2, 0b011, 0
        ; 2, 0b101, 0
        ; 2, 0b100, 1
        ; 2, 0b010, 1
        ; 2, 0b111, 1
        ]
      ~start:[ 2 ]
      ~final:[ 0 ]
      ~vars:[ lhs; rhs; res ]
      ~deg:((max lhs rhs |> max res) + 1)
  ;;

  let eq_const var (n : int) =
    let transitions, max =
      let rec helper acc cnt v =
        let d = if v mod 2 = 0 then 0 else 1 in
        let v' = (v - d) / 2 in
        if v' = v
        then (cnt, d, cnt) :: acc, cnt
        else (
          let nxt = succ cnt in
          helper ((nxt, d, cnt) :: acc) nxt v')
      in
      helper [] 0 n
    in
    let transitions = (max + 1, (if n >= 0 then 0 else 1), max) :: transitions in
    Nfa.create_nfa
      ~start:[ max + 1 ]
      ~final:[ 0 ]
      ~transitions
      ~vars:[ var ]
      ~deg:(var + 1)
  ;;

  let n () =
    Nfa.create_nfa ~transitions:[ 0, 0, 0 ] ~start:[ 0 ] ~final:[ 0 ] ~vars:[] ~deg:1
  ;;

  let z () = Nfa.create_nfa ~transitions:[] ~start:[ 0 ] ~final:[] ~vars:[] ~deg:1

  let leq lhs rhs =
    Nfa.create_nfa
      ~transitions:
        [ 0, 0b00, 0
        ; 0, 0b11, 0
        ; 0, 0b01, 0
        ; 1, 0b10, 0
        ; 1, 0b11, 1
        ; 1, 0b00, 1
        ; 1, 0b10, 1
        ; 0, 0b01, 1
        ; 2, 0b11, 0
        ; 2, 0b00, 0
        ; 2, 0b10, 0
        ; 2, 0b10, 1
        ]
      ~start:[ 2 ]
      ~final:[ 0 ]
      ~vars:[ lhs; rhs ]
      ~deg:(max lhs rhs + 1)
  ;;

  let geq x y = leq y x

  let lt lhs rhs =
    Nfa.create_nfa
      ~transitions:
        [ 0, 0b11, 0
        ; 0, 0b00, 0
        ; 0, 0b01, 1
        ; 1, 0b11, 1
        ; 1, 0b01, 1
        ; 1, 0b00, 1
        ; 1, 0b10, 1
        ; 2, 0b10, 1
        ; 2, 0b00, 0
        ; 2, 0b11, 0
        ]
      ~start:[ 2 ]
      ~final:[ 1 ]
      ~vars:[ lhs; rhs ]
      ~deg:(max lhs rhs + 1)
  ;;

  let gt x y = lt y x

  let power_of_two exp =
    Nfa.create_nfa
      ~transitions:[ 0, 0b0, 0; 0, 0b1, 1; 1, 0b0, 1; 2, 0b0, 0 ]
      ~start:[ 2 ]
      ~final:[ 1 ]
      ~vars:[ exp ]
      ~deg:(exp + 1)
  ;;

  let div a b = if a mod b >= 0 then a / b else (a / b) - 1

  let powerset term =
    let rec helper = function
      | [] -> []
      | [ x ] -> [ 0, [ 0 ]; 1, [ x ] ]
      | hd :: tl ->
        let open Base.List.Let_syntax in
        let ( let* ) = ( >>= ) in
        let* n, thing = helper tl in
        [ n, 0 :: thing; n + Int.shift_left 1 (List.length thing), hd :: thing ]
    in
    term
    |> List.map snd
    |> helper
    |> List.map (fun (a, x) -> a, Base.List.sum (module Base.Int) ~f:Fun.id x)
  ;;

  let eq vars term c =
    let term =
      Map.map_keys_exn ~f:(Map.find_exn vars) term
      |> Map.to_alist
      |> List.filter (fun (_, v) -> v <> 0)
    in
    let gcd = List.fold_left (fun acc (_, data) -> gcd data acc) 0 term in
    if gcd = 0
    then if 0 = c then n () else z ()
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
              |> List.filter (fun (_, sum) -> (hd - sum) mod (2 * gcd) = 0)
              |> List.map (fun (bits, sum) -> div (hd - sum) 2, bits, hd)
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
           match Map.find states (-sum) with
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
      |> List.filter (fun (_, v) -> v <> 0)
    in
    let gcd = List.fold_left (fun acc (_, data) -> gcd data acc) 0 term in
    if gcd = 0
    then if 0 <= c then n () else z ()
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
              |> List.map (fun (bits, sum) -> gcd * div (hd - sum) (2 * gcd), bits, hd)
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
             if -sum <= v then Some (start, d, idv) else None)))
        @ transitions
      in
      Nfa.create_nfa
        ~transitions
        ~start:[ start ]
        ~final:(states |> Map.filter_keys ~f:(fun x -> x <= c) |> Map.data)
        ~vars:(List.map fst term)
        ~deg:(1 + List.fold_left Int.max 0 (List.map fst term))
      |> fun x -> x)
  ;;
end

module MsbNat = struct
  type t = Nfa.MsbNat.t

  let n () =
    Nfa.MsbNat.create_nfa
      ~transitions:[ 0, 0, 0 ]
      ~start:[ 0 ]
      ~final:[ 0 ]
      ~vars:[]
      ~deg:1
  ;;

  let z () = Nfa.MsbNat.create_nfa ~transitions:[] ~start:[ 0 ] ~final:[] ~vars:[] ~deg:1
  let add ~lhs ~rhs ~res = Msb.add ~res ~lhs ~rhs |> Nfa.Msb.to_nat
  let eq_const res n = Msb.eq_const res n |> Nfa.Msb.to_nat
  let geq lhs rhs = Msb.geq lhs rhs |> Nfa.Msb.to_nat

  let mul ~res ~lhs ~rhs =
    let rec helper ~res ~lhs ~rhs =
      match lhs with
      | 0 -> eq_const res 0
      (*| 1 -> eq res rhs*)
      | _ when lhs mod 2 = 0 ->
        let newvar = max (max res lhs) rhs + 1 in
        let a = helper ~res:newvar ~lhs:(lhs / 2) ~rhs in
        let b = add ~res ~lhs:newvar ~rhs:newvar in
        Nfa.MsbNat.intersect a b |> Nfa.MsbNat.project [ newvar ]
      | _ ->
        let newvar = max (max res lhs) rhs + 1 in
        let a = helper ~res:newvar ~lhs:(lhs - 1) ~rhs in
        let b = add ~res ~lhs:newvar ~rhs in
        Nfa.MsbNat.intersect a b |> Nfa.MsbNat.project [ newvar ]
    in
    helper ~res ~lhs ~rhs |> Nfa.MsbNat.minimize
  ;;

  let torename var a c =
    if c = 0
    then (
      let trans1 = List.init a Fun.id |> List.map (fun x -> x + 1, 0b0, x) in
      let nfa =
        Nfa.MsbNat.create_nfa
          ~transitions:([ a + 1, 0b1, a; a + 1, 0b0, a + 1 ] @ trans1)
          ~start:[ a + 1 ]
          ~final:[ 0 ]
          ~vars:[ var ]
          ~deg:(var + 1)
      in
      Debug.printfln "Building torename nfa: var=%d, a=%d, c=%d" var a c;
      Debug.dump_nfa ~msg:"Nfa: %s" Nfa.MsbNat.format_nfa nfa;
      nfa)
    else (
      let trans1 = List.init (a + c - 1) Fun.id |> List.map (fun x -> x, 0b0, x + 1) in
      Nfa.MsbNat.create_nfa
        ~transitions:([ a + c - 1, 0b0, a; a, 0b1, a + c; a + c, 0b0, a + c ] @ trans1)
        ~start:[ 0 ]
        ~final:[ a + c ]
        ~vars:[ var ]
        ~deg:(var + 1))
  ;;

  let torename2 var exp =
    Nfa.MsbNat.create_nfa
      ~transitions:[ 0, 0b10, 0; 0, 0b00, 0; 1, 0b11, 0; 1, 0b00, 1 ]
      ~start:[ 1 ]
      ~final:[ 0 ]
      ~vars:[ var; exp ]
      ~deg:(max var exp + 1)
  ;;

  let power_of_two exp =
    Nfa.MsbNat.create_nfa
      ~transitions:[ 0, 0b0, 0; 0, 0b1, 1; 1, 0b0, 1; 2, 0b0, 0 ]
      ~start:[ 2 ]
      ~final:[ 1 ]
      ~vars:[ exp ]
      ~deg:(exp + 1)
  ;;

  let lt lhs rhs = Msb.lt lhs rhs |> Nfa.Msb.to_nat
  let gt lhs rhs = Msb.gt lhs rhs |> Nfa.Msb.to_nat
  let eq vars term c = Msb.eq vars term c |> Nfa.Msb.to_nat
  let leq vars term c = Msb.leq vars term c |> Nfa.Msb.to_nat
end
