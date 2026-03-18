module Map = Base.Map.Poly

let internalc = ref 0

let internal_name () =
  let r = String.concat "" [ "$"; !internalc |> Int.to_string ] in
  internalc := !internalc + 1;
  r
;;

let pred_to_sym s = Smtml.Expr.symbol (Smtml.Symbol.make Smtml.Ty.Ty_bool s)

let sym_to_pred (s : Smtml.Symbol.t) =
  match s with
  | { ty = Smtml.Ty.Ty_bool; name = Simple s; _ } -> s
  | _ -> assert false
;;

let rec to_smtml = function
  | Ast.True -> Smtml.Expr.Bool.true_
  | Land [] -> Smtml.Expr.Bool.true_
  | Land (h :: tl) ->
    let h = to_smtml h in
    let tl = List.map to_smtml tl in
    List.fold_left Smtml.Expr.Bool.and_ h tl
  | Lor [] -> Smtml.Expr.Bool.false_
  | Lor (h :: tl) ->
    let h = to_smtml h in
    let tl = List.map to_smtml tl in
    List.fold_left Smtml.Expr.Bool.or_ h tl
  | Lnot el -> Smtml.Expr.Bool.not (to_smtml el)
  | Exists _ -> failwith "??"
  | Pred s -> pred_to_sym s
  | Unsupp _ -> failwith "???"
  | Eia eia -> assert false
;;

let failf = Format.kasprintf failwith

let dpll (f : Ast.t -> [ `Sat of 'a | `Unsat of Ast.t option | `Unknown ]) ast
  : [ `Sat of 'a | `Unsat of Ast.t | `Unknown ]
  =
  let eia_to_pred = ref Map.empty in
  let pred_to_eia = ref Map.empty in
  let eia_to_pred eia =
    match Map.find !eia_to_pred eia with
    | Some s -> s
    | None ->
      let s = internal_name () in
      eia_to_pred := Map.add_exn !eia_to_pred ~key:eia ~data:s;
      pred_to_eia := Map.add_exn !pred_to_eia ~key:s ~data:eia;
      s
  in
  let pred_to_eia s =
    match Map.find !pred_to_eia s with
    | Some eia -> eia
    | None -> failf "unexpected state: predicate %s is in the original definition" s
  in
  let smt_to_sat =
    Ast.map (function
      | (Ast.True | Land _ | Lnot _ | Lor _ | Exists _ | Pred _ | Unsupp _) as ast -> ast
      | Eia eia -> Ast.pred (eia_to_pred eia))
  in
  let module Z3 = Smtml.Z3_mappings.Solver in
  let solver =
    Z3.make ~params:Smtml.Params.(default () $ (Timeout, 60) $ (Random_seed, 42)) ()
  in
  let rec aux smt_ast solver =
    Debug.printf
      "dpll: current Z3 statistics: %a\n"
      Smtml.Statistics.pp
      (Z3.get_statistics solver);
    match Z3.check solver ~assumptions:[] with
    | `Sat -> begin
      (* TODO: handle no model, however SAT problem w/o model is kind of strange. *)
      let z3_model = Z3.model solver |> Option.get |> Smtml.Z3_mappings.values_of_model in
      let candidate =
        Hashtbl.fold
          (fun sym value acc ->
             match value with
             | Smtml.Value.True -> Ast.eia (pred_to_eia (sym_to_pred sym)) :: acc
             | Smtml.Value.False ->
               Ast.lnot (Ast.eia (pred_to_eia (sym_to_pred sym))) :: acc
             | _ -> assert false)
          z3_model
          []
        |> Ast.land_
      in
      match f candidate with
      | `Sat extra -> `Sat extra
      | `Unsat unsat_core ->
        let unsat_core = Option.value unsat_core ~default:candidate in
        let unsat_core_contra_sat_ast = Ast.lnot unsat_core |> smt_to_sat in
        Debug.printf
          "dpll: into z3 added: %a\n%!"
          Ast.pp_smtlib2
          unsat_core_contra_sat_ast;
        Z3.add solver [ unsat_core_contra_sat_ast |> to_smtml ];
        aux smt_ast solver
      | `Unknown -> failwith "todo"
    end
    | `Unsat -> `Unsat Ast.true_ (* todo *)
    | `Unknown -> `Unknown (* ??? *)
  in
  let sat_ast = smt_to_sat ast in
  Debug.printf "dpll: smt ast: %a\n%!" Ast.pp_smtlib2 ast;
  Debug.printf "dpll: sat ast: %a\n%!" Ast.pp_smtlib2 sat_ast;
  Z3.add solver [ sat_ast |> to_smtml ];
  aux ast solver
;;
