[@@@warning "-unused-value-declaration"]

let log = Utils.log

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

let is_pure_lia ph = [] = check_errors ph

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
  type t = (string, Ast.Eia.term) Base.Map.Poly.t

  let walk : t -> Ast.Eia.term -> Ast.Eia.term =
    fun env ->
    Ast.Eia.map_term (function
      | Ast.Eia.Atom (Ast.Var s) as orig ->
        (match Base.Map.Poly.find_exn env s with
         | exception Base.Not_found_s _ -> orig
         | t -> t)
      | t -> t)
  ;;

  let occurs_var : string -> Ast.Eia.term -> bool =
    fun v term ->
    try
      Ast.Eia.fold_term
        (fun () -> function
           | Ast.(Eia.Atom (Var v2)) when String.equal v v2 -> raise Exit
           | _ -> ())
        ()
        term;
      false
    with
    | Exit -> true
  ;;

  exception Occurs

  let extend_exn : t -> _ -> _ -> t =
    fun m key data ->
    let data = walk m data in
    if occurs_var key data then raise Occurs else Base.Map.Poly.add_exn m ~key ~data
  ;;

  let empty : t = Base.Map.Poly.empty
  let is_empty = Base.Map.Poly.is_empty
  let length = Base.Map.Poly.length [@@warning "-32"]
  let lookup k map = Base.Map.Poly.find map k
  let is_absent_key k map = not (Base.Map.Poly.mem map k)

  let merge : t -> t -> t =
    Base.Map.Poly.merge_skewed ~combine:(fun ~key v1 v2 ->
      if Stdlib.(v1 = v2)
      then v1
      else (
        Format.eprintf "v1 = %a\n%!" Ast.pp_term_smtlib2 v1;
        Format.eprintf "v2 = %a\n%!" Ast.pp_term_smtlib2 v2;
        failwith "We tried to subtitute a varible by two different terms"))
  ;;

  let pp : Format.formatter -> t -> unit =
    fun ppf s ->
    Format.fprintf ppf "@[ ";
    Base.Map.iteri s ~f:(fun ~key ~data ->
      Format.fprintf ppf "%s -> @[%a@]; " key Ast.pp_term_smtlib2 data);
    Format.fprintf ppf "@]"
  [@@ocaml.warning "-32"]
  ;;
end

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
  type ph = Ast.t
  type repr = Ast.t

  (** Terms *)
  let bw k a b =
    match k with
    | FT_SIG.Bwand -> Ast.Eia.bwand a b
    | FT_SIG.Bwor -> Ast.Eia.bwor a b
    | FT_SIG.Bwxor -> Ast.Eia.bwxor a b
  ;;

  let pow = Ast.Eia.pow
  let mul = Ast.Eia.mul
  let add = Ast.Eia.add
  let land_ xs = Ast.Land xs
  let lor_ xs = Ast.Lor xs
  let not = Ast.lnot

  include Ast

  let const s : term = Ast.Eia.Atom (Ast.Const s)
  let var s = Ast.Eia.Atom (Ast.Var s)
  let exists var ph = Ast.Exists (List.map Ast.var var, ph)
  let eq l r = Ast.Eia (Ast.Eia.eq l r)
  let leq l r = Ast.Eia (Ast.Eia.leq l r)
  let lt l r = Ast.Eia (Ast.Eia.lt l r)
  let prj = Fun.id
  let pow2var s = pow (const 2) (var s)
end

let apply_symantics (type a) (module S : SYM_SUGAR with type ph = a) =
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
    | Str _ -> failwith "TBD"
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
    | Len _ -> failwith "TBD"
    | Stoi _ -> failwith "TBD"
  and helper_eia eia =
    match eia with
    | Ast.Eia.Eq (l, r) -> S.(helperT l = helperT r)
    | Leq (l, r) -> S.(helperT l <= helperT r)
  in
  fun x -> helper x
;;

