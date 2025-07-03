module Map = Base.Map.Poly
module Set = Base.Set.Poly

let failf fmt = Format.kasprintf failwith fmt

let collect_free (ir : Ast.t) =
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
    ir
;;

let of_eia (eia : Ast.Eia.t) =
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
  and of_term (term : Ast.Eia.term) =
    match term with
    | Atom v -> begin
      match v with
      | Var v -> `Symbol (Ir.var v, [])
      | Const c -> `Poly (Map.empty, c, [])
    end
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
          | Var v | Internal v -> Map.singleton (Ir.pow2 v) 1
          | _ -> failwith "unreachable"
        end
        else failwith "only base 2 is supported in exponents"
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
    | _ -> failf "unimplemented %a" Ast.Eia.pp eia
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
  let quantifiers_closer : Ast.t -> Ast.t =
    Ast.map (function
      | Ast.Exists ([], ir) -> ir
      | Ast.Exists (atoms, Ast.Exists (atoms', ir)) -> Ast.exists (atoms @ atoms') ir
      | Ast.Exists (atoms, (Ast.Land irs as ir'))
      | Ast.Exists (atoms, (Ast.Lor irs as ir')) ->
        let op =
          match ir' with
          | Ast.Land _ -> Ast.land_
          | Ast.Lor _ -> Ast.lor_
          | _ -> assert false
        in
        let atoms_set = atoms |> Set.of_list in
        let irs_using_var =
          List.mapi
            begin
              fun i ir ->
                let free_vars = collect_free ir in
                let used_vars = Set.inter atoms_set free_vars in
                i, used_vars
            end
            irs
        in
        let var_is_used_in =
          List.map
            begin
              fun atom ->
                ( atom
                , List.filter_map
                    (fun (i, s) -> if Set.mem s atom then Some i else None)
                    irs_using_var )
            end
            atoms
          |> Map.of_alist_exn
        in
        let atoms, irs =
          Map.fold
            ~f:
              begin
                fun ~key:atom ~data:used_in (atoms, irs) ->
                  match used_in with
                  | [] -> atoms, irs
                  | [ i ] ->
                    ( atoms
                    , List.mapi
                        (fun j ir -> if i = j then Ast.exists [ atom ] ir else ir)
                        irs )
                  | _ -> atom :: atoms, irs
              end
            ~init:([], irs)
            var_is_used_in
        in
        Ast.exists atoms (op irs)
      | ir -> ir)
  in
  let rec simpl ir =
    let ir' = ir |> simpl_negation |> fold_ops |> quantifiers_closer |> algebraic in
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
    | Eia eia -> of_eia eia
    | Pred s -> failf "Unexpected %s" s
  in
  simpl_ir ir |> ir_of_ast
;;
