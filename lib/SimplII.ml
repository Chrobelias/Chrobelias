[@@@warning "-unused-value-declaration"]
[@@@warnerror "-unused-open"]
[@@@warnerror "-unused-var"]

let log = Utils.log

module Term_map = Map.Make (struct
    type t =
      [ `Eia of Ast.Eia.term
      | `Str of Ast.Str.term
      ]

    let compare = Stdlib.compare
  end)

type error = Non_linear_arith of Ast.Eia.term list

let compare_error : error -> _ = Stdlib.compare

let pp_error ppf = function
  | Non_linear_arith ts ->
    Format.fprintf ppf "@[<v 2>";
    Format.fprintf ppf "@[Non linear arithmetic between@]@,";
    List.iteri (fun i -> Format.fprintf ppf "@[%d) %a@]@," i Ast.pp_term_smtlib2) ts;
    Format.fprintf ppf "@]"
;;

let check_errors ph =
  let open Ast.Eia in
  let not_a_const = function
    | Atom (Const _) -> false
    | _ -> true
  in
  let on_term acc = function
    | Mul xs ->
      let xs = List.filter not_a_const xs in
      (match xs with
       | [ Atom (Const _) ] -> assert false
       | [ Pow (Atom (Const _), _) ] | [ Atom (Var _) ] | [] -> acc
       | xs -> Non_linear_arith xs :: acc)
    | Pow (base, Atom (Const _)) as ans when not_a_const base ->
      Non_linear_arith [ ans ] :: acc
    | _ -> acc
  in
  Ast.fold
    (fun errs -> function
       | Ast.Eia eia -> Ast.Eia.fold2 (fun acc _ -> acc) on_term errs eia
       | _ -> errs)
    []
    ph
  |> Base.List.dedup_and_sort ~compare:compare_error
;;

let has_unsupported_nonlinearity =
  let open Ast.Eia in
  let not_a_const = function
    | Atom (Const _) -> false
    | _ -> true
  in
  let on_term acc = function
    | Mul xs ->
      let xs = List.filter not_a_const xs in
      (match xs with
       | [ Atom (Const _) ] -> assert false
       | [ Pow (Atom (Const _), _) ] | [ Atom (Var _) ] | [] -> acc
       | xs ->
         let rec loop acc = function
           | [ _ ] | [] -> acc
           | Atom (Var _) :: Atom (Var _) :: _ -> (*Ast.Eia.mul [ l; r ] ::*) acc
           | h :: tl -> loop acc tl
         in
         loop acc xs)
    | Pow (base, Atom (Const _)) as t when not_a_const base -> t :: acc
    | _ -> acc
  in
  fun ph ->
    let f acc = function
      | Ast.Eia eia -> Ast.Eia.fold2 (fun acc _ -> acc) on_term acc eia
      | _ -> acc
    in
    match Ast.fold f [] ph with
    | [] -> Result.Ok ()
    | xs -> Result.Error (Base.List.dedup_and_sort ~compare:Ast.Eia.compare_term xs)
;;

let is_pure_lia ph = [] = check_errors ph

type relop =
  | Leq
  | Eq

module type SYM0 = sig
  type term
  type ph

  include FT_SIG.s_term with type term := term
  include FT_SIG.s_ph with type ph := ph and type term := term

  val sofi : term -> term
  val iofs : term -> term
  val str_from_eia_const : Z.t -> term
  val str_len2 : string -> term
  val str_at : term -> string -> term
  val str_substr : term -> string -> string -> term
  val str_prefixof : term -> term -> ph
  val str_contains : term -> term -> ph
  val str_suffixof : term -> term -> ph

  (* String formulas *)
  val str_concat : term -> term -> term
  val str_equal : term -> term -> ph

  (* All formulas  *)
  val pow2var : string -> term
  val exists : string list -> ph -> ph
end

module type SYM = sig
  include SYM0

  type repr

  val prj : ph -> repr [@@warning "-32"]
  val pp_str : Format.formatter -> term -> unit
end

module type SYM_SUGAR = sig
  include SYM
  include FT_SIG.s_extra with type ph := ph and type term := term
end

module type SYM_SUGAR_AST =
  SYM_SUGAR with type ph = Ast.t and type repr = Ast.t and type term = Ast.Eia.term

let distribute xs =
  let open Ast in
  List.fold_left
    (fun acc -> function
       | Eia.Add ys -> List.concat_map (fun zs -> List.map (fun h -> h :: zs) ys) acc
       | other -> List.map (fun x -> other :: x) acc)
    ([ [] ] : _ list list)
    xs
;;

let compare_ast l r =
  match l, r with
  | Ast.True, Ast.True -> 0
  | True, _ -> -1
  | _, True -> 1
  | Lnot _, _ -> -1
  | _, Lnot _ -> 1
  | _ -> Ast.compare l r
;;

module Id_symantics :
  SYM with type ph = Ast.t and type repr = Ast.t and type term = Ast.Eia.term = struct
  type term = Ast.Eia.term

  let pp_str = Ast.Str.pp_term

  type ph = Ast.t
  type repr = Ast.t

  (** Terms *)
  let bw k a b =
    match k with
    | FT_SIG.Bwand -> Ast.Eia.bwand a b
    | FT_SIG.Bwor -> Ast.Eia.bwor a b
    | FT_SIG.Bwxor -> Ast.Eia.bwxor a b
  ;;

  (* let str_atoi = function
    | Ast.Eia.Atom (Var s) as x -> x
    (* *)
    | Atom (Str_const s) -> Ast.Eia.Stoi (Ast.Str.Const s)
    | x ->
      log "%s %d: %a\n%!" __FILE__ __LINE__ Ast.Str.pp_term x;
      assert false
  ;; *)

  let str_equal s1 s2 = Ast.eia (Ast.Eia.eq s1 s2)
  let str_var s = Ast.Eia.Atom (Ast.Var s)
  let in_re l regex = Ast.Str (Ast.Str.InRe (l, regex))
  let str_len s = Ast.Eia.Len s
  let str_len2 s1 = Ast.Eia.len2 (Ast.var s1)
  let iofs x = Ast.Eia.Iofs x
  let sofi x = Ast.Eia.Sofi x

  (* let str_from_eia s = Ast.Str.FromEia (Ast.var s) *)
  let str_prefixof s1 s2 = Ast.str (Ast.Str.prefixof s1 s2)
  let str_contains s1 s2 = Ast.str (Ast.Str.contains s1 s2)
  let str_suffixof s1 s2 = Ast.str (Ast.Str.suffixof s1 s2)

  (* let str_from_eia_const c = Ast.Eia.Atom (Str_const (Z.to_string c))
  let str_concat s1 s2 = Ast.Eia.concat s1 s2 *)
  let str_from_eia_const c = Ast.Eia.sofi (Atom (Const c))
  let str_concat s1 s2 = Ast.Eia.concat s1 s2
  let len = Ast.Eia.len
  let mod_ = Ast.Eia.mod_
  let pow = Ast.Eia.pow
  let mul = Ast.Eia.mul
  let add = Ast.Eia.add
  let land_ xs = Ast.Land xs
  let lor_ xs = Ast.Lor xs
  let not = Ast.lnot

  include Ast

  let str_const s : term = Ast.Eia.Atom (Str_const s)
  let constz s = Ast.Eia.Atom (Ast.Const s)
  let const s : term = constz (Z.of_int s)
  let var s = Ast.Eia.Atom (Ast.Var s)
  let exists var ph = Ast.Exists (List.map Ast.var var, ph)
  let eq l r = Ast.Eia (Ast.Eia.eq l r)
  let leq l r = Ast.Eia (Ast.Eia.leq l r)
  let lt l r = Ast.Eia (Ast.Eia.lt l r)
  let prj = Fun.id
  let pow2var s = pow (const Z.(Config.base () |> to_int)) (var s)
  let str_at s a = Ast.Eia.at s (Ast.Var a)
  let str_substr s a b = Ast.Eia.substr s (Ast.Var a) (Ast.Var b)
end

let apply_term_symantics (type a) (module S : SYM_SUGAR with type term = a) =
  let rec helperT = function
    | Ast.Eia.Atom (Ast.Const n) -> S.const (Z.to_int n)
    | Atom (Str_const s) -> S.str_const s
    | Atom (Ast.Var s) -> S.var s
    | Add terms -> S.add (List.map helperT terms)
    | Mul terms -> S.mul (List.map helperT terms)
    | Pow (Atom (Ast.Const base), Atom (Ast.Var x)) when base = Config.base () ->
      S.pow2var x
    | Pow (base, p) -> S.pow (helperT base) (helperT p)
    | Bwand (l, r) -> S.bw FT_SIG.Bwand (helperT l) (helperT r)
    | Bwor (l, r) -> S.bw FT_SIG.Bwor (helperT l) (helperT r)
    | Bwxor (l, r) -> S.bw FT_SIG.Bwxor (helperT l) (helperT r)
    | Mod (t, z) -> S.mod_ (helperT t) z
    | (Iofs (Ast.Eia.Atom (Const _)) | Len (Ast.Eia.Atom (Const _))) as t ->
      Format.eprintf "%a\n%!" Ast.Eia.pp_term t;
      failwith "Strlen/Stoi should not be called from int constants. Types are bad"
    | Len (Ast.Eia.Atom (Str_const s)) -> S.const (String.length s)
    | Len t -> S.str_len (helperT t)
    | Iofs (Ast.Eia.Atom (Str_const s)) ->
      (match int_of_string_opt s with
       | Some n -> S.const n
       | None -> S.iofs (S.str_const s))
    | Iofs t -> S.iofs (helperT t)
    | Len2 (Var s) -> S.str_len2 s
    | Len2 (Const _) -> failwith "TBD"
    | Sofi eia -> S.sofi (helperT eia)
    | Concat (s1, s2) -> S.str_concat (helperT s1) (helperT s2)
    | Substr (s1, Var a, Var b) -> S.str_substr (helperT s1) a b
    | Substr (s1, _, _) -> failwith "unimplemented"
    | At (s1, Var a) -> S.str_at (helperT s1) a
    | At (s1, _) -> failwith "unimplemented"
    | eia -> failwith (Format.asprintf "Not yet implement: %a" Ast.pp_term_smtlib2 eia)
  in
  helperT