let make_main_symantics env =
  let _ : Env.t = env in
  let module Main_symantics_ (*: SYM with type repr = Ast.t*) = struct
    open Ast
    include Id_symantics

    let compare_term = Eia.compare_term
    let const c = Ast.Eia.Atom (Ast.const c)

    let var s : term =
      match Env.lookup s env with
      | None -> Eia.Atom (Ast.var s)
      | Some c -> c
    ;;

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
             , Eia.Pow ((Atom (Const basec) as base), Add (Atom (Const -1) :: ss)) :: tl )
             when Int.equal (abs c) basec ->
             Atom (Const (c / basec)) :: Eia.Pow (base, Add ss) :: tl
           | x, _ -> x :: acc)
        xs
        []
    ;;

    let rec mul xs =
      let xs = collect_inside_mul xs in
      match fold_and_sort 1 ( * ) xs with
      | 0, _ -> Eia.atom (Const 0)
      | c, [] -> Eia.atom (Const c)
      | 1, [ h ] -> h
      | 1, xs -> Ast.Eia.mul (List.sort compare_term xs)
      | 2, [ Pow ((Atom (Const 2) as base), Add [ Atom (Const -1); v ]) ] -> pow base v
      | c, [ Add ss ] -> Eia.Add (List.map (fun x -> Eia.Mul [ const c; x ]) ss)
      | c, xs -> Ast.Eia.mul (Eia.atom (Const c) :: List.sort compare_term xs)

    and pow base xs =
      match base, xs with
      | _, Eia.Atom (Const 0) -> const 1
      | Eia.Pow (base, e1), e2 -> Eia.Pow (base, Eia.Mul [ e1; e2 ])
      | Mul ((Atom (Const c) as base0) :: tl), Eia.Atom (Const e) ->
        mul [ pow base0 xs; pow (Mul tl) xs ]
      | Eia.Atom (Const base), Eia.Atom (Const exp) when exp > 0 ->
        const (Utils.pow ~base exp)
      | _ -> Ast.Eia.Pow (base, xs)
    ;;

    let rec add xs =
      let collect_inside_add xs =
        List.fold_right
          (fun x acc ->
             match x, acc with
             | Eia.Add ts, _ -> ts @ acc
             | Mul (Atom (Const c1) :: ph1), Eia.Mul (Atom (Const c2) :: ph2) :: tl
               when List.equal Ast.Eia.eq_term ph1 ph2 ->
               if c1 + c2 = 0 then tl else mul (Atom (Const (c1 + c2)) :: ph1) :: tl
             | a, _ -> a :: acc)
          xs
          []
      in
      let xs = collect_inside_add xs in
      match fold_and_sort 0 ( + ) xs with
      | 0, [ Eia.Atom (Var x); Mul [ Eia.Atom (Const -1); Eia.Atom (Var x2) ] ]
        when x = x2 -> const 0
      | c, Mul [ Eia.Atom (Const c1); t1 ] :: Mul [ Eia.Atom (Const c2); t2 ] :: tl
        when Stdlib.(t1 = t2) ->
        if c1 = -1 * c2
        then add (Atom (Const c) :: tl)
        else add (Atom (Const c) :: Mul [ Eia.Atom (Const (c1 + c2)); t1 ] :: tl)
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
         | Eq when Int.equal l r -> true_
         | Eq -> false_
         | Leq when l <= r -> true_
         | Leq -> false_)
      | Eia.(Add (Atom (Var v1) :: Mul [ Atom (Const -1); Atom (Var v2) ] :: tl)), rhs
        when String.equal v1 v2 -> ofop (Eia.Add tl) rhs
      | Eia.Add ls, Eia.Add rs -> ofop (add (ls @ List.map negate rs)) (const 0)
      | Eia.Add (Atom (Const c) :: tl), Atom (Const n) -> ofop (add tl) (const (n - c))
      | Atom (Const c), Add (Atom (Const n) :: tl) ->
        ofop (add (List.map negate tl)) (const (n - c))
      | Atom (Const c), Add xs -> ofop (add (List.map negate xs)) (const (-c))
      | Pow (basel, powl), Pow (baser, powr) when basel = baser -> ofop powl powr
      | Eia.Mul [ Atom (Const c); Atom (Var v) ], Eia.Atom (Const rhs)
        when op = Leq && abs c <> 1 ->
        (* optimizing single bounds *)
        if c < 0 && rhs < 0
        then
          ofop
            Eia.(Mul [ Atom (Const (-1)); Atom (Var v) ])
            (mul [ Atom (Const (-1)); Atom (Const ((abs rhs + 1) / abs c)) ])
        else
          (* TODO(Kakadu): Support other three cases *)
          ofop l r
      | _ -> ofop l r
    ;;

    let lt l r = relop Leq (add [ const 1; l ]) r
    let leq = relop Leq
    let eq x y = relop Eq x y
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
exception Sat of string

