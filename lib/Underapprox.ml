module type SYM0 = sig
  type term
  type ph

  include FT_SIG.s_term with type term := term
  include FT_SIG.s_ph with type ph := ph and type term := term
  include FT_SIG.s_extra with type ph := ph and type term := term

  val pow2var : string -> term
  val exists : string list -> ph -> ph
end

module type SYM = sig
  include SYM0

  type repr

  val prj : ph -> repr
end

type env = (string, int) Base.Map.Poly.t

let pp_env ppf env =
  Format.fprintf ppf "@[{|";
  Base.Map.Poly.iteri env ~f:(fun ~key ~data ->
    Format.fprintf ppf "@ @[%s->%d@]@," key data);
  Format.fprintf ppf " |}@]"
;;

let make_sym (env : env) onvar bound =
  let module M = struct
    include Overapprox.Symantics

    type ph = term
    type repr = term

    let var s =
      match Base.Map.Poly.find env s with
      | None -> Smtml.Expr.symbol (Smtml.Symbol.make Smtml.Ty.Ty_int s)
      | Some c -> const c
    ;;

    let pow2var s = pow (const 2) (var s)
    let prj = Fun.id

    let exists vars x =
      let vars = List.filter (fun s -> Stdlib.not (Base.Map.Poly.mem env s)) vars in
      match vars with
      | [] -> x
      | _ -> Smtml.Expr.exists (List.map var vars) x
    ;;

    let leq l r =
      let open Smtml in
      (* Format.printf
        "Called %s with l = %a and r = %a\n%!"
        __FUNCTION__
        Smtml.Expr.pp
        l
        Smtml.Expr.pp
        r; *)
      Expr.relop Ty.Ty_int Ty.Relop.Le l r
    ;;
  end
  in
  (module struct
    include M
    include FT_SIG.Sugar (M)
  end : SYM
    with type repr = Smtml.Expr.t)
;;

let make_collector () =
  let module M = struct
    type term = string list
    type ph = term
    type repr = ph

    let ( ++ ) = List.append
    let empty = []
    let const _ = empty
    let var _ = empty
    let mul = List.fold_left ( ++ ) []
    let add = List.fold_left ( ++ ) []
    let bw _ = ( ++ )
    let pow = ( ++ )
    let true_ = empty
    let false_ = empty

    (* phormulas  *)
    let not = Fun.id
    let lor_ = List.fold_left ( ++ ) []
    let land_ = List.fold_left ( ++ ) []
    let eq = ( ++ )
    let lt = ( ++ )
    let leq = ( ++ )
    let prj xs = Base.List.dedup_and_sort xs ~compare:String.compare
    let pow2var x = [ x ]
    let exists vs ivars = List.filter (fun n -> not (List.mem n vs)) ivars
  end
  in
  (module struct
    include M
    include FT_SIG.Sugar (M)
  end : SYM
    with type repr = string list)
;;

exception Bitwise_op
exception String_op

let apply_symnatics (type a) (module S : SYM with type repr = a) =
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
    | Str _ -> raise String_op
  and helperT = function
    | Ast.Eia.Atom (Ast.Const n) -> S.const n
    | Atom (Ast.Var s) -> S.var s
    | Add terms -> S.add (List.map helperT terms)
    | Mul terms -> S.mul (List.map helperT terms)
    | Pow (Atom (Ast.Const 2), Atom (Ast.Var x)) -> S.pow2var x
    | Pow (base, p) -> S.pow (helperT base) (helperT p)
    | Bwand _ | Bwor _ | Bwxor _ -> raise Bitwise_op
    | Len _ | Stoi _ -> raise String_op
  and helper_eia eia =
    match eia with
    | Ast.Eia.Eq (l, r) -> S.(helperT l = helperT r)
    | Leq (l, r) -> S.(helperT l <= helperT r)
  in
  fun x -> S.prj (helper x)
;;

let log = Debug.printfln

let check bound ast =
  try
    let vars = ref (Base.Set.empty (module Base.String)) in
    let interestring_vars = apply_symnatics (make_collector ()) ast in
    (* TODO: collecting of interesting variables could be buggy. For example, what if
      (exists (x) (...) (exists (x) (= (exp 2 x) 128)))
    ??
    *)
    log "Interesting: %s\n" (String.concat " " interestring_vars);
    log
      "Expecting %d choices ...\n%!"
      (Utils.pow ~base:bound (List.length interestring_vars));
    let all_choices =
      let ( let* ) xs f = List.concat_map f xs in
      let choice1 = List.init (bound + 1) Fun.id in
      List.fold_left
        (fun acc name ->
           let* v = choice1 in
           let* acc = acc in
           [ Base.Map.Poly.add_exn acc ~key:name ~data:v ])
        [ Base.Map.Poly.empty ]
        interestring_vars
    in
    let exception Early of env in
    try
      List.iteri
        (fun i env ->
           let ((module S : SYM with type repr = Smtml.Expr.t) as sym) =
             make_sym env (fun s -> vars := Base.Set.add !vars s) bound
           in
           let ph = apply_symnatics sym ast in
           let solver = Smtml.Z3_mappings.Solver.make () in
           Smtml.Z3_mappings.Solver.reset solver;
           let __ () = log "Into Z3 goes: @[%a@]\n%!" Smtml.Expr.pp ph in
           match Smtml.Z3_mappings.Solver.check solver ~assumptions:[ ph ] with
           | `Sat -> raise (Early env)
           | _ -> ())
        all_choices;
      (* TODO: if all Unsat, add a constraints (x>bound), becuase we have already checked values in [0.. bound] *)
      let newast =
        let vars = Base.Set.to_list !vars in
        let b = Ast.Eia.Atom (Ast.Const bound) in
        let extend = fun v -> Ast.eia (Ast.Eia.lt b (Ast.Eia.atom (Ast.var v))) in
        Ast.land_ (ast :: List.map extend vars)
      in
      log "Can't decide in %s" __FILE__;
      `Unknown newast
    with
    | Early env ->
      log "%s gives early Sat." __FILE__;
      log "env = %a" pp_env env;
      `Sat "underapprox1"
  with
  | Bitwise_op -> `Unknown ast
;;
