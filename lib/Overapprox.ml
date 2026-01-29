let log = Debug.printfln

module type Smtml_symantics = sig
  include FT_SIG.z_term with type term := Smtml.Expr.t
  include FT_SIG.str_term with type term := Smtml.Expr.t and type str := Smtml.Expr.t

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

(* MS: Config.base () must be replaced with a base taken from the phormula *)
let formulas_of_cache () =
  Base.Map.to_sequence !cache
  |> Base.Sequence.map ~f:(fun (x, fv) ->
    Symantics.(mul [ constz Z.(Config.base () - one); var x ] < var fv))
  |> Base.Sequence.to_list
;;

let gensym base =
  let n = ref 0 in
  let prefix = Format.asprintf "exp_%a_" Z.pp_print base in
  fun name ->
    match Base.Map.find_exn !cache name with
    | exception Base.Not_found_s _ ->
      incr n;
      let ans = Printf.sprintf "%s%s" prefix name in
      extend name ans;
      ans
    | x -> x
;;

exception Bitwise_op
exception String_op
exception Difficult_Exp_op

let apply_symnatics (module S : Smtml_symantics) =
  let rec helper = function
    | Ast.True -> S.true_
    | Lnot (Eia (InRe _))
    | Lnot (Eia (InReRaw _))
    | Lnot (Eia (SuffixOf _))
    | Lnot (Eia (PrefixOf _))
    | Lnot (Eia (Contains _)) -> S.true_
    | Lnot x -> S.not (helper x)
    | Land xs -> S.land_ (List.map helper xs)
    | Lor xs -> S.lor_ (List.map helper xs)
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
    | Unsupp _ -> S.true_
  and helperT = function
    | Ast.Eia.Const n -> S.constz n
    | Atom (Ast.Var (s, _)) -> S.var s
    | Add terms -> S.add (List.map helperT terms)
    | Mul terms -> S.mul (List.map helperT terms)
    | Pow (Const base, Atom (Ast.Var (x, _k))) -> Symantics.var (gensym base x)
    | Pow (base, Const p) -> S.pow (helperT base) (helperT (Const p))
    | Pow (_, _) -> raise Difficult_Exp_op
    | Mod (t, z) -> S.mod_ (helperT t) z
    | Bwand _ | Bwor _ | Bwxor _ -> raise Bitwise_op
    | Concat _ | At _ | Substr _ | Ast.Eia.Str_const _ | Len _ | Sofi _ | Iofs _ | Len2 _
      -> raise String_op
  and helper_eia ph =
    try
      let open Ast in
      let open Ast.Eia in
      match ph with
      | Leq (l, r) -> S.(helperT l <= helperT r)
      (*| Eq (Atom (Var (name, I)), r, I) -> S.(helperT (Atom (Var (name, I))) = helperT r)
      | Eq (Atom (Var (_, S)), _, S) -> raise String_op*)
      | Eq (l, r, I) -> S.(helperT l = helperT r)
      | Eq (l, r, S) -> raise String_op
      | InRe _ | InReRaw _ | SuffixOf _ | PrefixOf _ | Contains _ | RLen _ ->
        raise String_op
    with
    | String_op | Bitwise_op | Difficult_Exp_op -> Symantics.true_
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
  let module Z3 = Smtml.Z3_mappings.Solver in
  (* let module Z3 = Smtml.Cvc5_mappings.Solver in *)
  let solver = Z3.make ~params:Smtml.Params.(default () $ (Timeout, 200000)) () in
  Z3.reset solver;
  match Z3.check solver ~assumptions:whole with
  | `Unsat ->
    if tracing_on then Format.printf "Early Unsat in %s\n%!" __FILE__;
    `Unsat
  | `Unknown ->
    log "Can't decide in %s%!" __FILE__;
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
  else (
    try check ast with
    | _ -> `Unknown ast)
;;