let try_propagate : Ast.t -> Env.t * Ast.t =
  let open Ast in
  let helper = function
    | Ast.Land xs ->
      let env, xs =
        List.fold_left
          (fun (env, rest) -> function
             | Eia
                 (Eia.Eq
                    (Eia.Mul [ Atom (Const coeff); Atom (Var v) ], Eia.Atom (Ast.Const r)))
               ->
               if r mod coeff = 0
               then Env.extend_exn env v (Eia.Atom (const (r / coeff))), rest
               else raise Unsat
             | Eia Eia.(Eq (Atom (Var v), Atom (Const r)))
             | Eia Eia.(Eq (Atom (Const r), Atom (Var v))) ->
               Env.extend_exn env v (Eia.Atom (const r)), rest
             | other -> env, other :: rest)
          (Env.empty, [])
          xs
      in
      env, Ast.land_ xs
    | ast -> Env.empty, ast
  in
  helper
;;

module Info = struct
  type t =
    { exp : string Base.Set.Poly.t
    ; all : string Base.Set.Poly.t
    }

  let is_in_expo name { exp; _ } = Base.Set.Poly.mem exp name

  let make ~exp ~all =
    (* TODO: check subsumtion *)
    { exp = Base.Set.Poly.of_list exp; all = Base.Set.Poly.of_list all }
  ;;

  let pp_exp ppf { exp; _ } =
    Format.fprintf
      ppf
      "exp: @[%a@]"
      Format.(
        pp_print_list Format.pp_print_string ~pp_sep:(fun ppf () -> fprintf ppf "@ "))
      (Base.Set.Poly.to_list exp)
  ;;
end

module Who_in_exponents_ = struct
  module S = Base.Set.Poly

  type term = Info.t

  open Info

  let pp_set ppf xs =
    Format.(fprintf ppf "@[%a@]" (pp_print_list pp_print_string ~pp_sep:pp_print_space))
      xs
  ;;

  let pp_info ppf { Info.exp; all } =
    Format.printf
      "@[{ all = @[%a@];@ exp  = @[%a@] }@]"
      pp_set
      (Base.Set.Poly.to_list all)
      pp_set
      (Base.Set.Poly.to_list exp)
  [@@warning "-32"]
  ;;

  let ( ++ ) e1 e2 = { Info.exp = S.union e1.exp e2.exp; all = S.union e1.all e2.all }
  let empty = { Info.exp = S.empty; all = S.empty }

  type ph = term
  type repr = ph

  let const _ = empty
  let var s = { empty with all = S.singleton s }
  let mul = List.fold_left ( ++ ) empty
  let add = List.fold_left ( ++ ) empty
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

  let pow2var v = { all = S.singleton v; exp = S.singleton v }
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

module Term_map = Map.Make (struct
    type t = Ast.Eia.term

    let compare = Stdlib.compare
  end)