;;

let apply_symantics (type a) (module S : SYM_SUGAR with type ph = a) =
  let helperT = apply_term_symantics (module S) in
  let rec helper = function
    | Ast.Land xs -> S.land_ (List.map helper xs)
    | Lor xs -> S.lor_ (List.map helper xs)
    | Lnot x -> S.not (helper x)
    | True -> S.true_
    | Eia e -> helper_eia e
    | Pred s -> assert false
    | Exists (vs, ph) ->
      let vs =
        List.filter_map
          (function
            (* These repeats very often  *)
            | Ast.Var s -> Some s
            | Str_const _ | Const _ -> None)
          vs
      in
      S.exists vs (helper ph)
    | Str (Ast.Str.PrefixOf (term, term')) ->
      S.str_prefixof (helperT term) (helperT term')
    | Str (Ast.Str.Contains (term, term')) ->
      S.str_contains (helperT term) (helperT term')
    | Str (Ast.Str.SuffixOf (term, term')) ->
      S.str_suffixof (helperT term) (helperT term')
    | Str (Ast.Str.InRe (term, regex)) -> S.in_re (helperT term) regex
  (* | Str (Ast.Str.Eq (term, term')) ->
      let l = helperT term in
      let r = helperT term' in
      (* Format.printf "Apply Str.Eq: l = %a, r = %a\n%!" S.pp_str l S.pp_str r; *)
      S.str_equal l r *)
  and helper_eia eia =
    match eia with
    | Ast.Eia.Eq (l, r) -> S.(helperT l = helperT r)
    | Leq (l, r) -> S.(helperT l <= helperT r)
  in
  fun x -> helper x
;;

let apply_symantics_unsugared (type a) (module S : SYM with type ph = a) =
  let module M = struct
    include S
    include FT_SIG.Sugar (S)
  end
  in
  apply_symantics (module M)
;;

let make_main_symantics env =
  let _ : Env.t = env in
  let module Main_symantics_ = struct
    open Ast
    include Id_symantics

    let compare_term = Eia.compare_term
    let constz c = Eia.Atom (Ast.const c)
    let const c = constz (Z.of_int c)

    let var s : term =
      match Env.lookup s env with
      | Some (Eia.Iofs _)
      | Some (Eia.Sofi _)
      | Some (Eia.Len _)
      | Some (Eia.Len2 _)
      | None -> Eia.Atom (Ast.var s)
      | Some c ->
        log "Substuting %s ~~> %a" s Ast.pp_term_smtlib2 c;
        c
    ;;

    let pow2var v = Ast.Eia.Pow (const Z.(Config.base () |> to_int), var v)

    (* let str_from_eia s =
      match Env.lookup s env with
      | Some (Ast.Eia.Atom (Ast.Const c)) -> Ast.Str.fromeia (Ast.const c)
      | _ -> Ast.Eia.fromeia (Ast.var s)
    ;; *)

    let str_equal l r = assert false
    (* if Eia.eq_term l r
      then true_
      else (
        match l, r with
        | Eia.Sofi (Var v1 as l), Str.FromEia (Var v2 as r) ->
          Str (Str.Eq (Str.Atom l, Str.Atom r))
        | Str.FromEia (Const v1), Str.Const r | Str.Const r, Str.FromEia (Const v1) ->
          let l = Z.to_string v1 in
          if
            String.length l <= String.length r
            && String.ends_with ~suffix:l r
            && String.for_all
                 (Char.equal '0')
                 (String.sub r (String.length l) (String.length r - String.length l))
          then Ast.true_
          else Ast.false_
        | _ -> Id_symantics.str_equal l r) *)

    let str_prefixof s1 s2 = Ast.str (Ast.Str.prefixof s1 s2)
    let str_contains s1 s2 = Ast.str (Ast.Str.contains s1 s2)
    let str_suffixof s1 s2 = Ast.str (Ast.Str.suffixof s1 s2)

    let fold_and_sort init op xs =
      let c, xs =
        List.fold_left
          (fun (cacc, phacc) -> function
             | Eia.Atom (Const c) -> op c cacc, phacc
             | Eia.Pow ((Atom (Const base) as b), Eia.Add (Atom (Const minus1) :: sums))
               when Z.(cacc mod base = Z.zero) && -1 = Z.to_int minus1 ->
               Z.(cacc / base), Eia.Pow (b, Eia.Add sums) :: phacc
             | ph -> cacc, ph :: phacc)
          (init, [])
          xs
      in
      c, List.sort compare_term xs
    ;;

    let collect_inside_mul xs =
      List.fold_right
        (fun x acc : term list ->
           match x, acc with
           | Eia.Mul ys, _ -> ys @ acc
           | e, Eia.Add ss :: tl | Add ss, e :: tl ->
             Add (List.map (fun x -> Eia.Mul [ x; e ]) ss) :: tl
           | Pow (base1, e1), Eia.Pow (base2, e2) :: tl when Stdlib.(base1 = base2) ->
             Eia.Pow (base1, Eia.Add [ e1; e2 ]) :: tl
           | ( Atom (Const c)
             , Eia.Pow ((Atom (Const basec) as base), Add (Atom (Const d) :: ss)) :: tl )
             when Z.(equal (abs c) basec) && d = Z.minus_one ->
             Eia.Atom (Const Z.(c / basec)) :: Eia.Pow (base, Add ss) :: tl
           | x, _ -> x :: acc)
        xs
        []
    ;;

    let rec mul xs =
      let fold_and_sort init op xs =
        let c, xs =
          List.fold_left
            (fun (cacc, phacc) -> function
               | Eia.Atom (Const c) -> op c cacc, phacc
               | Eia.Pow ((Atom (Const base) as b), Eia.Add (Atom (Const minus1) :: sums))
                 when Z.(cacc mod base = Z.zero) && Z.equal Z.minus_one minus1 ->
                 Z.(cacc / base), Eia.Pow (b, Eia.Add sums) :: phacc
               | ph -> cacc, ph :: phacc)
            (init, [])
            xs
        in
        c, List.sort compare_term xs
      in
      match fold_and_sort Z.one Z.( * ) (collect_inside_mul xs) with
      | c, _ when Z.(equal c zero) -> Eia.atom (Const Z.zero)
      | c, [] -> Eia.atom (Const c)
      | c, [ h ] when Z.equal c Z.one -> h
      | c, xs when Z.equal c Z.one -> Ast.Eia.mul (List.sort compare_term xs)
      | c, [ Pow ((Atom (Const base_) as base), Add [ Atom (Const v1); v ]) ]
        when Z.(equal c (Config.base ())) && base_ = Config.base () && v1 = Z.minus_one ->
        pow base v
      | c, [ Add ss ] -> Eia.Add (List.map (fun x -> Eia.Mul [ constz c; x ]) ss)
      | c, xs -> Ast.Eia.mul (constz c :: List.sort compare_term xs)

    and pow base xs =
      match base, xs with
      | _, Eia.Atom (Const c) when c = Z.zero -> const 1
      | Eia.Pow (base, e1), e2 -> Eia.Pow (base, Eia.Mul [ e1; e2 ])
      | Mul ((Atom (Const c) as base0) :: tl), Eia.Atom (Const e) ->
        mul [ pow base0 xs; pow (Mul tl) xs ]
      | Eia.Atom (Const b), Eia.Atom (Const exp) when Z.(exp > zero) ->
        (try const (Z.to_int (Utils.powz ~base:b exp)) with
         | Z.Overflow -> Ast.Eia.Pow (base, xs))
      | _ -> Ast.Eia.Pow (base, xs)
    ;;

    let rec add xs =
      let collect_inside_add xs =
        let extend h tl =
          let rec loop c1 tl1 = function
            | ph :: ptl when ph = Eia.Mul tl1 ->
              if Z.(equal c1 minus_one)
              then ptl
              else Eia.Mul (Eia.Atom (Const Z.(one + c1)) :: tl1) :: ptl
            | Eia.Mul (Eia.Atom (Const c2) :: tl2) :: ptl when Stdlib.(tl1 = tl2) ->
              if Z.(c1 + c2 = zero)
              then ptl
              else Eia.Mul (Eia.Atom (Const Z.(c1 + c2)) :: tl1) :: ptl
            | ph :: ptl -> ph :: loop c1 tl1 ptl
            | [] -> [ h ]
          in
          match h with
          | Eia.Mul (Eia.Atom (Const c1) :: tl1) -> loop c1 tl1 tl
          | Eia.Mul tl1 -> loop Z.one tl1 tl
          | _ -> h :: tl
        in
        List.fold_right
          (fun x acc ->
             match x, acc with
             | Eia.Add ts, _ -> ts @ acc
             | Mul (Atom (Const c1) :: ph1), Eia.Mul (Atom (Const c2) :: ph2) :: tl
               when List.equal Ast.Eia.eq_term ph1 ph2 ->
               if Z.(c1 + c2 = zero)
               then tl
               else mul (Atom (Const Z.(c1 + c2)) :: ph1) :: tl
             | Mul [ Atom (Const c1); ph1 ], ph2 :: tl when Ast.Eia.eq_term ph1 ph2 ->
               extend (mul [ Atom (Const Z.(of_int 1 + c1)); ph1 ]) tl
             | a, _ -> extend a acc)
          xs
          []
      in
      let fold_and_sort init op xs =
        (* TODO(Kakadu): Maybe this presorting is not really needed... *)
        let c, xs =
          List.fold_left
            (fun (cacc, phacc) -> function
               | Eia.Atom (Const c) -> op c cacc, phacc
               | ph -> cacc, ph :: phacc)
            (init, [])
            xs
        in
        c, List.sort compare_term xs
      in
      match fold_and_sort Z.zero Z.( + ) (collect_inside_add xs) with
      | c, [ Eia.Atom (Var x); Mul [ Eia.Atom (Const x1); Eia.Atom (Var x2) ] ]
        when Z.(c = zero) && x = x2 && x1 = Z.minus_one -> const 0
      | c, Mul [ Eia.Atom (Const c1); t1 ] :: Mul [ Eia.Atom (Const c2); t2 ] :: tl
        when Stdlib.(t1 = t2) ->
        if c1 = Z.(minus_one * c2)
        then add (constz c :: tl)
        else add (constz c :: Mul [ Eia.Atom (Const Z.(c1 + c2)); t1 ] :: tl)
      | c, [ h ] when Z.(equal c zero) -> h
      | c, [] when Z.(equal c zero) -> const 0
      | c, xs when Z.(equal c zero) ->
        let ans = Ast.Eia.add (List.sort compare_term xs) in
        ans
      | c, [] -> constz c
      | c, xs -> Ast.Eia.add (constz c :: List.sort compare_term xs)
    ;;

    let rec negate = function
      | Eia.Add xs -> add (List.map negate xs)
      | x -> mul [ const (-1); x ]
    ;;

    (** Formulas *)
    let exists var ph = Ast.Exists (List.map Ast.var var, ph)

    let true_ = Ast.true_
    let false_ = Ast.false_

    let rec not = function
      | Ast.Lnot x -> x
      | Land xs -> Ast.Lor (List.map not xs)
      | Lor xs -> Ast.Land (List.map not xs)
      | x -> Ast.lnot x
    ;;

    let land_ xs =
      let flat =
        List.concat_map
          (function
            | Ast.Land xs -> xs
            | x -> [ x ])
          xs
      in
      let flat = Base.List.dedup_and_sort ~compare:compare_ast flat in
      match flat with
      | [] -> false_
      | Lnot True :: _ -> false_
      | [ h ] -> h
      | _ ->
        (match List.drop_while (( = ) Ast.True) flat with
         | [] -> true_
         | xs -> Ast.Land xs)
    ;;

    let lor_ x = Ast.Lor x

    let relop op l r =
      let ofop =
        match op with
        | Leq -> fun x y -> Eia (Eia.leq x y)
        | Eq -> fun x y -> Eia (Eia.eq x y)
      in
      match l, r with
      | Eia.Atom (Const l), Eia.Atom (Const r) ->
        (match op with
         | Eq when Z.equal l r -> true_
         | Eq -> false_
         | Leq when l <= r -> true_
         | Leq -> false_)
      | Eia.(Add (Atom (Var v1) :: Mul [ Atom (Const c); Atom (Var v2) ] :: tl)), rhs
        when String.equal v1 v2 && c = Z.minus_one -> ofop (Eia.Add tl) rhs
      | Eia.Add ls, Eia.Add rs -> ofop (add (ls @ List.map negate rs)) (const 0)
      | Eia.Add (Atom (Const c) :: tl), Atom (Const n) ->
        ofop (add tl) (const Z.(to_int (n - c)))
      | Atom (Const c), Add (Atom (Const n) :: tl) ->
        ofop (add (List.map negate tl)) (const Z.(to_int (n - c)))
      | Atom (Const c), Add xs -> ofop (add (List.map negate xs)) (const Z.(to_int (-c)))
      | Pow (basel, powl), Pow (baser, powr) when basel = baser -> ofop powl powr
      | Eia.Mul [ Atom (Const c); Atom (Var v) ], Eia.Atom (Const rhs)
        when op = Leq && Z.(abs c <> one) ->
        (* optimizing single bounds *)
        if Z.(equal zero rhs)
        then ofop Eia.(Mul [ Atom (Const (Z.of_int (Z.sign c))); Atom (Var v) ]) r
        else if Z.(c < zero) && Z.(rhs < zero)
        then
          ofop
            Eia.(Mul [ Atom (Const Z.minus_one); Atom (Var v) ])
            (mul [ Atom (Const Z.minus_one); Atom (Const Z.((abs rhs + one) / abs c)) ])
        else if Z.(c > zero) && Z.(rhs > zero)
        then ofop Eia.(Atom (Var v)) (Atom (Const Z.(abs rhs / c)))
        else
          (* TODO(Kakadu): Support other three cases *)
          ofop l r
      | Eia.Pow (Eia.Atom (Const base), Eia.Add (Atom (Const n) :: etail)), _
        when Z.(n < zero) && Z.fits_int n ->
        ofop
          (Eia.Pow (Eia.Atom (Const base), Eia.Add etail))
          (mul [ pow (constz base) (constz (Z.abs n)); r ])
      | _ -> ofop l r
    ;;

    let lt l r = relop Leq (add [ const 1; l ]) r
    let leq = relop Leq

    let eq x y =
      (* TODO(Kakadu): rewrite to match twice for readability *)
      let ans = relop Eq x y in
      match ans with
      | Eia (Eia.Eq (Mul (Atom (Const l) :: ltl), Mul (Atom (Const r) :: rtl))) ->
        let gcd1 = Z.gcd l r in
        if Z.(equal gcd1 one)
        then ans
        else
          Eia
            (Eia.eq (mul (constz Z.(l / gcd1) :: ltl)) (mul (constz Z.(r / gcd1) :: rtl)))
      | Eia (Eia.Eq (l, r)) when Eia.eq_term l r -> true_
      | Eia (Eia.Eq (Eia.Sofi (Atom (Var _) as l), Eia.Sofi (Atom (Var _) as r))) ->
        Eia (Eia.Eq (l, r))
      | Eia (Eia.Eq (Eia.Sofi (Atom (Const v1)), Atom (Str_const r)))
      | Eia (Eia.Eq (Atom (Str_const r), Eia.Sofi (Atom (Const v1)))) ->
        let l = Z.to_string v1 in
        if
          String.length l <= String.length r
          && String.ends_with ~suffix:l r
          && String.for_all
               (Char.equal '0')
               (String.sub r (String.length l) (String.length r - String.length l))
        then Ast.true_
        else Ast.false_
      | _ -> ans
    ;;

    let from_eia_nfa c =
      let module NfaStr = Nfa.Lsb (Nfa.Str) in
      let re =
        List.fold_left
          Regex.concat
          Regex.epsilon
          (Z.to_string c
           |> String.to_seq
           |> Seq.map (fun c -> [ c ])
           |> Seq.map Regex.symbol
           |> List.of_seq
           |> List.rev)
      in
      let re = Regex.concat re (Regex.kleene (Regex.Symbol [ Nfa.Str.u_zero ])) in
      NfaStr.of_regex re
    ;;

    let in_re s re =
      let module NfaStr = Nfa.Lsb (Nfa.Str) in
      match s with
      | Ast.Eia.Atom (Ast.Var s) -> begin
        match Env.lookup s env with
        | Some (Ast.Eia.Atom (Ast.Str_const _) as c) -> Ast.str (Str.inre c re)
        | Some (Ast.Eia.Atom (Ast.Const c)) -> begin
          match
            NfaStr.of_regex re
            |> NfaStr.intersect (from_eia_nfa c)
            |> NfaStr.run (*(String.to_seq str |> List.of_seq |> List.rev)*)
          with
          | true -> Ast.true_
          | false -> Ast.false_
        end
        | Some (Ast.Eia.Atom c) -> Ast.str (Str.inre (Eia.Sofi (Atom c)) re)
        | None | _ -> Ast.str (Str.inre (Eia.Atom (Ast.var s)) re)
      end
      | Ast.Eia.Atom (Const c) | Ast.Eia.Sofi (Atom (Const c)) ->
        (* v = sofi 4 <=> v="4" | v="04" | v="004" | ... *)
        begin
          match
            NfaStr.of_regex re
            |> NfaStr.intersect (from_eia_nfa c)
            |> NfaStr.run (*(String.to_seq str |> List.of_seq |> List.rev)*)
          with
          | true -> Ast.true_
          | false -> Ast.false_
        end
      | Ast.Eia.Atom (Str_const str) -> begin
        match
          NfaStr.of_regex re
          |> NfaStr.re_accepts (String.to_seq str |> List.of_seq |> List.rev)
        with
        | true -> Ast.true_
        | false -> Ast.false_
      end
      | _ -> Ast.str (Str.inre s re)
    ;;

    let prj : ph -> repr = Fun.id
  end
  in
  let module Main_symantics = struct
    include Main_symantics_
    include FT_SIG.Sugar (Main_symantics_)
  end
  in
  (module Main_symantics : SYM_SUGAR
    with type ph = Ast.t
     and type repr = Ast.t
     and type term = Ast.Eia.term)
;;

(* let apply_term_symantics
  : (module SYM with type term = Ast.Eia.term) -> Ast.Eia.term -> Ast.Eia.term
  =
  fun (module S : SYM with type term = Ast.Eia.term) ->
  let rec helperT = function
    | Ast.Eia.Atom (Ast.Const n) as c -> c
    | Atom (Ast.Var s) -> S.var s
    | Atom (Ast.Str_const c) -> S.str_const c
    | Add terms -> S.add (List.map helperT terms)
    | Mul terms -> S.mul (List.map helperT terms)
    | Pow (base, p) -> S.pow (helperT base) (helperT p)
    | Bwand (l, r) -> S.bw Bwand (helperT l) (helperT r)
    | Bwor (l, r) -> S.bw Bwor (helperT l) (helperT r)
    | Bwxor (l, r) -> S.bw Bwxor (helperT l) (helperT r)
    | Mod (t, z) -> S.mod_ (helperT t) z
    | Len (Ast.Eia.Atom (Str_const s)) -> S.const (String.length s)
    | Len s -> S.str_len (helperT s)
    | Iofs (Ast.Eia.Atom (Str_const s)) ->
      (match int_of_string_opt s with
       | Some n -> S.const n
       | None -> S.iofs (S.str_const s))
    | Iofs s -> S.iofs (helperT s)
    | Sofi s -> S.sofi (helperT s)
    | Len2 (Var s) -> S.str_len2 s
    | Len2 (Const _) -> failwith "TBD"
    | Len2 (Str_const _) -> failwith "TBD"
    (* | Ast.Eia.Atom (Var s) -> S.str_var s *)
    (* | Atom (Const s) as ast ->
      Format.eprintf "%a\n%!" Ast.Str.pp_term ast;
      failwith "tbd"
    | Atom (Str_const c) -> S.str_const c *)
    | Ast.Eia.Concat (lhs, rhs) -> S.str_concat (helperT lhs) (helperT rhs)
    (* | Ast.Eia.FromEia (Var s) -> S.str_from_eia s *)
    (* | Ast.Eia.FromEia (Const c) -> S.str_from_eia_const c *)
    | Substr (lhs, Var s1, Var s2) -> S.str_substr (helperT lhs) s1 s2
    | Substr (lhs, _, _) as ast ->
      Format.eprintf "%a\n%!" Ast.Eia.pp_term ast;
      failwith "tbd"
    | At (lhs, Var s1) -> S.str_at (helperT lhs) s1
    | At (lhs, _) as ast ->
      Format.eprintf "%a\n%!" Ast.Eia.pp_term ast;
      failwith "tbd"
  in
  helperT
;; *)

let subst_term env ast =
  let (module S : SYM_SUGAR_AST) = make_main_symantics env in
  apply_term_symantics (module S) ast
;;

exception Unsat
exception Sat of string * Env.t

module Info = struct
  type names = string Base.Set.Poly.t

  type t =
    { exp : names
    ; all : names
    ; str : names
    }

  let is_in_expo name { exp; _ } = Base.Set.Poly.mem exp name
  let is_in_string name { str; _ } = Base.Set.Poly.mem str name

  let make ~exp ~all ~str =
    (* TODO: check subsumtion *)
    let of_list = Base.Set.Poly.of_list in
    { exp = of_list exp; all = of_list all; str = of_list str }
  ;;

  let empty = make ~exp:[] ~all:[] ~str:[]

  let pp_exp ppf { exp; _ } =
    Format.fprintf
      ppf
      "exp: @[%a@]"
      Format.(
        pp_print_list Format.pp_print_string ~pp_sep:(fun ppf () -> fprintf ppf "@ "))
      (Base.Set.Poly.to_list exp)
  ;;

  let pp_hum ppf { exp; all; str } =
    let open Format in
    let pp_list =
      pp_print_list Format.pp_print_string ~pp_sep:(fun ppf () -> fprintf ppf "@ ")
    in
    fprintf ppf "@[<v>";
    fprintf ppf "@[Exp: @[%a@]@]@," pp_list (Base.Set.Poly.to_list exp);
    fprintf ppf "@[Str: @[%a@]@]@," pp_list (Base.Set.Poly.to_list str);
    fprintf ppf "@[ALL: @[%a@]@]" pp_list (Base.Set.Poly.to_list all);
    fprintf ppf "@]"
  ;;

  let union e1 e2 =
    let ( ++ ) = Base.Set.Poly.union in
    { exp = e1.exp ++ e2.exp; all = e1.all ++ e2.all; str = e1.str ++ e2.str }
  ;;
end

module Who_in_exponents_ = struct
  module S = Base.Set.Poly

  type term = Info.t

  let pp_str = Info.pp_hum

  open Info

  let pp_set ppf xs =
    Format.(fprintf ppf "@[%a@]" (pp_print_list pp_print_string ~pp_sep:pp_print_space))
      xs
  ;;

  let pp_info ppf { Info.exp; all; _ } =
    Format.printf
      "@[{ all = @[%a@];@ exp  = @[%a@] }@]"
      pp_set
      (Base.Set.Poly.to_list all)
      pp_set
      (Base.Set.Poly.to_list exp)
  [@@warning "-32"]
  ;;

  let ( ++ ) = Info.union
  let empty = Info.empty

  type ph = term
  type repr = ph

  let in_re _ _ = empty
  let str_len s = s
  let sofi s = s
  let iofs s = s
  let str_const _ = empty

  let str_var v =
    (* Format.printf "%s %d: %s\n%!" __FUNCTION__ __LINE__ v; *)
    { empty with str = S.singleton v }
  ;;

  let str_from_eia s =
    (* Format.printf "%s %d\n%!" __FILE__ __LINE__; *)
    empty
  ;;

  let str_from_eia_const s = empty
  let str_concat = ( ++ )

  let str_equal l r =
    let ans = l ++ r in
    (* Format.printf "%s %d: %a\n%!" __FILE__ __LINE__ Info.pp_hum ans; *)
    ans
  ;;

  let const _ = empty
  let constz _ = empty
  let var s = { empty with all = S.singleton s }

  let str_len2 v =
    (* Format.printf "%s %d: %s\n%!" __FUNCTION__ __LINE__ v; *)
    { empty with str = S.singleton v }
  ;;

  let str_at _ _ = empty
  let str_substr _ _ _ = empty
  let str_prefixof = ( ++ )
  let str_contains = ( ++ )
  let str_suffixof = ( ++ )

  let mul xs =
    let aaa = List.fold_left ( ++ ) empty xs in
    (* let u2 =
      match xs with
      | [ Eia.Atom (Var v); Eia.Pow (Eia.Atom (Const 2), Eia.Atom (Var _)) ] ->
        S.singleton v
      | _ -> S.empty
    in
    { aaa with under2 = S.union aaa.under2 u2 } *)
    aaa
  ;;

  let add = List.fold_left ( ++ ) empty
  let mod_ x _ = x
  let bw _ = ( ++ )
  let true_ = empty
  let false_ = empty
  let land_ = List.fold_left ( ++ ) empty
  let lor_ = List.fold_left ( ++ ) empty
  let not = Fun.id
  let eq = ( ++ )
  let leq = ( ++ )
  let lt = ( ++ )

  let exists _ info =
    (* This place could be buggy when name clashes  *)
    info
  ;;

  let pow2var v =
    let all = [ v ] in
    Info.make ~all ~exp:all ~str:[]
  ;;

  let pow base e = { e with all = S.union base.all e.all }
  let prj = Fun.id
end

module _ : SYM = Who_in_exponents_

module Who_in_exponents :
  SYM_SUGAR with type repr = Who_in_exponents_.repr and type ph = Who_in_exponents_.repr =
struct
  include Who_in_exponents_
  include FT_SIG.Sugar (Who_in_exponents_)
end

let propagate_exponents ast =
  let open Ast in
  let rec collect acc = function
    | Ast.Eia (Eia.Leq _) | Eia (Eia.Eq (Eia.Pow _, Eia.Pow _)) -> acc
    | Eia (Eia.Eq ((Eia.Pow _ as l), r)) -> collect acc (Eia (Eia.Eq (r, l)))
    | Eia (Eia.Eq (l, (Eia.Pow _ as r))) -> Term_map.add (`Eia r) l acc
    | _ -> acc
  in
  let info =
    match ast with
    | Ast.Land xs -> List.fold_left collect Term_map.empty xs
    | _ -> collect Term_map.empty ast
  in
  let check key ~rhs =
    match Term_map.find (`Eia key) info with
    | exception Not_found -> key
    | t when Eia.eq_term rhs t -> key
    | t ->
      log "%s: %a -> %a" __FUNCTION__ Ast.pp_term_smtlib2 key Ast.pp_term_smtlib2 t;
      t
  in
  let on_eia = function
    | Eia (Eia.Eq (l, r)) -> Eia (Eia.eq (check l ~rhs:r) (check r ~rhs:l))
    | Eia (Eia.Leq (l, r)) -> Eia (Eia.leq (check l ~rhs:r) (check r ~rhs:l))
    | x -> x
  in
  match ast with
  | Ast.Land xs -> Ast.land_ (List.map on_eia xs)
  | _ -> ast
;;

let find_vars_for_under2 ast =
  let module S = Base.Set.Poly in
  Ast.fold
    (fun acc ->
       let open Ast.Eia in
       function
       | Ast.Eia (Ast.Eia.Eq (l, r)) | Eia (Ast.Eia.Leq (l, r)) ->
         let f =
           fun acc -> function
             | Ast.Eia.Mul [ Atom (Var v); Pow (Atom (Const base), Atom (Var _)) ]
               when Z.(equal (Config.base ()) base) -> S.add acc v
             | Mul [ Atom (Const _); Atom (Var v); Pow (Atom (Const base), Atom (Var _)) ]
               when Z.(equal (Config.base ()) base) -> S.add acc v
             | Mul [ Atom (Var v); Pow (Atom (Const base), Atom (Var _)) ]
               when Z.(equal (Config.base ()) base) -> S.add acc v
             | Mul [ Atom (Var v1); Atom (Var v2) ] -> S.add (S.add acc v1) v2
             | _ -> acc
         in
         Ast.Eia.fold_term f (Ast.Eia.fold_term f acc r) l
       | _ -> acc)
    S.empty
    ast
;;

let gensym =
  let n = ref 0 in
  fun ?(prefix = "eee") () ->
    incr n;
    Printf.sprintf "%s%d" prefix !n
;;

let flatten { Info.all; _ } =
  let gensym1 = gensym in
  let rec gensym () =
    let ans = gensym1 ~prefix:"eee" () in
    if Base.Set.Poly.mem all ans then gensym () else ans
  in
  let extra_ph = ref [] in
  let mapping = ref Term_map.empty in
  let extend v other =
    extra_ph := Id_symantics.eq (Id_symantics.var v) other :: !extra_ph;
    mapping := Term_map.add (`Eia other) v !mapping
  in
  let module M_ = struct
    include Id_symantics

    let pow base e =
      match e with
      | Ast.Eia.Atom (Ast.Var _) | Ast.Eia.Atom (Ast.Const _) -> Id_symantics.pow base e
      | _ ->
        (match Term_map.find (`Eia e) !mapping with
         | exception Not_found ->
           let newv = gensym () in
           extend newv e;
           Id_symantics.pow base (Id_symantics.var newv)
         | newv -> Id_symantics.pow base (Id_symantics.var newv))
    ;;

    let prj = function
      | Ast.Land xs -> land_ (!extra_ph @ xs)
      | ph -> land_ (!extra_ph @ [ ph ])
    ;;
  end
  in
  let module Sym = struct
    include M_
    include FT_SIG.Sugar (M_)
  end
  in
  fun ph -> Sym.prj (apply_symantics (module Sym) ph)
;;

let make_smtml_symantics (env : (string, _) Base.Map.Poly.t) =
  let module M = struct
    include FT_SIG.To_smtml_symantics

    type repr = term

    let prj = Fun.id

    let var s =
      match Base.Map.Poly.find env s with
      | None -> Smtml.Expr.symbol (Smtml.Symbol.make Smtml.Ty.Ty_int s)
      | Some c -> const c
    ;;

    let str_from_eia _ = failwith "not implemented"
    let str_from_eia_const _ = failwith "not implemented"
    let str_concat _ = failwith "not implemented"
    let str_equal _ = failwith "not implemented"
    let str_at _ = failwith "not implemented"
    let str_substr _ = failwith "not implemented"
    let str_prefixof _ = failwith "not implemented"
    let str_contains _ = failwith "not implemented"
    let str_suffixof _ = failwith "not implemented"
    let pow2var s = pow (const Z.(Config.base () |> to_int)) (var s)

    let exists vars x =
      let vars = List.filter (fun s -> Stdlib.not (Base.Map.Poly.mem env s)) vars in
      match vars with
      | [] -> x
      | _ -> Smtml.Expr.exists (List.map var vars) x
    ;;

    let str_len2 _ = failwith "not implemented"
    let pp_str = Smtml.Expr.pp
  end
  in
  (module struct
    include M
    include FT_SIG.Sugar (M)
  end : SYM_SUGAR
    with type ph = Smtml.Expr.t)
;;

(* TODO: run this inside eq_propagation *)
let trivial_simplify : Ast.Eia.term -> Ast.Eia.term =
  let (module S) = make_main_symantics Env.empty in
  let rec loop ast =
    let rez : _ = apply_term_symantics (module S) ast in
    if rez = ast then ast else loop rez
  in
  loop
;;

let eq_propagation : Info.t -> Env.t -> Ast.t -> Env.t * Ast.t =
  let open Ast in
  let (module S : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  let extend_exn env v rhs = Env.extend_exn env v (trivial_simplify rhs) in
  let fold_and_filter f acc xs =
    let acc = ref acc in
    let xs =
      List.filter_map
        (fun h ->
           match f !acc h with
           | Some acc2 ->
             acc := acc2;
             None
           | None -> Some h)
        xs
    in
    !acc, xs
  in
  let single info env c1 v1 c2 v2 rhs =
    let c1 = Z.to_int c1 in
    let c2 = Z.to_int c2 in
    let is_bad v = Info.is_in_expo v info || Info.is_in_string v info in
    try
      match c1, is_bad v1, c2, is_bad v2 with
      | 1, false, _, _ when Env.is_absent_key v1 env && Env.is_absent_key v2 env ->
        (* Format.printf "%s %d v1=%s, v2=%s\n%!" __FILE__ __LINE__ v1 v2; *)
        extend_exn env v1 S.(add [ mul [ const (-1); const c2; var v2 ]; rhs ])
      | _, _, 1, false when Env.is_absent_key v2 env && Env.is_absent_key v2 env ->
        (* Format.printf "%s %d\n%!" __FILE__ __LINE__; *)
        extend_exn env v2 S.(add [ mul [ const (-1); const c1; var v1 ]; rhs ])
      | _ -> env
      (* TODO(Kakadu): Support proper occurs check to workaround recursive substitutions *)
      (* Note: presence of key means we already simplified this variable in another equality *)
    with
    | Env.Occurs -> env
  in
  let helper info env ast =
    match ast with
    (* **************************** String stuff *********************************** *)
    | Eia (Eia.Eq (Atom (Var v), (Atom (Str_const str) as rhs)))
      when Env.is_absent_key v env ->
      (* (= v 'str') *)
      Some (extend_exn env v rhs)
    | Eia (Eia.Eq ((Atom (Str_const str) as rhs), Atom (Var v)))
      when Env.is_absent_key v env ->
      (* (= 'str' v) *)
      Some (extend_exn env v rhs)
    | Eia (Eia.Eq (Atom (Var v), (Eia.Sofi (Atom (Var _)) as rhs)))
      when Env.is_absent_key v env -> Some (extend_exn env v rhs)
    | Eia (Eia.Eq (Atom (Var v), (Eia.Iofs (Atom (Var _)) as rhs)))
      when Env.is_absent_key v env -> Some (extend_exn env v rhs)
    | Eia (Eia.Eq (Atom (Var v), (Eia.Len (Atom (Var _)) as rhs)))
      when Env.is_absent_key v env -> Some (extend_exn env v rhs)
    | Eia (Eia.Eq (Atom (Var v), (Eia.Len2 (Var _) as rhs))) when Env.is_absent_key v env
      -> Some (extend_exn env v rhs)
    (* **************************** integer stuff *********************************** *)
    | Eia (Eia.Eq (Atom (Var v), (Atom (Var v2) as rhs))) ->
      if not (Env.is_absent_key v env)
      then None
      else if Env.occurs_var env v rhs
      then None
      else Some (extend_exn env v rhs)
    | Eia (Eia.Eq (Atom (Var v), (Atom (Const c) as rhs))) when Env.is_absent_key v env ->
      (* (= v c) *)
      Some (extend_exn env v rhs)
    | Eia (Eia.Eq (Mul [ Atom (Const _); Atom (Var v) ], (Atom (Const z) as rhs)))
      when Z.(equal z zero) && Env.is_absent_key v env ->
      (* (= ( * c v) 0) *)
      Some (extend_exn env v rhs)
    | Eia (Eia.Eq (Mul [ Atom (Const cl); Atom (Var v) ], Atom (Const cr)))
      when Z.(cr mod cl = zero) && Env.is_absent_key v env ->
      let rhs = Eia.Atom (Const Z.(cr / cl)) in
      Some (extend_exn env v rhs)
    | Eia (Eia.Eq ((Mul [ Atom (Const cl); Atom (Var v) ] as lhs), Atom (Var r)))
      when Env.is_absent_key r env ->
      (* (= ( * c v) vr) *)
      Some (extend_exn env r lhs)
    | Eia
        (Eia.Eq
           ( Add [ Atom (Var v1); Mul [ Atom (Const c); (Atom (Var v2) as vv2) ] ]
           , Atom (Const z0) ))
      when Z.(equal z0 zero) && Env.is_absent_key v1 env ->
      (* (= (+ v1 v2) rhs) *)
      if Env.occurs_var env v1 vv2
      then None
      else (
        let new_rhs =
          if Z.(equal c minus_one)
          then Eia.Atom (Var v2)
          else Eia.Mul [ Atom (Const Z.(-c)); Atom (Var v2) ]
        in
        Some (extend_exn env v1 new_rhs))
    | Eia (Eia.Eq (Add [ Atom (Var v1); Atom (Var v2) ], rhs)) when v1 <> v2 ->
      (* (= (+ v1 v2) rhs) *)
      Some (single info env Z.one v1 Z.one v2 rhs)
    | Eia (Eia.Eq (Add [ Atom (Var v1); Mul [ Atom (Const c2); Atom (Var v2) ] ], rhs))
      when v1 <> v2 ->
      (* (= (+ v1 ( * c v2)) rhs) *)
      Some (single info env Z.one v1 c2 v2 rhs)
    | Eia (Eia.Eq (Add [ Mul [ Atom (Const c1); Atom (Var v1) ]; Atom (Var v2) ], rhs))
      when v1 <> v2 ->
      (* (= (+ ( * c v1) v2) rhs) *)
      Some (single info env c1 v1 Z.one v2 rhs)
    | Eia
        (Eia.Eq
           ( Add
               [ Mul [ Atom (Const c1); Atom (Var v1) ]
               ; Mul [ Atom (Const c2); Atom (Var v2) ]
               ]
           , rhs ))
      when v1 <> v2 -> Some (single info env c1 v1 c2 v2 rhs)
    | Eia (Eia.Eq (Add sums, Atom (Const rhs))) when Z.(zero = rhs) ->
      (* (= (+ ...) 0) *)
      let not_touched_by_env env term =
        try
          let f env = function
            | Eia.Atom (Var v) when not (Env.is_absent_key v env) -> raise Exit
            | _ -> env
          in
          let _ : Env.t = Eia.fold_term f env term in
          true
        with
        | Exit -> false
      in
      let maybe_extend env v data ~fk =
        if not (Env.occurs_var env v data) then extend_exn env v data else fk ()
      in
      let is_bad v = Info.is_in_expo v info || Info.is_in_string v info in
      let rec loop acc = function
        | Eia.Atom (Var v) :: _ when not (Env.is_absent_key v env) -> raise Exit
        | Eia.Atom (Var v) :: xs when Env.is_absent_key v env && not (is_bad v) ->
          let data = S.(mul [ const (-1); add (acc @ xs) ]) in
          if not (Env.occurs_var env v data)
          then extend_exn env v data
          else loop (Eia.Atom (Var v) :: acc) xs
        | (Mul [ Atom (Const c); Eia.Atom (Var v) ] as leftmost) :: xs
          when Env.is_absent_key v env
               && (not (is_bad v))
               && Z.(equal (of_int (-1)) c)
               && not_touched_by_env env (Eia.Add acc)
               && not_touched_by_env env (Eia.Add xs) ->
          let data = S.(mul [ add (acc @ xs) ]) in
          maybe_extend env v data ~fk:(fun () -> loop (leftmost :: acc) xs)
        | h :: tl -> loop (h :: acc) tl
        | [] -> raise Exit
      in
      (try Some (loop [] sums) with
       | Exit -> None)
    | _ ->
      (* log "OTHERWISE  ast part = @[%a@]" Ast.pp_smtlib2 ast; *)
      None
  in
  fun info env ast ->
    match ast with
    | Land xs ->
      let env, xs = fold_and_filter (helper info) env xs in
      env, Land xs
    | Eia _ ->
      (match helper info env ast with
       | Some e -> e, Ast.True
       | None -> env, ast)
    | ph -> env, ph
;;

let%expect_test _ =
  let (module TS) = make_main_symantics Env.empty in
  let test ?(env = [ "x"; "y"; "z" ]) ?(exp = []) ph =
    let info = Info.make ~all:env ~exp ~str:[] in
    let env2, _ = eq_propagation info Env.empty ph in
    Format.printf "@[%a@]\n%!" (Env.pp ~title:"") env2
  in
  test TS.(add [ mul [ const 1; var "x" ]; mul [ const 2; var "y" ] ] = var "z");
  [%expect "x -> (+ z (* (- 2) y));"];
  test TS.(add [ var "x"; mul [ const 2; var "y" ] ] = mul [ var "z"; var "z" ]);
  [%expect "x -> (+ (* z z) (* (- 2) y));"];
  test ~exp:[ "x" ] TS.(add [ var "x"; var "y" ] = mul [ var "z"; var "z" ]);
  [%expect "y -> (+ (* z z) (- x));"];
  ()
;;

exception Underapprox_fired of Env.t
exception Error of Ast.t * error list [@@ocaml.warnerror "-38"]

(* type step = int list *)
let next_step = function
  | [] -> failwith "Bad argument: next_step"
  | h :: tl -> (1 + h) :: tl
;;

let pp_step fmt step =
  Format.pp_print_list
    ~pp_sep:(fun ppf () -> Format.fprintf ppf ".")
    Format.pp_print_int
    fmt
    (List.rev step)
;;

let lower_mod ast =
  let acc = ref [] in
  let extend ph = acc := ph :: !acc in
  let module M = struct
    include Id_symantics

    let mod_ t z =
      let r = var (gensym ~prefix:"r" ()) in
      let q = var (gensym ~prefix:"q" ()) in
      let zz = Ast.Eia.atom (Ast.Const z) in
      extend (leq (const 0) r);
      extend (lt r zz);
      extend (eq t (add [ mul [ zz; q ]; r ]));
      r
    ;;
  end
  in
  let ph = apply_symantics_unsugared (module M) ast in
  match !acc with
  | [] -> ph
  | acc -> Ast.land_ (ph :: acc)
;;

let lower_strlen ast =
  let env = ref Env.empty in
  let names : (Ast.Eia.term, string) Base.Map.Poly.t ref = ref Base.Map.Poly.empty in
  let forgotten = ref Env.empty in
  let module Collector = struct
    open Ast.Eia
    include Id_symantics

    let eq l r =
      let () =
        match l, r with
        | Atom (Var v), Len l | Len l, Atom (Var v) ->
          if Env.is_absent_key v !env
          then env := Env.extend_exn !env v (Len l)
          else forgotten := Env.extend_exn !forgotten v (Len l);
          names := Base.Map.Poly.set !names ~key:(Len l) ~data:v
        | _ -> ()
      in
      eq l r
    ;;
  end
  in
  let module Lowering = struct
    open Ast.Eia
    include Id_symantics

    let str_len = function
      | Atom (Var v) ->
        let lv = Ast.Eia.Atom (Var v) in
        (match Base.Map.Poly.find !names (Len lv) with
         | None ->
           let newvar = Ir.internal_name () in
           let lent = Id_symantics.str_len lv in
           env := Env.extend_exn !env newvar lent;
           names := Base.Map.Poly.set !names ~key:lent ~data:newvar;
           var newvar
         | Some t -> Id_symantics.var t)
      | _ -> failwith (Printf.sprintf "Not implemented: %s %d" __FILE__ __LINE__)
    ;;

    let sofi = function
      | Atom (Var v) ->
        let lv = Ast.Eia.Atom (Var v) in
        (match Base.Map.Poly.find !names (Sofi lv) with
         | None ->
           let newvar = Ir.internal_name () in
           let lent = Id_symantics.sofi lv in
           env := Env.extend_exn !env newvar lent;
           names := Base.Map.Poly.set !names ~key:lent ~data:newvar;
           var newvar
         | Some t -> Id_symantics.var t)
      | _ -> failwith (Printf.sprintf "Not implemented: %s %d" __FILE__ __LINE__)
    ;;
  end
  in
  let _ : Ast.t = apply_symantics_unsugared (module Collector) ast in
  match apply_symantics_unsugared (module Lowering) ast with
  | Ast.Land xs ->
    Ast.Land (Env.to_eqs !env @ Env.to_eqs !forgotten @ List.map Id_symantics.prj xs)
  | ph -> Ast.Land ((ph :: Env.to_eqs !env) @ Env.to_eqs !forgotten)
;;

let basic_simplify step (env : Env.t) ast =
  let rec loop step (env : Env.t) ast =
    log "iter(%a)= @[%a@]" pp_step step Ast.pp_smtlib2 ast;
    let (module Symantics) = make_main_symantics env in
    let rez = apply_symantics (module Symantics) ast in
    let ast2 = Symantics.prj rez in
    (* log "Ast after main_symantics: @[%a@]" Ast.pp_smtlib2 ast2; *)
    let ast2 = propagate_exponents ast2 in
    let __ _ = log "Ast after propagate_exponents: @[%a@]" Ast.pp_smtlib2 ast2 in
    let var_info = apply_symantics (module Who_in_exponents) ast in
    (* Format.printf "%s: info = @[%a@]\n%!" __FUNCTION__ Info.pp_hum var_info; *)
    let env2, ast2 = eq_propagation var_info env ast2 in
    let __ _ = log "env2 = %a" (Env.pp ~title:"") env2 in
    match Env.length env2 > Env.length env, Stdlib.(ast2 = ast) with
    | true, other ->
      let () = log "%a" (Env.pp ~title:"Something ready to substitute") env2 in
      loop (next_step step) (Env.merge env2 env) ast2
    | false, false -> loop (next_step step) env ast2
    | false, true ->
      (match ast2 with
       | Ast.True -> raise (Sat ("presimpl", env))
       | Ast.Lnot Ast.True -> raise Unsat
       | _ -> ast2, env, var_info, step)
  in
  try `Unknown (loop step env ast) with
  | Unsat -> `Unsat
  | Sat (_, env) -> `Sat env
;;

let run_basic_simplify ast =
  let ast = lower_strlen ast in
  let ast = lower_mod ast in
  (* let ast = SimplI.run_simplify ast in *)
  let _ = log "After strlen lowering:@,@[%a@]\n" Ast.pp_smtlib2 ast in
  match basic_simplify [ 1 ] Env.empty ast with
  | `Sat env -> `Sat ("presimpl", env)
  | `Unsat -> `Unsat
  | `Unknown (ast, e, _, _) -> `Unknown (ast, e)
;;

let get_range () =
  let ans =
    List.init
      (1 + Config.under2_config.amax - Config.under2_config.amin)
      (( + ) Config.under2_config.amin)
  in
  assert (
    List.for_all
      (fun x -> x >= Config.under2_config.amin && x <= Config.under2_config.amax)
      ans);
  ans
;;

let subst env ast =
  let (module S : SYM_SUGAR_AST) = make_main_symantics env in
  apply_symantics_unsugared (module S) ast
;;

let try_under2_heuristics env ast =
  let under2vars = find_vars_for_under2 ast in
  log
    "vars_for_under2: %a\n%!"
    Format.(pp_print_list pp_print_string)
    (Base.Set.to_list under2vars);
  log "@[%a@]" (Env.pp ~title:"env = ") env;
  log "ast = @[%a@]" Ast.pp_smtlib2 ast;
  let ( let* ) xs f = List.concat_map f xs in
  let _k = 0 in
  let envs =
    match Config.under2_config.flat with
    | n when n < 0 -> failwith "bad config"
    | 0 ->
      let all_as = get_range () in
      log
        "all as: @[%a@]\n%!"
        Format.(pp_print_list ~pp_sep:(fun ppf () -> fprintf ppf " ") pp_print_int)
        all_as;
      Base.Set.Poly.fold
        ~f:(fun acc name ->
          let* a = all_as in
          let* acc, phs = acc in
          let u = gensym ~prefix:"u" () in
          [ Env.extend_exn acc name Id_symantics.(add [ pow2var u; const a ]), phs ])
        ~init:[ env, [] ]
        under2vars
    | 1 ->
      let all_as = get_range () in
      log
        "all as: @[%a@]\n%!"
        Format.(pp_print_list ~pp_sep:(fun ppf () -> fprintf ppf " ") pp_print_int)
        all_as;
      Base.Set.Poly.fold
        ~f:(fun acc name ->
          let* a = all_as in
          let* acc, phs = acc in
          let u = gensym ~prefix:"u" () in
          let v = gensym ~prefix:"v" () in
          [ ( Env.extend_exn
                acc
                name
                Id_symantics.(
                  Ast.Eia.Add
                    [ pow2var u; Ast.Eia.Mul [ const (-1); pow2var v ]; const a ])
            , Id_symantics.(prj (leq (var v) (var u))) :: phs )
          ])
        ~init:[ env, [] ]
        under2vars
    | n ->
      Base.Set.Poly.fold
        ~f:(fun acc name ->
          let* acc, phs = acc in
          let vars = List.init (1 + n) (fun _ -> gensym ~prefix:"u" ()) in
          let sum =
            List.mapi
              (fun i u ->
                 if i mod 2 = 1
                 then Id_symantics.(mul [ const (-1); pow2var u ])
                 else Id_symantics.(pow2var u))
              vars
          in
          let constraints =
            List.fold_right
              (fun v (oldv, acc) ->
                 let v = Id_symantics.var v in
                 v, Id_symantics.(prj (leq oldv v)) :: acc)
              vars
              (Id_symantics.const 0, [])
            |> snd
          in
          [ Env.extend_exn acc name (Ast.Eia.Add sum), constraints @ phs ])
        ~init:[ env, [] ]
        under2vars
  in
  List.map
    (fun (e, phs) ->
       let (module Symantics) = make_main_symantics e in
       apply_symantics (module Symantics) (Symantics.land_ (ast :: phs)))
    envs
;;

let simpl bound ast =
  let prepare_choices env var_info =
    let ( let* ) xs f = List.concat_map f xs in
    let choice1 = List.init (bound + 1) Fun.id in
    Base.Set.Poly.fold
      ~f:(fun acc name ->
        let* v = choice1 in
        let* acc = acc in
        [ Env.extend_exn acc name (Ast.Eia.Atom (Const (Z.of_int v))) ])
      ~init:[ env ]
      var_info.Info.exp
  in
  let on_env step env =
    (* log "step: %a. env = %a\n" pp_step step Env.pp env; *)
    let (module Symantics) = make_main_symantics env in
    let ast_spec = apply_symantics (module Symantics) ast in
    match basic_simplify step env ast_spec with
    | `Unsat -> `Unknown
    | `Sat env -> raise (Underapprox_fired env)
    | `Unknown (ast, env, _info, step) ->
      let var_info = apply_symantics (module Who_in_exponents) ast_spec in
      let ast_spec = flatten var_info ast_spec in
      let ast_spec = apply_symantics (module Symantics) ast_spec in
      let __ () =
        log "step: %a. flattened ast = %a\n" pp_step step Ast.pp_smtlib2 ast_spec
      in
      (match check_errors ast_spec with
       | [] ->
         let ph = apply_symantics (make_smtml_symantics Utils.Map.empty) ast_spec in
         let solver = Smtml.Z3_mappings.Solver.make ~logic:Smtml.Logic.LIA () in
         Smtml.Z3_mappings.Solver.reset solver;
         (match Smtml.Z3_mappings.Solver.check solver ~assumptions:[ ph ] with
          | `Sat ->
            Printf.eprintf
              "The model could be not fully populated. %s %d\n%!"
              __FILE__
              __LINE__;
            raise (Underapprox_fired env)
          | `Unsat | `Unknown -> `Unknown)
       | errors ->
         log "%d errors found" (List.length errors);
         Format.printf "@[<v>%a@]\n%!" (Format.pp_print_list pp_error) errors;
         `Errors)
  in
  let loop (env : Env.t) ast =
    match basic_simplify [ 1 ] env ast with
    | `Unsat -> raise Unsat
    | `Sat env -> raise (Sat ("", env))
    | `Unknown (ast, env, _, _) when bound <= 0 -> ast, env
    | `Unknown (ast, env, _var_info, step) ->
      let ast = flatten _var_info ast in
      let var_info = apply_symantics (module Who_in_exponents) ast in
      let all_choices = prepare_choices env var_info in
      assert (all_choices <> []);
      let verdicts = List.mapi (fun i -> on_env (i :: step)) all_choices in
      let is_error = function
        | `Errors -> true
        | `Unknown -> false
      in
      if verdicts <> [] && List.for_all is_error verdicts
      then (
        match check_errors ast with
        | [] ->
          Printf.eprintf "Something weird: no errors. %s %d\n%!" __FILE__ __LINE__;
          raise (Error (ast, []))
        | errors -> raise (Error (ast, errors)));
      ast, env
  in
  let ast, env = loop Env.empty ast in
  (* Underapprox I *)
    match if bound >= 0 then Underapprox.check bound ast else `Unknown ast with
    | `Sat (reason, e) -> `Sat (reason, Env.merge e env)
    | `Unknown _ ->
      (try
         match check_errors ast with
         | [] -> `Unknown ast
         | errrs when Config.get_flat () < 0 ->
           `Error (ast, Base.List.dedup_and_sort ~compare:Stdlib.compare errrs)
         | errrs ->
           (* Underapprox II *)
           (* TODO(Kakadu): enrich environment  *)
           let env = Env.empty in
           log "%s %d" __FILE__ __LINE__;
           let asts = try_under2_heuristics env ast in
           let asts =
             List.filter_map
               (fun ast ->
                  match basic_simplify [ 1 ] env ast with
                  | `Unsat -> None
                  | `Sat env -> raise (Underapprox_fired env)
                  | `Unknown (ast, _, _, _) ->
                    let var_info = apply_symantics (module Who_in_exponents) ast in
                    let ast = flatten var_info ast in
                    (match check_errors ast with
                     | [] -> Some ast
                     | errors ->
                       log "Bad AST: @[%a]" Ast.pp_smtlib2 ast;
                       Format.printf
                         "@[<v>%a@]\n%!"
                         (Format.pp_print_list pp_error)
                         errors;
                       None))
               asts
           in
           `Underapprox asts
       with
       | Unsat -> `Unsat
       | Underapprox_fired env -> `Sat ("underappox2", env)
       | Sat (reason, env) -> `Sat (reason, env)
       | Error (ast, errs) -> `Error (ast, errs))
;;

let run_under1 bound ast : [> `Sat of string * Env.t | `Unknown ] =
  if bound >= 0
  then (
    match Underapprox.check bound ast with
    | `Sat s -> `Sat s
    | `Unknown _ -> `Unknown)
  else `Unknown
;;

let run_under2 env ast =
  let asts = try_under2_heuristics env ast in
  let asts =
    List.filter_map
      (fun ast ->
         match basic_simplify [ 1 ] env ast with
         | `Unsat -> None
         | `Sat env -> raise_notrace (Underapprox_fired env)
         | `Unknown (ast, _, _, _) ->
           let var_info = apply_symantics (module Who_in_exponents) ast in
           let ast = flatten var_info ast in
           (match check_errors ast with
            | [] -> Some ast
            | errors ->
              log "Bad AST: @[%a]" Ast.pp_smtlib2 ast;
              Format.printf "@[<v>%a@]\n%!" (Format.pp_print_list pp_error) errors;
              None))
      asts
  in
  `Underapprox asts
;;

let rewrite_concats { Info.all; _ } =
  let gensym1 = gensym in
  let rec gensym () =
    let ans = gensym1 ~prefix:"eeb" () in
    if Base.Set.Poly.mem all ans then gensym () else ans
  in
  let extra_ph = ref [] in
  let mapping = ref Term_map.empty in
  let extend v other =
    extra_ph := Id_symantics.eq (Id_symantics.var v) other :: !extra_ph;
    mapping := Term_map.add (`Eia other) v !mapping
  in
  let extend_leq v other =
    extra_ph := Id_symantics.leq (Id_symantics.var v) other :: !extra_ph;
    mapping := Term_map.add (`Eia other) v !mapping
  in
  let module M_ = struct
    include Id_symantics

    let str_concat (lhs : term) (rhs : term) =
      let u = gensym () in
      let v = gensym () in
      let lhs' = gensym () in
      let rhs' = gensym () in
      extend lhs' (Ast.Eia.Iofs lhs);
      extend rhs' (Ast.Eia.Iofs rhs);
      extend
        u
        (Ast.Eia.add
           [ Ast.Eia.mul
               [ Ast.Eia.Atom (Ast.var lhs')
               ; Ast.Eia.pow
                   (Ast.Eia.Atom (Ast.const (Config.base ())))
                   (Ast.Eia.Atom (Ast.var v))
               ]
           ; Ast.Eia.atom (Ast.var rhs')
           ]);
      extend v (Ast.Eia.len rhs);
      Ast.Eia.sofi (Ast.Eia.Atom (Var u))
    ;;

    let str_substr term (offset : string) (len : string) =
      let evar v = Ast.Eia.atom (Ast.var v) in
      let svar v = Ast.Eia.atom (Ast.var v) in
      let econst v = Ast.Eia.atom (Ast.const v) in
      let z1 = gensym () in
      let z2 = gensym () in
      let u = gensym () in
      let y = gensym () in
      let y' = gensym () in
      let base = econst (Config.base ()) in
      let term' = gensym () in
      extend term' (Ast.Eia.Iofs term);
      extend_leq
        z1
        (Ast.Eia.add
           [ Ast.Eia.pow base (evar offset); Ast.Eia.Atom (Ast.const Z.minus_one) ]);
      extend y (Ast.Eia.Iofs (svar y'));
      extend len (Ast.Eia.len (svar y'));
      extend u (Ast.Eia.add [ evar offset; evar len ]);
      extend
        term'
        (Ast.Eia.add
           [ evar z1
           ; Ast.Eia.mul [ evar y; Ast.Eia.pow base (evar offset) ]
           ; Ast.Eia.mul [ evar z2; Ast.Eia.pow base (evar u) ]
           ]);
      svar y'
    ;;

    let prj = function
      | Ast.Land xs -> land_ (!extra_ph @ xs)
      | ph -> land_ (!extra_ph @ [ ph ])
    ;;
  end
  in
  let module Sym = struct
    include M_
    include FT_SIG.Sugar (M_)
  end
  in
  fun ph -> Sym.prj (apply_symantics (module Sym) ph)
;;

let arithmetize ast =
  let var_info = apply_symantics (module Who_in_exponents) ast in
  rewrite_concats var_info ast
;;

let test_distr xs =
  let (module Main_symantics) = make_main_symantics Env.empty in
  let ans = distribute xs |> List.map Main_symantics.mul |> Main_symantics.add in
  Format.printf "@[%a@]\n%!" Ast.pp_term_smtlib2 ans
;;

let%expect_test _ =
  let (module Test_symantcs : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  test_distr Test_symantcs.[ const 5; add [ var "x"; var "y" ] ];
  [%expect "(+ (* 5 x) (* 5 y))"]
;;

let%expect_test _ =
  let (module Test_symantcs : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  test_distr Test_symantcs.[ const 5; add [ var "x"; var "y" ]; add [ var "z"; var "u" ] ];
  [%expect "(+ (* 5 u x) (* 5 u y) (* 5 x z) (* 5 y z))"]
;;

let%expect_test _ =
  let (module Test_symantcs : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  test_distr Test_symantcs.[ const 5; add [ var "x"; var "y" ]; add [ var "z"; const 2 ] ];
  [%expect "(+ (* 5 x z) (* 5 y z) (* 10 x) (* 10 y))"]
;;

let leq_simpl l r =
  let (module TS : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  let ans = TS.prj TS.(l <= r) in
  Format.printf "@[%a@]\n%!" Ast.pp_smtlib2 ans
;;

let%expect_test " -2x <= -7" =
  let (module TS : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  leq_simpl TS.(mul [ const (-2); var "x" ]) TS.(const (-7));
  [%expect "(<= (* (- 1) x) (- 4))"]
;;

let%expect_test " -2x <= -8" =
  let (module TS : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  leq_simpl TS.(mul [ const (-2); var "x" ]) TS.(const (-8));
  [%expect "(<= (* (- 1) x) (- 4))"]
;;

let%expect_test " -2x <= -1" =
  let (module TS : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  leq_simpl TS.(mul [ const (-2); var "x" ]) TS.(const (-1));
  [%expect "(<= (* (- 1) x) (- 1))"]
;;

let tracing_on =
  match Sys.getenv "CHRO_TRACE_OPT" with
  | exception Not_found -> false
  | "1" -> true
  | _ -> false
;;

let log ppf =
  if tracing_on
  then Format.kasprintf (Format.printf "%s%!") ppf
  else Format.ifprintf Format.std_formatter ppf
;;

let shrink_variables ast =
  let _ : Ast.t = ast in
  log "old ast: @[%a@]\n" Ast.pp_smtlib2 ast;
  let info = apply_symantics (module Who_in_exponents) ast in
  log "@[<v 2>@[Old info:@]@ @[%a@]@]\n" Info.pp_hum info;
  let is_in_expo v = Info.is_in_expo v info in
  let same_base l r = is_in_expo l && is_in_expo r in
  (* Now let's make exponential variables more exponential *)
  let module Sy = struct
    open Ast
    include Id_symantics
    include FT_SIG.Sugar (Id_symantics)

    (* TODO(Kakadu): maybe a syntax extension for better matching? *)
    (* TODO: detect base from variable usage  *)
    let good_enough_constant rhs = Z.lt rhs (Z.of_int (Config.i150const ()))

    let leq l r =
      let open Eia in
      (* Format.printf "TRACE: @[%a@]\n%!" Ast.pp_smtlib2 (Id_symantics.leq l r); *)
        match l, r with
        | Atom (Var v), Atom (Const rhs) when is_in_expo v && good_enough_constant rhs ->
          (* v<=c ~~> 10^v <= 10^c *)
          Id_symantics.leq (10 ** l) (10 ** r)
        | Add [ Atom (Var v); Mul [ Atom (Const m1); Atom (Var v2) ] ], Eia.Atom (Const z)
          when same_base v v2
               && Z.(equal z zero)
               && Z.(equal m1 minus_one)
               && good_enough_constant z
               (* v - v2 <=0 ~~>  10^v <= 10^v2  *) ->
          Id_symantics.leq (10 ** var v) (10 ** var v2)
        | Add [ Atom (Var v); Mul [ Atom (Const c); Atom (Var v2) ] ], Eia.Atom (Const z)
          when same_base v v2
               && Z.(equal z zero)
               && Z.(lt c zero)
               && good_enough_constant z
               (* v - c*v2 <= 0 ~~>  10^v2 <= (10^c)^v) *) ->
          Id_symantics.leq (10 ** var v2) (pow (10 ** constz (Z.abs c)) (var v))
        | _ -> Id_symantics.leq l r
    ;;
  end
  in
  let ast2 = apply_symantics_unsugared (module Sy) ast in
  let info2 = apply_symantics (module Who_in_exponents) ast in
  log "new ast: @[%a@]\n" Ast.pp_smtlib2 ast2;
  log "@[<v 2>@[New info:@]@ @[%a@]@]\n" Info.pp_hum info2;
  ast2
;;

let%test_module "about shrinking" =
  (module struct
    let wrap f =
      let ast = Ast.land_ (f (make_main_symantics Env.empty)) in
      (* let ast =
        match simpl 0 ast with
        | `Unknown ast -> ast
        | `Sat _ -> failwith (Printf.sprintf "Too simple test %d" __LINE__)
        | `Error _ -> failwith (Printf.sprintf "Too simple test %d" __LINE__)
        | `Underapprox _ -> failwith (Printf.sprintf "Too simple test %d" __LINE__)
        | `Unsat -> failwith (Printf.sprintf "Too simple test %d" __LINE__)
      in *)
      Format.printf "%a\n%!" Ast.pp_smtlib2 ast;
      let ast = shrink_variables ast in
      Format.printf "           @ @[%a@]%!" Ast.pp_smtlib2 ast
    ;;

    let%expect_test "The simplest thing" =
      wrap (fun (module TS : SYM_SUGAR_AST) ->
        let open TS in
        [ add [ pow2var "x"; pow2var "y" ] <= const 52; var "x" <= const 3 ]);
      [%expect
        {|
        (and
          (<= (+ (exp 2 x) (exp 2 y)) 52)
          (<= x 3))

        (and
          (<= (+ (exp 2 x) (exp 2 y)) 52)
          (<= (exp 10 x) (exp 10 3)))
        |}]
    ;;

    let%expect_test "Without interesting coefs" =
      (* TODO: different bases are not yet supported *)
      wrap (fun (module TS : SYM_SUGAR_AST) ->
        let open TS in
        [ add [ pow2var "x"; pow2var "y"; 10 ** var "u"; 10 ** var "v" ] <= const 5000
        ; add [ var "x"; mul [ const (-1); var "y" ] ] <= const 0
        ; add [ mul [ const (-1); var "u" ]; var "v" ] <= const 0
        ]);
      [%expect
        {|
        (and
          (<= (+ (exp 2 x) (exp 2 y) (exp 10 u) (exp 10 v)) 5000)
          (<= (+ x (* (- 1) y)) 0)
          (<= (+ v (* (- 1) u)) 0))

        (and
          (<= (+ (exp 2 x) (exp 2 y) (exp 10 u) (exp 10 v)) 5000)
          (<= (exp 10 x) (exp 10 y))
          (<= (+ v (* (- 1) u)) 0))
        |}]
    ;;

    let%expect_test "With coeffs" =
      wrap (fun (module TS : SYM_SUGAR_AST) ->
        let open TS in
        [ add [ pow2var "x"; pow2var "y" ] <= const 52
        ; add [ var "x"; mul [ const (-3); var "y" ] ] <= const 0
        ]);
      [%expect
        {|
        (and
          (<= (+ (exp 2 x) (exp 2 y)) 52)
          (<= (+ x (* (- 3) y)) 0))

        (and
          (<= (+ (exp 2 x) (exp 2 y)) 52)
          (<= (exp 10 y) (exp (exp 10 3) x)))
        |}]
    ;;
  end)
;;
