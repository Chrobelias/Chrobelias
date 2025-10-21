let log = Debug.printfln

module type Smtml_symantics = sig
  include FT_SIG.s_term with type term := Smtml.Expr.t and type str = Smtml.Expr.t

  include
    FT_SIG.s_ph
    with type ph := Smtml.Expr.t
     and type term = Smtml.Expr.t
     and type str = Smtml.Expr.t

  include FT_SIG.s_extra with type ph := Smtml.Expr.t and type term = Smtml.Expr.t

  val exists : string list -> Smtml.Expr.t -> Smtml.Expr.t

  type repr = Smtml.Expr.t

  val prj : Smtml.Expr.t -> Smtml.Expr.t
end

module Symantics : Smtml_symantics = struct
  include FT_SIG.To_smtml_symantics

  type repr = Smtml.Expr.t

  let prj = Fun.id

  let exists vs ph =
    Smtml.Expr.exists
      (List.map (fun s -> Smtml.Expr.symbol (Smtml.Symbol.make Ty_int s)) vs)
      ph
  ;;
end

let cache : (string, string, _) Base.Map.t ref = ref (Base.Map.empty (module Base.String))
let extend vk vv = cache := Base.Map.add_exn !cache ~key:vk ~data:vv

let formulas_of_cache () =
  Base.Map.to_sequence !cache
  |> Base.Sequence.map ~f:(fun (x, fv) -> Symantics.(var x < var fv))
  |> Base.Sequence.to_list
;;

let gensym =
  let n = ref 0 in
  let prefix = "exp_2_" in
  fun name ->
    match Base.Map.find_exn !cache name with
    | exception Base.Not_found_s _ ->
      incr n;
      let ans = Printf.sprintf "%s%d" prefix !n in
      extend name ans;
      ans
    | x -> x
;;

exception Bitwise_op
exception String_op

let apply_symnatics (module S : Smtml_symantics) =
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
    | Str _ -> Symantics.true_
  and helperT = function
    | Ast.Eia.Atom (Ast.Const n) -> S.const (Z.to_int n)
    | Atom (Ast.Var s) -> S.var s
    | Add terms -> S.add (List.map helperT terms)
    | Mul terms -> S.mul (List.map helperT terms)
    | Pow (Atom (Ast.Const base), Atom (Ast.Var x)) when base = Z.of_int 2 ->
      Symantics.var (gensym x)
    | Pow (base, p) -> S.pow (helperT base) (helperT p)
    | Mod (t, z) -> S.mod_ (helperT t) z
    | Bwand _ | Bwor _ | Bwxor _ -> raise Bitwise_op
    | Len _ | Stoi _ | Len2 _ -> raise String_op
  and helper_eia eia =
    try
      match eia with
      | Ast.Eia.Eq (l, r) -> S.(helperT l = helperT r)
      | Leq (l, r) -> S.(helperT l <= helperT r)
    with
    | String_op | Bitwise_op -> Symantics.true_
  in
  fun x -> S.prj (helper x)
;;

let check ast =
  let tracing_on =
    match Sys.getenv "CHRO_TRACE_OPT" with
    | exception Not_found -> false
    | "1" -> true
    | _ -> false
  in
  cache := Base.Map.empty (module Base.String);
  let _repr = apply_symnatics (module Symantics) ast in
  let whole = _repr :: formulas_of_cache () in
  Format.pp_print_flush Format.std_formatter ();
  log "@[whole: @[<v>%a@]@]\n%!" (Format.pp_print_list Smtml.Expr.pp) whole;
  let solver = Smtml.Z3_mappings.Solver.make () in
  Smtml.Z3_mappings.Solver.reset solver;
  match Smtml.Z3_mappings.Solver.check solver ~assumptions:whole with
  | `Unsat ->
    if tracing_on then Format.printf "Early Unsat in %s\n%!" __FILE__;
    `Unsat
  | `Unknown ->
    if tracing_on then Format.printf "`Unknown  in %s\n%!" __FILE__;
    `Unknown ast
  | `Sat when tracing_on ->
    Format.printf "Early SAT in %s ~~> Unknown\n%!" __FILE__;
    let () =
      match Smtml.Z3_mappings.Solver.model solver with
      | Some m ->
        let m = Smtml.Z3_mappings.values_of_model m in
        Format.printf "%a\n%!" (Smtml.Model.pp ~no_values:false) m;
        ()
      | None -> ()
    in
    `Unknown ast
  | `Sat -> `Unknown ast
;;

let check ast =
  (* Skip expressions with "forall" quantifier: Z3 stucks when evaluating them. *)
  if
    Ast.forsome
      (function
        | Ast.Exists (atoms, ast) ->
          Ast.forsome
            (function
              | Ast.Lnot ast ->
                Ast.forsome
                  (function
                    | Ast.Exists _ -> true
                    | _ -> false)
                  ast
              | _ -> false)
            ast
        | _ -> false)
      ast
  then `Unknown ast
  else check ast
;;