let flatten { Info.all; _ } =
  let n = ref 0 in
  let rec gensym () =
    incr n;
    let ans = Printf.sprintf "eee%d" !n in
    if Base.Set.Poly.mem all ans then gensym () else ans
  in
  let extra_ph = ref [] in
  let mapping = ref Term_map.empty in
  let extend v other =
    extra_ph := Id_symantics.eq (Id_symantics.var v) other :: !extra_ph;
    mapping := Term_map.add other v !mapping
  in
  let module M_ = struct
    include Id_symantics

    let pow base e =
      match e with
      | Ast.Eia.Atom (Ast.Var _) | Ast.Eia.Atom (Ast.Const _) -> Id_symantics.pow base e
      | _ ->
        (match Term_map.find e !mapping with
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

    let pow2var s = pow (const 2) (var s)

    let exists vars x =
      let vars = List.filter (fun s -> Stdlib.not (Base.Map.Poly.mem env s)) vars in
      match vars with
      | [] -> x
      | _ -> Smtml.Expr.exists (List.map var vars) x
    ;;
  end
  in
  (module struct
    include M
    include FT_SIG.Sugar (M)
  end : SYM_SUGAR
    with type ph = Smtml.Expr.t)
;;

let eq_propagation : Info.t -> Env.t -> Ast.t -> Env.t =
  let open Ast in
  let (module S : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  let single info env c1 v1 c2 v2 rhs =
    try
      match c1, Info.is_in_expo v1 info, c2, Info.is_in_expo v2 info with
      | 1, false, _, _ when Env.is_absent_key v1 env && Env.is_absent_key v2 env ->
        Env.extend_exn env v1 S.(add [ mul [ const (-1); const c2; var v2 ]; rhs ])
      | _, _, 1, false when Env.is_absent_key v2 env && Env.is_absent_key v2 env ->
        Env.extend_exn env v2 S.(add [ mul [ const (-1); const c1; var v1 ]; rhs ])
      | _ -> env
      (* TODO(Kakadu): Support proper occurs check to workaround recursive substitutions *)
      (* Note: presence of key means we already simplified this variable in another equality *)
    with
    | Env.Occurs -> env
  in
  let helper info env = function
    | Eia (Eia.Eq (Atom (Var v), (Atom (Const c) as rhs))) when Env.is_absent_key v env ->
      Env.extend_exn env v rhs
    | Eia (Eia.Eq (Add [ Atom (Var v1); Atom (Var v2) ], rhs)) ->
      single info env 1 v1 1 v2 rhs
    | Eia (Eia.Eq (Add [ Atom (Var v1); Mul [ Atom (Const c2); Atom (Var v2) ] ], rhs)) ->
      single info env 1 v1 c2 v2 rhs
    | Eia (Eia.Eq (Add [ Mul [ Atom (Const c1); Atom (Var v1) ]; Atom (Var v2) ], rhs)) ->
      single info env c1 v1 1 v2 rhs
    | Eia
        (Eia.Eq
           ( Add
               [ Mul [ Atom (Const c1); Atom (Var v1) ]
               ; Mul [ Atom (Const c2); Atom (Var v2) ]
               ]
           , rhs )) -> single info env c1 v1 c2 v2 rhs
    | x -> env
  in
  fun info env ast ->
    (* log "ast = %a\n%!" Ast.pp_smtlib2 ast; *)
      match ast with
      | Land xs -> List.fold_left (fun acc x -> helper info acc x) env xs
      | Eia _ -> helper info env ast
      | _ -> env
;;

let%expect_test _ =
  let (module TS) = make_main_symantics Env.empty in
  let test ?(env = [ "x"; "y"; "z" ]) ?(exp = []) ph =
    let info = Info.make ~all:env ~exp in
    let env2 = eq_propagation info Env.empty ph in
    Format.printf "@[%a@]\n%!" Env.pp env2
  in
  test TS.(add [ mul [ const 1; var "x" ]; mul [ const 2; var "y" ] ] = var "z");
  [%expect "x -> (+ z (* (- 2) y));"];
  test TS.(add [ var "x"; mul [ const 2; var "y" ] ] = mul [ var "z"; var "z" ]);
  [%expect "x -> (+ (* z z) (* (- 2) y));"];
  test ~exp:[ "x" ] TS.(add [ var "x"; var "y" ] = mul [ var "z"; var "z" ]);
  [%expect "y -> (+ (* z z) (* (- 1) x));"];
  ()
;;

exception Underapprox_fired
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

let basic_simplify step (env : Env.t) ast =
  let rec loop step (env : Env.t) ast =
    log "iter(%a)= @[%a@]" pp_step step Ast.pp_smtlib2 ast;
    let (module Symantics) = make_main_symantics env in
    let rez = apply_symantics (module Symantics) ast in
    let ast2 = Symantics.prj rez in
    let var_info = apply_symantics (module Who_in_exponents) ast in
    let env2 = eq_propagation var_info env ast in
    match Env.length env2 > Env.length env, Stdlib.(ast2 = ast) with
    | true, other ->
      let () = log "Something ready to substitute: %a" Env.pp env2 in
      loop (next_step step) (Env.merge env2 env) ast2
    | false, false -> loop (next_step step) env ast2
    | false, true ->
      (match ast2 with
       | Ast.True -> raise (Sat "presimpl")
       | Ast.Lnot Ast.True -> raise Unsat
       | _ -> ast2, env, var_info, step)
  in
  try `Unknown (loop step env ast) with
  | Unsat -> `Unsat
  | Sat _ -> `Sat
;;

let simpl bound ast =
  let prepare_choices env var_info =
    let ( let* ) xs f = List.concat_map f xs in
    let choice1 = List.init bound Fun.id in
    Base.Set.Poly.fold
      ~f:(fun acc name ->
        let* v = choice1 in
        let* acc = acc in
        [ Env.extend_exn acc name (Ast.Eia.Atom (Const v)) ])
      ~init:[ env ]
      var_info.Info.exp
  in
  let on_env step env =
    let (module Symantics) = make_main_symantics env in
    let rez = apply_symantics (module Symantics) ast in
    match basic_simplify step env rez with
    | `Unsat -> `Unknown
    | `Sat -> raise Underapprox_fired
    | `Unknown (ast, env, _info, step) ->
      (match check_errors ast with
       | [] ->
         let ph = apply_symantics (make_smtml_symantics Utils.Map.empty) rez in
         let solver = Smtml.Z3_mappings.Solver.make ~logic:Smtml.Logic.LIA () in
         Smtml.Z3_mappings.Solver.reset solver;
         (match Smtml.Z3_mappings.Solver.check solver ~assumptions:[ ph ] with
          | `Sat -> raise Underapprox_fired
          | `Unsat | `Unknown -> `Unknown)
       | _ -> `Errors)
  in
  let loop (env : Env.t) ast =
    match basic_simplify [ 1 ] env ast with
    | `Unsat -> raise Unsat
    | `Sat -> raise (Sat "")
    | `Unknown (ast, _, _, _) when bound <= 0 -> ast
    (* | `Error (ast, errs, var_info, step) ->
      let _ = log "Basic simplify finished after step %a.\n" pp_step step in
      let _ = log "ast = @[%a@]\n%!" Ast.pp_smtlib2 ast in
      let all_choices = prepare_choices env var_info in
      log "There are %d choices" (List.length all_choices);
      List.iteri (fun i -> on_env (i :: step)) all_choices;
      raise (Error (ast, errs)) *)
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
      if List.for_all is_error verdicts
      then (
        match check_errors ast with
        | [] ->
          Printf.eprintf "Something weird: no errors. %s %d\n%!" __FILE__ __LINE__;
          raise (Error (ast, []))
        | errors -> raise (Error (ast, errors)));
      ast
  in
  try
    let ast = loop Env.empty ast in
    match check_errors ast with
    | [] -> `Unknown ast
    | errrs -> `Error (ast, Base.List.dedup_and_sort ~compare:Stdlib.compare errrs)
  with
  | Unsat -> `Unsat
  | Underapprox_fired -> `Sat "underappox"
  | Sat reason -> `Sat reason
  | Error (ast, errs) -> `Error (ast, errs)
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
  [%expect "\n rest ast: (= (* 5 x) 50)\n env:\n "];
  wrap
    Main_symantics.(
      land_
        [ eq (mul [ const 5; var "x" ]) (const 50)
        ; eq (mul [ const 3; var "y" ]) (const 60)
        ; leq (mul [ const 5; var "z" ]) (const 50)
        ]);
  [%expect
    "\n rest ast: (and\n             (<= (* 5 z) 50))\n env:       x -> 10; y -> 20;\n "]
;;
