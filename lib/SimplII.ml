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

module Env = struct
  type t = (string, int) Base.Map.Poly.t

  let extend m key data = Base.Map.Poly.add_exn m ~key ~data
  let empty : t = Base.Map.Poly.empty
  let is_empty = Base.Map.Poly.is_empty
  let length = Base.Map.Poly.length [@@warning "-32"]
  let lookup k map = Base.Map.Poly.find map k
  let merge : t -> t -> t = Base.Map.Poly.merge_disjoint_exn

  let pp : Format.formatter -> t -> unit =
    fun ppf s ->
    Format.fprintf ppf "@[{| ";
    Base.Map.iteri s ~f:(fun ~key ~data -> Format.fprintf ppf "%s -> %d; " key data);
    Format.fprintf ppf "|}@]"
  [@@ocaml.warning "-32"]
  ;;
end

let make_main_symantics env =
  let module Main_symantics_ (*: SYM with type repr = Ast.t*) = struct
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

    let const c = Ast.Eia.Atom (Ast.const c)

    let var s =
      match Env.lookup s env with
      | None -> Eia.atom (Ast.var s)
      | Some c -> const c
    ;;

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

    let mul xs =
      let xs =
        List.concat_map
          (function
            | Eia.Mul xs -> xs
            | x -> [ x ])
          xs
      in
      match fold_and_sort 1 ( * ) xs with
      | 1, [ h ] -> h
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
      | 0, [ h ] -> h
      | 0, [] -> const 0
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

    let true_ = Ast.true_
    let false_ = Ast.false_

    let rec not = function
      | Ast.Lnot x -> x
      | Land xs -> Ast.Lor (List.map not xs)
      | Lor xs -> Ast.Land (List.map not xs)
      | x -> x
    ;;

    let land_ xs =
      let flat =
        List.concat_map
          (function
            | Ast.Land xs -> xs
            | True -> []
            | x -> [ x ])
          xs
      in
      match flat with
      | [] -> false_
      | [ h ] -> h
      | xs -> Ast.Land (List.sort Ast.compare xs)
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
         | Eq when l = r -> true_
         | Eq -> false_
         | Leq when l <= r -> true_
         | Leq -> false_)
      | Eia.Add ls, Eia.Add rs -> ofop (add (ls @ List.map negate rs)) (const 0)
      | Eia.Add (Atom (Const c) :: tl), Atom (Const n) ->
        ofop (Eia.Add tl) (const (n - c))
      | Atom (Const c), Add (Atom (Const n) :: tl) ->
        ofop (add (List.map negate tl)) (const (n - c))
      | Atom (Const c), Add xs -> ofop (add (List.map negate xs)) (const (-c))
      | _ -> ofop l r
    ;;

    let lt l r = relop Leq (add [ const 1; l ]) r
    let leq l r = relop Leq l r
    let eq l r = relop Eq l r
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

exception Unsat

(* module Const_prop_sym_ = struct
  type ph = Env.t * Ast.t

  open Ast

  let eq l r : ph =
    match l, r with
    | Ast.Eia.Mul [ Eia.Atom (Ast.Const c); Eia.Atom (Var v) ], Eia.Atom (Const r) ->
      if r mod c = 0 then Env.extend Env.empty v (r / c), Ast.True else raise Unsat
    | _ -> Env.empty, Eia (Eia.eq l r)
  ;;
end *)

let try_propagate : Ast.t -> Env.t * Ast.t =
  let open Ast in
  let helper = function
    | Ast.Land xs ->
      (* log "%s %d xs.length = %d" __FILE__ __LINE__ (List.length xs); *)
      let env, xs =
        List.fold_left
          (fun (env, rest) -> function
             | Eia
                 (Eia.Eq
                    (Eia.Mul [ Atom (Const coeff); Atom (Var v) ], Eia.Atom (Ast.Const r)))
               ->
               if r mod coeff = 0 then Env.extend env v (r / coeff), rest else raise Unsat
             | Eia Eia.(Eq (Atom (Var v), Atom (Const r)))
             | Eia Eia.(Eq (Atom (Const r), Atom (Var v))) -> Env.extend env v r, rest
             | other -> env, other :: rest)
          (Env.empty, [])
          xs
      in
      (* log
        "%s %d xs.length = %d, env.length = %d"
        __FILE__
        __LINE__
        (List.length xs)
        (Env.length env); *)
      env, Ast.land_ xs
    | ast -> Env.empty, ast
  in
  fun ast ->
    (* log "%s %d" __FILE__ __LINE__; *)
    helper ast
;;

let%expect_test _ =
  let (module Main_symantics) = make_main_symantics Env.empty in
  let wrap ph =
    let e, ast = try_propagate ph in
    Format.printf "@[<v>";
    Format.printf "@[rest ast: @[%a@]@]@ " Ast.pp_smtlib2 ast;
    Format.printf "@[env:      @[%a@]@]" Env.pp e;
    Format.printf "@]%!"
  in
  wrap Main_symantics.(land_ [ eq (mul [ const 5; var "x" ]) (const 50) ]);
  [%expect "\n rest ast: (= (* 5 x) 50)\n env:      {| |}\n "];
  wrap
    Main_symantics.(
      land_
        [ eq (mul [ const 5; var "x" ]) (const 50)
        ; eq (mul [ const 3; var "y" ]) (const 60)
        ; leq (mul [ const 5; var "z" ]) (const 50)
        ]);
  [%expect "\n rest ast: (<= (* 5 z) 50)\n env:      {| x -> 10; y -> 20; |}\n "]
;;

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
  let rec loop step env ast =
    if step > 5 then exit 1;
    Printf.printf "iteration %d\n" step;
    Format.printf "ast(%d) = @[%a@]\n%!" step Ast.pp_smtlib2 ast;
    let (module Symantics) = make_main_symantics env in
    let rez = apply_symnatics (module Symantics) ast in
    let ast2 = Symantics.prj rez in
    if Stdlib.(ast2 = ast)
    then (
      (* *)
      let env2, ast3 = try_propagate ast2 in
      if Env.is_empty env2
      then (
        let () = Printf.printf "Fixpoint after %d steps\n" step in
        ast)
      else (
        let () = log "Something ready to substitute: %a" Env.pp env2 in
        (* TODO: substiture somewhere *)
        loop (step + 1) (Env.merge env2 env) ast3))
    else loop (step + 1) env ast2
  in
  try
    let _ast = loop 1 Env.empty ast in
    `Unknown _ast
  with
  | Unsat -> `Unsat
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
