let log fmt = Format.kasprintf print_endline fmt

module type SYM0 = sig
  type term
  type ph

  include FT_SIG.s_term with type term := term
  include FT_SIG.s_ph with type ph := ph and type term := term

  val pow2var : string -> term
  val exists : string list -> ph -> ph
end

module type SYM = sig
  include SYM0

  type repr

  val prj : ph -> repr
end

module Main_symantics_ : SYM with type repr = Ast.t = struct
  open Ast

  type term = Ast.Eia.term
  type ph = Ast.t
  type repr = Ast.t

  let compare_term = Eia.compare_term
  let exists var ph = Ast.Exists (List.map Ast.var var, ph)
  let not x = Ast.Lnot x
  let land_ x = Ast.Land x
  let lor_ x = Ast.Lor x
  let true_ = Ast.true_
  let false_ = Ast.false_
  let lt l r = Eia (Eia.lt l r)
  let leq l r = Eia (Ast.Eia.leq l r)
  let eq l r = Eia (Ast.Eia.eq l r)

  let fold_and_sort init op xs =
    let c, xs =
      List.fold_left
        (fun (cacc, phacc) -> function
           | Eia.Atom (Const c) -> op c cacc, phacc
           | ph -> cacc, ph :: phacc)
        (1, [])
        xs
    in
    c, List.sort compare_term xs
  ;;

  let mul xs =
    match fold_and_sort 1 ( * ) xs with
    | 1, xs -> Ast.Eia.mul (List.sort compare_term xs)
    | c, [] -> Eia.atom (Const c)
    | c, xs -> Ast.Eia.mul (Eia.atom (Const c) :: List.sort compare_term xs)
  ;;

  let add xs =
    match fold_and_sort 0 ( + ) xs with
    | 0, xs -> Ast.Eia.add (List.sort compare_term xs)
    | c, [] -> Eia.atom (Const c)
    | c, xs -> Ast.Eia.add (Eia.atom (Const c) :: List.sort compare_term xs)
  ;;

  let bw k a b =
    match k with
    | FT_SIG.Bwand -> Ast.Eia.bwand a b
    | FT_SIG.Bwor -> Ast.Eia.bwor a b
    | FT_SIG.Bwxor -> Ast.Eia.bwxor a b
  ;;

  let var s = Eia.atom (Ast.var s)
  let const c = Ast.Eia.Atom (Ast.const c)
  let pow base xs = Ast.Eia.Pow (base, xs)
  let pow2var v = Ast.Eia.Pow (const 2, var v)
  let prj x = x
end

module Main_symantics = struct
  include Main_symantics_
  include FT_SIG.Sugar (Main_symantics_)
end

module type SYM_SUGAR = sig
  include SYM
  include FT_SIG.s_extra with type ph := ph and type term := term
end

let apply_symnatics (type a) (module S : SYM_SUGAR with type repr = a) =
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
            | Ast.Var s -> Some s
            | Ast.Const _ -> None)
          vs
      in
      S.exists vs (helper ph)
  and helperT = function
    | Ast.Eia.Atom (Ast.Const n) -> S.const n
    | Atom (Ast.Var s) -> S.var s
    | Add terms -> S.add (List.map helperT terms)
    | Mul terms -> S.mul (List.map helperT terms)
    | Pow (Atom (Ast.Const 2), Atom (Ast.Var x)) -> S.pow2var x
    | Pow (base, p) -> S.pow (helperT base) (helperT p)
    | Bwand (l, r) -> S.bw FT_SIG.Bwand (helperT l) (helperT r)
    | Bwor (l, r) -> S.bw FT_SIG.Bwor (helperT l) (helperT r)
    | Bwxor (l, r) -> S.bw FT_SIG.Bwxor (helperT l) (helperT r)
  and helper_eia eia =
    match eia with
    | Ast.Eia.Eq (l, r) -> S.(helperT l = helperT r)
    | Leq (l, r) -> S.(helperT l <= helperT r)
  in
  fun x -> S.prj (helper x)
;;

let simpl ast =
  log "%s %d" __FILE__ __LINE__;
  let _ast : Ast.t = apply_symnatics (module Main_symantics) ast in
  `Unknown _ast
;;
