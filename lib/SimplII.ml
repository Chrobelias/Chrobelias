let log fmt = Format.kasprintf print_endline fmt

type relop =
  | Leq
  | Eq

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

  val prj : ph -> repr [@@warning "-32"]
end

module Main_symantics_ (*: SYM with type repr = Ast.t*) = struct
  open Ast

  type term = Ast.Eia.term
  type ph = Ast.t
  type repr = Ast.t

  let compare_term = Eia.compare_term

  (** Terms *)

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

  let fold_and_sort init op xs =
    let c, xs =
      List.fold_left
        (fun (cacc, phacc) -> function
           | Eia.Atom (Const c) -> op c cacc, phacc
           | ph -> cacc, ph :: phacc)
        (init, [])
        xs
    in
    c, List.sort compare_term xs
  ;;

  let distribute xs =
    List.fold_left
      (fun acc -> function
         | Eia.Add ys -> List.concat_map (fun zs -> List.map (fun h -> h :: zs) ys) acc
         | other -> List.map (fun x -> other :: x) acc)
      ([ [] ] : term list list)
      xs
  ;;

  let mul xs =
    let xs =
      List.concat_map
        (function
          | Eia.Mul xs -> xs
          | x -> [ x ])
        xs
    in
    match fold_and_sort 1 ( * ) xs with
    | 1, xs -> Ast.Eia.mul (List.sort compare_term xs)
    | c, [] -> Eia.atom (Const c)
    | c, xs -> Ast.Eia.mul (Eia.atom (Const c) :: List.sort compare_term xs)
  ;;

  let add xs =
    let xs =
      List.concat_map
        (function
          | Eia.Add xs -> xs
          | x -> [ x ])
        xs
    in
    match fold_and_sort 0 ( + ) xs with
    | 0, xs -> Ast.Eia.add (List.sort compare_term xs)
    | c, [] -> Eia.atom (Const c)
    | c, xs -> Ast.Eia.add (Eia.atom (Const c) :: List.sort compare_term xs)
  ;;

  let rec negate = function
    | Eia.Add xs -> add (List.map negate xs)
    | x -> mul [ const (-1); x ]
  ;;

  (** Formulas *)
  let exists var ph = Ast.Exists (List.map Ast.var var, ph)

  let rec not = function
    | Ast.Lnot x -> x
    | Land xs -> Ast.Lor (List.map not xs)
    | Lor xs -> Ast.Land (List.map not xs)
    | x -> x
  ;;

  let land_ x = Ast.Land x
  let lor_ x = Ast.Lor x
  let true_ = Ast.true_
  let false_ = Ast.false_

  let relop op l r =
    let ofop =
      match op with
      | Leq -> fun x y -> Eia (Eia.leq x y)
      | Eq -> fun x y -> Eia (Eia.eq x y)
    in
    match l, r with
    | Eia.Add ls, Eia.Add rs -> ofop (add (ls @ List.map negate rs)) (const 0)
    | Eia.Add (Atom (Const c) :: tl), Atom (Const n) -> ofop (Eia.Add tl) (const (n - c))
    | Atom (Const c), Add (Atom (Const n) :: tl) ->
      ofop (add (List.map negate tl)) (const (n - c))
    | Atom (Const c), Add xs -> ofop (add (List.map negate xs)) (const (-c))
    | _ -> ofop l r
  ;;

  let lt l r = relop Leq (add [ const 1; l ]) r
  let leq l r = relop Leq l r
  let eq l r = relop Eq l r
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

let apply_symnatics (type a) (module S : SYM_SUGAR with type ph = a) =
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
  fun x -> helper x
;;

let simpl ast =
  log "%s %d" __FILE__ __LINE__;
  let rec loop step ast =
    if step > 5 then exit 1;
    Printf.printf "iteration %d\n" step;
    Format.printf "ast(%d) = @[%a@]\n%!" step Ast.pp_smtlib2 ast;
    let rez = apply_symnatics (module Main_symantics) ast in
    let ast2 = Main_symantics.prj rez in
    if Stdlib.(ast2 = ast)
    then (
      let () = Printf.printf "Fixpoint after %d steps\n" step in
      ast)
    else loop (step + 1) ast2
  in
  let _ast = loop 1 ast in
  (* let _ast : Ast.t = apply_symnatics (module Main_symantics) ast in *)
  `Unknown _ast
;;

let test_distr xs =
  let ans =
    Main_symantics.(distribute xs) |> List.map Main_symantics.mul |> Main_symantics.add
  in
  Format.printf "@[%a@]\n%!" Ast.pp_term_smtlib2 ans
;;

let%expect_test _ =
  test_distr Main_symantics.[ const 5; add [ var "x"; var "y" ] ];
  [%expect "(+ (* 5 x) (* 5 y))"]
;;

let%expect_test _ =
  test_distr
    Main_symantics.[ const 5; add [ var "x"; var "y" ]; add [ var "z"; var "u" ] ];
  [%expect "(+ (* 5 u x) (* 5 u y) (* 5 x z) (* 5 y z))"]
;;

let%expect_test _ =
  test_distr
    Main_symantics.[ const 5; add [ var "x"; var "y" ]; add [ var "z"; const 2 ] ];
  [%expect "(+ (* 5 x z) (* 5 y z) (* 10 x) (* 10 y))"]
;;
