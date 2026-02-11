module type SYM0 = sig
  type term
  type ph

  include FT_SIG.z_term with type term := term

  (* include FT_SIG.z_term with type term := term and  *)
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

(* TODO(Kakadu): Maybe it's time to use Z.t here  *)
type env = (string, int) Base.Map.Poly.t

let to_normal_env : env -> Env.t =
  Base.Map.Poly.fold ~init:Env.empty ~f:(fun ~key ~data acc ->
    let _ : Env.t = acc in
    let open Ast in
    Env.extend_exn acc (Var (key, I)) (Eia.Const (Z.of_int data)))
;;

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
      | Some c -> constz (Z.of_int c)
    ;;

    let pow2var s = pow (constz (Config.base ())) (var s)
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
    (* include FT_SIG.Sugar (M) *)
  end : SYM
    with type repr = Smtml.Expr.t)
;;

let make_collector () =
  let module M = struct
    type term = string list
    type str = term
    type ph = term
    type repr = term

    let ( ++ ) = List.append
    let empty = []

    [@@@warning "-32"]

    let str_const _ = empty
    let sofi _ = empty
    let iofs _ = empty
    let str_len _ = empty
    let str_var _ = empty
    let const _ = empty
    let constz _ = empty
    let var _ = empty
    let mul = List.fold_left ( ++ ) []
    let add = List.fold_left ( ++ ) []
    let bw _ = ( ++ )
    let pow = ( ++ )
    let mod_ x _ = x
    let true_ = empty
    let false_ = empty

    (* phormulas  *)
    let in_re _ _ = failwith __FILE__
    let not = Fun.id
    let lor_ = List.fold_left ( ++ ) []
    let land_ = List.fold_left ( ++ ) []
    let eqz = ( ++ )
    let neqz = ( ++ )
    let eq_str = ( ++ )
    let neq_str = ( ++ )
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

let apply_symantics (type a) (module S : SYM with type repr = a) =
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
            | Ast.Any_atom (Ast.Var (s, _)) -> Some s)
          vs
      in
      S.exists vs (helper ph)
    | Unsupp _ -> raise String_op
  and helperT = function
    | Ast.Eia.Const n -> S.constz n
    | Atom (Ast.Var (s, _)) -> S.var s
    | Add terms -> S.add (List.map helperT terms)
    | Mul terms -> S.mul (List.map helperT terms)
    | Mod (l, r) -> S.mod_ (helperT l) r
    | Pow (Const base, Atom (Var (x, _))) when base = Config.base () -> S.pow2var x
    | Pow (base, p) -> S.pow (helperT base) (helperT p)
    | Bwand _ | Bwor _ | Bwxor _ -> raise Bitwise_op
    | Len _ | Iofs _ | Sofi _ | Concat _ | At _ | Substr _ | Str_const _ | Len2 _ ->
      raise String_op
  and helper_eia eia =
    match eia with
    | Ast.Eia.Eq (l, r, I) -> S.(helperT l = helperT r)
    | Ast.Eia.Neq (l, r, I) -> S.(helperT l <> helperT r)
    | Eq (_, _, S) -> raise String_op
    | Neq (_, _, S) -> raise String_op
    | Leq (l, r) -> S.(helperT l <= helperT r)
    | InRe _ | InReRaw _ | SuffixOf _ | PrefixOf _ | Contains _ | RLen _ ->
      raise String_op
  in
  fun x -> S.prj (helper x)
;;

let log = Debug.printfln

(* Needed for tests, because Z3 gives a model "non-deterministically" *)
let omit_z3_model =
  match Sys.getenv_opt "CHRO_OMIT_Z3_MODEL" with
  | None -> false
  | Some _ -> true
;;

let semenov_bound bound ast =
  let rec compute_bound =
    let open Ast.Eia in
    function
    | Const c -> Z.(max one (abs c))
    | Atom (Var (_, I)) | Pow (_, _) -> Z.one
    | Add terms -> List.fold_left (fun acc x -> Z.(acc + compute_bound x)) Z.one terms
    | Mul terms -> List.fold_left (fun acc x -> Z.(acc * compute_bound x)) Z.one terms
    | term -> Z.one
  in
  Ast.fold
    (fun acc -> function
       | Eia (Eq (lhs, rhs, I)) ->
         max acc Z.(log2 (compute_bound lhs + compute_bound rhs))
       | Eia (Leq (lhs, rhs)) -> max acc Z.(log2 (compute_bound lhs + compute_bound rhs))
       | _ -> acc)
    bound
    ast
;;

let check bound ast =
  try
    let bound = if bound < 0 then -1 else semenov_bound bound ast in
    log "Bound for underapproximation: %d\n" bound;
    let vars = ref (Base.Set.empty (module Base.String)) in
    let interestring_vars = apply_symantics (make_collector ()) ast in
    (* TODO(Kakadu): collecting of interesting variables could be buggy. For example, what if
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
    let exception Early_Unsat in
    try
      List.iteri
        (fun i env ->
           let ((module S : SYM with type repr = Smtml.Expr.t) as sym) =
             make_sym env (fun s -> vars := Base.Set.add !vars s) bound
           in
           let ph = apply_symantics sym ast in
           (* log "Into Z3 goes: @[%a@]\n%!" Smtml.Expr.pp ph; *)
           let module Z3 = Smtml.Z3_mappings.Solver in
           (* let module Z3 = Smtml.Cvc5_mappings.Solver in *)
           let solver =
             Z3.make ~params:Smtml.Params.(default () $ (Timeout, 200000)) ()
           in
           Z3.reset solver;
           let __ _ = log "Into Z3 goes: @[%a@]\n%!" Smtml.Expr.pp ph in
           match Z3.check solver ~assumptions:[ ph ] with
           | `Sat when omit_z3_model -> raise (Early env)
           | `Sat ->
             (match Z3.model solver with
              | None -> assert false
              | Some m ->
                let env =
                  Hashtbl.fold
                    (fun k v acc ->
                       let _ : Smtml.Symbol.t = k in
                       match k.name, v with
                       | Smtml.Symbol.Simple s, Smtml.Value.Int n ->
                         Base.Map.Poly.add_exn acc ~key:s ~data:n
                       | _ -> acc)
                    (Smtml.Z3_mappings.values_of_model m)
                    env
                in
                raise (Early env))
           | `Unsat when List.length interestring_vars == 0 -> raise Early_Unsat
           | _ -> ())
        all_choices;
      (* TODO: if all Unsat, add a constraints (x>bound), becuase we have already checked values in [0.. bound] *)
      let newast =
        let vars = Base.Set.to_list !vars in
        let b = Ast.Eia.Const (Z.of_int bound) in
        let extend v = Ast.eia (Ast.Eia.lt b (Ast.Eia.atom (Ast.Var (v, I)))) in
        Ast.land_ (ast :: List.map extend vars)
      in
      log "Can't decide in %s" __FILE__;
      `Unknown newast
    with
    | Early env ->
      log "%s gives early Sat." __FILE__;
      (* log "env = %a" pp_env env; *)
      `Sat ("under int", to_normal_env env)
    | Early_Unsat -> `Unsat "nia"
  with
  | String_op | Bitwise_op -> `Unknown ast
;;
