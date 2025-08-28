(** Middle-end *)

module Map = Base.Map.Poly
module Set = Base.Set.Poly

let log = Utils.log
let failf fmt = Format.kasprintf failwith fmt

let collect_free =
  Ast.fold
    (fun acc -> function
       | Ast.Eia eia ->
         Ast.Eia.fold2
           (fun acc _ -> acc)
           (fun acc -> function
              | Ast.Eia.Atom (Ast.Var v) -> Set.union acc (Set.singleton (Ast.var v))
              | _ -> acc)
           acc
           eia
       | Ast.Exists (xs, _) -> Set.diff acc (Set.of_list xs)
       | _ -> acc)
    Set.empty
;;

(** Final-tagless style for building our representation  *)
module type S = sig
  type t
  type repr

  val symbol : string -> t
  val poly_of_const : int -> t
  val minus : t -> t -> t
  val add : t -> t -> t
  val mul : t -> t -> t
  val bwop : FT_SIG.sup_binop -> t -> t -> t
  val pow : base:t -> t -> t
  val prj : t -> repr
end

[@@@warnerror "-32-37-39"]

module Symantics : S with type repr = (Ir.atom, int) Map.t * int * Ir.t list = struct
  type repr = (Ir.atom, int) Map.t * int * Ir.t list

  type t =
    | Poly of (Ir.atom, Q.t) Map.t * int * Ir.t list
    | Symbol of Ir.atom * Ir.t list

  let pp ppf =
    let open Format in
    function
    | Poly _ -> fprintf ppf "Poly"
    | Symbol (a, _) -> fprintf ppf "Symbol (%a,_)" Ir.pp_atom a
  ;;

  let as_poly = function
    | Poly (poly, c, sups) as x -> x
    | Symbol (symbol, sups) -> Poly (Map.singleton symbol Q.one, 0, sups)
  ;;

  let from_rat : (Ir.atom, Q.t) Map.t -> int -> (Ir.atom, int) Map.t * int =
    fun mapa c ->
    let lcmz = Map.fold mapa ~init:Z.one ~f:(fun ~key:_ ~data -> Z.lcm (Q.den data)) in
    let mapa = Map.map mapa ~f:(fun q -> Z.(lcmz / Q.den q * Q.num q |> to_int)) in
    let c = c * Z.to_int lcmz in
    mapa, c
  ;;

  let as_symbol = function
    | Poly (poly, c, sups) ->
      let var = Ir.internal () in
      let poly, c = from_rat poly c in
      let sup = Ir.eq (Map.add_exn ~key:var ~data:(-1) poly) (-c) in
      Symbol (var, sup :: sups)
    | Symbol _ as s -> s
  ;;

  let prj = function
    | Poly (mapa, c, sups) ->
      let mapa, c = from_rat mapa c in
      mapa, c, sups
    | Symbol (symbol, sups) -> Map.singleton symbol 1, 0, sups
  ;;

  let symbol s = Symbol (Ir.var s, [])
  let poly_of_const c = Poly (Map.empty, c, [])

  let rec bwop : FT_SIG.sup_binop -> t -> t -> t =
    fun op l r ->
    match l, r with
    | Symbol (lhs, sups), Symbol (rhs, sups2) ->
      let regex =
        match op with
        | Bwand -> Regex.bwand
        | Bwor -> Regex.bwor
        | Bwxor -> Regex.bwxor
      in
      let var = Ir.internal () in
      let sup = Ir.reg regex [ var; lhs; rhs ] in
      let sups = sups @ sups2 in
      Symbol (var, sup :: sups)
    | Poly _, _ -> bwop op (as_symbol l) r
    | _, Poly _ -> bwop op l (as_symbol r)
  ;;

  let rec minus l r =
    match l, r with
    | (Symbol _ as s), (Poly _ as p) -> minus (as_poly s) p
    | (Poly _ as p), (Symbol _ as s) -> minus p (as_poly s)
    | Poly (poly, c, sups), Poly (poly', c', sups') ->
      let poly =
        Map.merge poly poly' ~f:(fun ~key:_ vs ->
          match vs with
          | `Left a -> Some a
          | `Right a -> Some Q.(zero - a)
          | `Both (a, b) -> Some Q.(a - b))
      in
      let c = c' - c in
      let sups = sups @ sups' in
      Poly (poly, c, sups)
    | Symbol (_, _), Symbol (_, _) -> minus (as_poly l) (as_poly r)
  ;;

  let rec add l r =
    match l, r with
    | (Poly _ as p), (Symbol _ as s) | (Symbol _ as s), (Poly _ as p) -> add p (as_poly s)
    | Poly (poly, c, sups), Poly (poly', c', sups') ->
      let poly =
        Map.merge poly poly' ~f:(fun ~key:_ vs ->
          match vs with
          | `Left a | `Right a -> Some a
          | `Both (a, b) -> Some Q.(a + b))
      in
      let c = c' + c in
      let sups = sups @ sups' in
      Poly (poly, c, sups)
    | Symbol (l, sup1), Symbol (r, sup2) ->
      if Ir.eq_atom l r
      then Poly (Map.singleton l (Q.of_int 2), 0, sup1 @ sup2)
      else Poly (Map.add_exn ~key:r ~data:Q.one (Map.singleton l Q.one), 0, sup1 @ sup2)
  ;;

  let rec mul l r =
    match l, r with
    | (Poly _ as p), (Symbol _ as s) | (Symbol _ as s), (Poly _ as p) -> mul p (as_poly s)
    | Poly (poly, c, sups), Poly (poly', c', sups') ->
      let poly, c, d =
        if Map.length poly' = 0
        then poly, c, c'
        else if Map.length poly = 0
        then poly', c', c
        else failwith "unable to multiply var by var"
      in
      let poly = poly |> Map.map ~f:Q.(fun a -> a * Q.of_int d) in
      let c = c * d in
      let sups = sups @ sups' in
      Poly (poly, c, sups)
    | _ -> failf "not implemented: %s. l = %a, r = %a" __FUNCTION__ pp l pp r
  ;;

  let rec pow ~base exp =
    match base, exp with
    | Poly (base_poly, 4, base_sups), _ when Map.is_empty base_poly ->
      pow ~base:(Poly (base_poly, 2, base_sups)) (mul (poly_of_const 2) exp)
    | Poly (base_poly, 2, base_sups), Poly (exp_map, exp_c, exp_sups)
      when Map.is_empty base_poly ->
      let merged_sups = base_sups @ exp_sups in
      (match Map.length exp_map with
       | 0 -> Poly (base_poly, Utils.pow ~base:2 exp_c, base_sups @ exp_sups)
       | 1 ->
         let coeff =
           if exp_c > 0
           then Q.of_int (Utils.pow ~base:2 exp_c)
           else (
             let c = Utils.pow ~base:2 (-exp_c) in
             Q.(one / of_int c))
         in
         let merged_sups, var =
           match fst (Map.min_elt_exn exp_map) with
           | Var s -> merged_sups, Ir.pow2 s
           | Pow2 s when exp_c = 0 ->
             let newv : string = Ir.internal_name () in
             ( Ir.eq (Map.of_alist_exn [ Ir.Var newv, -1; Pow2 s, 1 ]) 0 :: merged_sups
             , Ir.pow2 newv )
           | x -> failf "not implemented: %a\n%!" Ir.pp_atom x
         in
         Poly (Map.singleton var coeff, 0, merged_sups)
       | _ ->
         let var = Ir.internal () in
         let coeff =
           if exp_c > 0
           then Q.of_int (Utils.pow ~base:2 exp_c)
           else (
             let c = Utils.pow ~base:2 (-exp_c) in
             Q.(one / of_int c))
         in
         let sup1 =
           let mapa, c = from_rat (Map.add_exn ~key:var ~data:Q.(zero - one) exp_map) 0 in
           Ir.eq mapa c
         in
         (* Debug.printfln "new variable %a for " Ir.pp_atom var; *)
         Poly (Map.singleton var coeff, 0, (sup1 :: base_sups) @ exp_sups))
    | Poly (base_poly, 2, base_sups), Symbol (exp_symbol, exp_sups)
      when Map.length base_poly = 0 ->
      let poly =
        match exp_symbol with
        | Var v -> Map.singleton (Ir.pow2 v) Q.one
        | _ -> failwith "unreachable"
      in
      let sups = base_sups @ exp_sups in
      Poly (poly, 0, sups)
    | Symbol (a, _), _ ->
      failwith
        (Format.asprintf "only base 2 is supported in exponents (got %a)" Ir.pp_atom a)
    | Poly (base_poly, base_c, base_sups), _ ->
      failwith (Printf.sprintf "only base 2 is supported in exponents (got %d)" base_c)
  ;;
end

let of_eia2 : Ast.Eia.t -> Ir.t =
  fun eia ->
  (* log "%s: %a" __FUNCTION__ Ast.Eia.pp eia; *)
  let rec helper = function
    | Ast.Eia.Atom (Var v) -> Symantics.symbol v
    | Atom (Const c) -> Symantics.poly_of_const c
    | Add (hd :: tl) ->
      List.fold_left (fun acc x -> Symantics.add acc (helper x)) (helper hd) tl
    | Mul [ lhs; rhs ] -> Symantics.mul (helper lhs) (helper rhs)
    | Pow (base, exp) -> Symantics.pow ~base:(helper base) (helper exp)
    | (Bwand (lhs, rhs) | Bwor (lhs, rhs) | Bwxor (lhs, rhs)) as eia ->
      let lhs = helper lhs in
      let rhs = helper rhs in
      let regex =
        match eia with
        | Bwand _ -> Symantics.bwop Bwand
        | Bwor _ -> Symantics.bwop Bwor
        | Bwxor _ -> Symantics.bwop Bwxor
        | _ -> failwith "unreachable"
      in
      regex lhs rhs
    | other ->
      (* Format.eprintf "%s fails on '%a'\n%!" __FUNCTION__ Ast.Eia.pp_term other; *)
      failf "unimplemented %a" Ast.Eia.pp eia
  in
  match eia with
  | Eq (lhs, rhs) | Leq (lhs, rhs) ->
    let poly, c, sups = Symantics.prj (Symantics.minus (helper lhs) (helper rhs)) in
    let build =
      match eia with
      | Eq _ -> Ir.eq
      | Leq _ -> Ir.leq
    in
    let ans = Ir.land_ (build poly c :: sups) in
    (* log "%a ~~> %a" Ast.Eia.pp eia Ir.pp ans; *)
    ans
;;

let of_eia (eia : Ast.Eia.t) =
  (* log "%s: %a" __FUNCTION__ Ast.Eia.pp eia; *)
  let rec as_poly term =
    match of_term term with
    | `Poly (poly, c, sups) -> poly, c, sups
    | `Symbol (symbol, sups) -> Map.singleton symbol 1, 0, sups
  and as_symbol term =
    match of_term term with
    | `Poly (poly, c, sups) ->
      let var = Ir.internal () in
      let sup = Ir.eq (Map.add_exn ~key:var ~data:(-1) poly) (-c) in
      var, sup :: sups
    | `Symbol (symbol, sups) -> symbol, sups
  and of_term : Ast.Eia.term -> _ = function
    | Atom (Var v) -> `Symbol (Ir.var v, [])
    | Atom (Const c) -> `Poly (Map.empty, c, [])
    | Add (hd :: tl) ->
      let hd = hd |> as_poly in
      let tl = List.map as_poly tl in
      let poly, c, sups =
        List.fold_left
          (fun (v, c, sups) (v', c', sups') ->
             let v =
               Map.merge
                 ~f:(fun ~key:_ vs ->
                   match vs with
                   | `Left a | `Right a -> Some a
                   | `Both (a, b) -> Some (a + b))
                 v
                 v'
             in
             let c = c + c' in
             let sups = sups @ sups' in
             v, c, sups)
          hd
          tl
      in
      `Poly (poly, c, sups)
    | (Bwand (lhs, rhs) | Bwor (lhs, rhs) | Bwxor (lhs, rhs)) as eia ->
      let lhs, sups = as_symbol lhs in
      let rhs, sups' = as_symbol rhs in
      let regex =
        match eia with
        | Bwand _ -> Regex.bwand
        | Bwor _ -> Regex.bwor
        | Bwxor _ -> Regex.bwxor
        | _ -> failwith "unreachable"
      in
      let var = Ir.internal () in
      let sup = Ir.reg regex [ var; lhs; rhs ] in
      let sups = sups @ sups' in
      `Symbol (var, sup :: sups)
    | Pow (base, exp) ->
      let base_poly, base_c, base_sups = as_poly base in
      let exp_symbol, exp_sups = as_symbol exp in
      let poly =
        if Map.length base_poly = 0 && base_c = 2
        then begin
          match exp_symbol with
          | Var v -> Map.singleton (Ir.pow2 v) 1
          | _ -> failwith "unreachable"
        end
        else
          failwith
            (Printf.sprintf "only base 2 is supported in exponents (got %d)" base_c)
      in
      let sups = base_sups @ exp_sups in
      `Poly (poly, 0, sups)
    | Mul [ lhs; rhs ] ->
      let poly, c, sups = as_poly lhs in
      let poly', c', sups' = as_poly rhs in
      let poly, c, d =
        if Map.length poly' = 0
        then poly, c, c'
        else if Map.length poly = 0
        then poly', c', c
        else failwith "unable to multiply var by var"
      in
      let poly = poly |> Map.map ~f:(fun a -> a * d) in
      let c = c * d in
      let sups = sups @ sups' in
      `Poly (poly, c, sups)
    | other ->
      Format.eprintf "%s fails on '%a'\n%!" __FUNCTION__ Ast.Eia.pp_term other;
      failf "unimplemented: %a" Ast.Eia.pp eia
  in
  match eia with
  | Eq (lhs, rhs) | Leq (lhs, rhs) ->
    let poly, c, sups = as_poly lhs in
    let poly', c', sups' = as_poly rhs in
    let poly =
      Map.merge poly poly' ~f:(fun ~key:_ vs ->
        match vs with
        | `Left a -> Some a
        | `Right a -> Some (-a)
        | `Both (a, b) -> Some (a - b))
    in
    let c = c' - c in
    let sups = sups @ sups' in
    let build =
      match eia with
      | Eq _ -> Ir.eq
      | Leq _ -> Ir.leq
    in
    Ir.land_ (build poly c :: sups)
;;

type bound = EqConst of Ast.atom * int

let algebraic : Ast.t -> Ast.t =
  let rec infer_bounds : Ast.t -> _ = function
    | Ast.Land irs ->
      let bounds = List.map infer_bounds irs in
      Set.union_list bounds
    | Ast.Lor irs ->
      let bounds = List.map infer_bounds irs in
      begin
        match bounds with
        | hd :: tl -> List.fold_left Set.inter hd tl
        | _ -> Set.empty
      end
    | True -> Set.empty
    | Eia (Ast.Eia.Eq (Ast.Eia.Atom v, Ast.Eia.Atom (Ast.Const c))) ->
      let bound = EqConst (v, c) in
      Set.singleton bound
    | Eia
        (Ast.Eia.Eq
           ( Ast.Eia.Add [ Ast.Eia.Atom (Ast.Const d); Ast.Eia.Atom v ]
           , Ast.Eia.Atom (Ast.Const c) )) ->
      let bound = EqConst (v, c - d) in
      Set.singleton bound
    | Eia
        (Ast.Eia.Eq
           ( Ast.Eia.Add
               [ Ast.Eia.Atom (Ast.Const d)
               ; Ast.Eia.Mul [ Ast.Eia.Atom (Ast.Const -1); Ast.Eia.Atom v ]
               ]
           , Ast.Eia.Atom (Ast.Const c) )) ->
      let bound = EqConst (v, d - c) in
      Set.singleton bound
    | _ -> Set.empty
  in
  let mapt f =
    Ast.map (function
      | Ast.Eia eia -> Ast.eia (Ast.Eia.map2 Fun.id f eia)
      | ir -> ir)
  in
  let apply_bounds bounds : Ast.t -> Ast.t =
    let bounded_atoms =
      bounds
      |> Set.to_list
      |> List.map (fun (EqConst (atom, c)) -> atom, c)
      |> Map.of_alist_reduce ~f:(fun v1 _v2 -> v1)
    in
    Ast.map (function
      | Ast.Eia eia as ast when Set.length (collect_free ast) > 1 ->
        Ast.eia
          (Ast.Eia.map2
             Fun.id
             (function
               | Ast.Eia.Atom v as term -> begin
                 match Map.find bounded_atoms v with
                 | Some bind -> Ast.Eia.atom (Ast.const bind)
                 | None -> term
               end
               | term -> term)
             eia)
      | ir -> ir)
  in
  let flatten =
    mapt (function
      | Ast.Eia.Add [] -> Ast.Eia.atom (Ast.const 0)
      | Ast.Eia.Mul [] -> Ast.Eia.atom (Ast.const 1)
      | Ast.Eia.Add [ term ] -> term
      | Ast.Eia.Mul [ term ] -> term
      | Ast.Eia.Add terms ->
        let flattened =
          List.map
            (function
              | Ast.Eia.Add terms' -> terms'
              | term -> [ term ])
            terms
          |> List.flatten
        in
        Ast.Eia.add flattened
      | Ast.Eia.Mul terms ->
        let flattened =
          List.map
            (function
              | Ast.Eia.Mul terms' -> terms'
              | term -> [ term ])
            terms
          |> List.flatten
        in
        Ast.Eia.mul flattened
      | term -> term)
  in
  let constant_folding =
    Ast.map (function
      | Ast.Eia eia ->
        Ast.eia
          (Ast.Eia.map2
             Fun.id
             (function
               | Ast.Eia.Mul terms ->
                 let terms, cs =
                   List.partition_map
                     (function
                       | Ast.Eia.Atom (Ast.Const c') -> Either.right c'
                       | term -> Either.left term)
                     terms
                 in
                 let c = List.fold_left Int.mul 1 cs in
                 if c = 0
                 then Ast.Eia.Atom (Ast.const 0)
                 else if c = 1
                 then Ast.Eia.mul terms
                 else Ast.Eia.mul (Ast.Eia.atom (Ast.const c) :: terms)
               | Ast.Eia.Add terms ->
                 let terms, cs =
                   List.partition_map
                     (function
                       | Ast.Eia.Atom (Ast.Const c') -> Either.right c'
                       | term -> Either.left term)
                     terms
                 in
                 let c = List.fold_left ( + ) 0 cs in
                 if c = 0
                 then Ast.Eia.add terms
                 else Ast.Eia.add (Ast.Eia.atom (Ast.const c) :: terms)
               | term -> term)
             eia)
      | ast -> ast)
  in
  let aux ast =
    ast
    |> flatten
    |> constant_folding
    |> Ast.map (fun ir ->
      let bounds = infer_bounds ir in
      apply_bounds bounds ir)
  in
  aux
;;

let simpl_ir (ir : Ast.t) : Ast.t =
  let simply =
    Ast.map (function
      | Ast.Land [] -> Ast.true_
      | Ast.Lor [] -> Ast.false_
      | Ast.Land [ ast ] -> ast
      | Ast.Lor [ ast ] -> ast
      | ast -> ast)
  in
  let simpl_negation =
    Ast.map (function
      | Ast.Lnot (Ast.Lnot ir) -> ir
      | Ast.Lnot (Ast.Lor irs) -> Ast.land_ (List.map Ast.lnot irs)
      | Ast.Lnot (Ast.Land irs) -> Ast.lor_ (List.map Ast.lnot irs)
      | ir -> ir)
  in
  let fold_ops =
    Ast.map (function
      | Ast.Land lst ->
        Ast.Land
          (lst
           |> List.concat_map (function
             | Ast.Land lst -> lst
             | ir -> [ ir ]))
      | Ast.Lor lst ->
        Ast.Lor
          (lst
           |> List.concat_map (function
             | Ast.Lor lst -> lst
             | ir -> [ ir ]))
      | ir -> ir)
  in
  let rec simpl ir =
    let ir' = ir |> simply |> simpl_negation |> fold_ops |> algebraic in
    Debug.printf "Simplify step: %a\n" Ast.pp ir';
    if Ast.equal ir' ir then ir' else simpl ir'
  in
  simpl ir
  |> fun x ->
  Debug.printf "Simplified expression: %a\n" Ast.pp x;
  x
;;

let ir_of_ast ir =
  let rec ir_of_ast (ast : Ast.t) =
    match ast with
    | True -> Ir.true_
    | Lnot ast -> Ir.lnot (ir_of_ast ast)
    | Land asts -> List.map ir_of_ast asts |> Ir.land_
    | Lor asts -> List.map ir_of_ast asts |> Ir.lor_
    | Exists (atoms, ast) ->
      let atoms =
        List.map
          (function
            | Ast.Var v -> Ir.var v
            | Const _ -> failwith "unreachable (I hope)")
          atoms
      in
      Ir.exists atoms (ir_of_ast ast)
    | Eia eia ->
      (match Sys.getenv_opt "CHRO_EIA" with
       | Some "old" -> of_eia
       | _ -> of_eia2)
        eia
    | Pred s -> failf "Unexpected %s" s
  in
  simpl_ir ir |> ir_of_ast
;;

let%expect_test _ =
  let open Ast in
  let wrap ast =
    Format.printf "@[%a@]\n%!" Ast.pp_smtlib2 (Eia ast);
    let ir1 = of_eia ast in
    Format.printf "@[IR1: %a@]\n%!" Ir.pp_smtlib2 ir1;
    let ir2 = of_eia2 ast in
    Format.printf "@[IR2: %a@]\n%!" Ir.pp_smtlib2 ir2
  in
  wrap
    (Ast.Eia.leq
       Eia.(pow (atom (const 2)) (Eia.pow (atom @@ const 2) (atom @@ var "z")))
       (Eia.atom (Const 1)));
  [%expect
    {|
    (<= (exp 2 (exp 2 z)) 1)
    IR1: (assert (<= pow2( %0)  1) )
         (assert (= (+ (* (- 1)  %0) pow2(z) )  0) )

    IR2: (assert (<= pow2( %1)  1) )
         (assert (= (+ (* (- 1)  %1) pow2(z) )  0) )
    |}]
;;
