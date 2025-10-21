[@@@warning "-unused-value-declaration"]
[@@@warnerror "-unused-open"]
[@@@warnerror "-unused-var"]

module Map = Base.Map.Poly
module Set = Base.Set.Poly

let log = Utils.log

let collect_free =
  Ast.fold
    (fun acc -> function
       | Ast.Eia eia ->
         Ast.Eia.fold2
           (fun acc _ -> acc)
           (fun acc -> function
              | Ast.Eia.Atom (Ast.Var v) -> Set.add acc (Ast.var v)
              | Ast.Eia.Iofs str ->
                Ast.Eia.fold_term
                  (fun acc -> function
                     | Ast.Eia.Atom (Ast.Var v) -> Set.add acc (Ast.var v)
                     | _ -> acc)
                  acc
                  str
              | Ast.Eia.Len str ->
                Ast.Eia.fold_term
                  (fun acc -> function
                     | Ast.Eia.Atom (Ast.Var v) -> Set.add acc (Ast.var v)
                     | _ -> acc)
                  acc
                  str
              | _ -> acc)
           acc
           eia
       | Ast.Str str ->
         Ast.Str.fold2
           (fun acc _ -> acc)
           (fun acc -> function
              | Ast.Eia.Atom (Ast.Var v) -> Set.add acc (Ast.var v)
              | _ -> acc)
           acc
           str
       | Ast.Exists (xs, _) -> Set.diff acc (Set.of_list xs)
       | _ -> acc)
    Set.empty
;;

(*let of_eia (eia : Ast.Eia.t) =
  let open Z in
  let open Z.Compare in
  (* log "%s: %a" __FUNCTION__ Ast.Eia.pp eia; *)
  let rec as_poly term =
    match of_term term with
    | `Poly (poly, c, sups) -> poly, c, sups
    | `Symbol (symbol, sups) -> Map.singleton symbol one, zero, sups
  and as_symbol term =
    match of_term term with
    | `Poly (poly, c, sups) ->
      let var = Ir.internal () in
      let sup = Ir.eq (Map.add_exn ~key:var ~data:(-one) poly) (-c) in
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
        if Int.equal (Map.length base_poly) 0 && Int.equal base_c 2
        then begin
          match exp_symbol with
          | Var v -> Map.singleton (Ir.pow2 v) one
          | _ -> failwith "unreachable"
        end
        else
          failwith
            (Printf.sprintf "only base 2 is supported in exponents (got %d)" base_c)
      in
      let sups = base_sups @ exp_sups in
      `Poly (poly, zero, sups)
    | Mul [ lhs; rhs ] ->
      let poly, c, sups = as_poly lhs in
      let poly', c', sups' = as_poly rhs in
      let poly, c, d =
        if Int.equal (Map.length poly') 0
        then poly, c, c'
        else if Int.equal (Map.length poly) 0
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
;;*)

type bound = EqConst of Ast.atom * Z.t

let algebraic : Ast.t -> Ast.t =
  let open Z in
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
               ; Ast.Eia.Mul [ Ast.Eia.Atom (Ast.Const minus_one); Ast.Eia.Atom v ]
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
      | Ast.Eia.Add [] -> Ast.Eia.atom (Ast.const zero)
      | Ast.Eia.Mul [] -> Ast.Eia.atom (Ast.const one)
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
                 let c = List.fold_left ( * ) one cs in
                 if c = zero
                 then Ast.Eia.Atom (Ast.const zero)
                 else if c = one
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
                 let c = List.fold_left ( + ) zero cs in
                 if c = zero
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

let run_simplify (ir : Ast.t) : Ast.t =
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
    Debug.printf "Simplify step: %a\n%!" Ast.pp ir';
    if Ast.equal ir' ir then ir' else simpl ir'
  in
  simpl ir
  |> fun x ->
  Debug.printf "Simplified expression: %a\n" Ast.pp_smtlib2 x;
  x
;;
