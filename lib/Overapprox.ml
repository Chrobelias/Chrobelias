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
end

(** SYntax + seMANTICS *)
module Symantics : Smtml_symantics = struct
  open Smtml

  type term = Expr.t
  type str = Expr.t
  type ph = Expr.t [@@warning "-34"]

  let str_len _ = assert false
  let str_atoi _ = assert false
  let str_const _ = assert false
  let str_var _ = assert false
  let in_re _ _ = failwith __FILE__
  let const n = Smtml.Expr.value (Value.Int n)
  let var s = Smtml.Expr.symbol (Smtml.Symbol.make Smtml.Ty.Ty_int s)
  let pow base p = Expr.binop Ty.Ty_int Ty.Binop.Pow base p

  let mul = function
    | [] -> const 1
    | x :: xs -> List.fold_left (Expr.binop Ty.Ty_int Ty.Binop.Mul) x xs
  ;;

  let add = function
    | [] ->
      (* const 0 ??? *)
      failwith (Printf.sprintf "Bad argument: %s" __FUNCTION__)
    | x :: xs -> List.fold_left (Expr.binop Ty.Ty_int Ty.Binop.Add) x xs
  ;;

  let bw op l r =
    match op with
    | FT_SIG.Bwand -> Expr.binop Ty.Ty_int Ty.Binop.And l r
    | Bwor -> Expr.binop Ty.Ty_int Ty.Binop.Or l r
    | Bwxor -> Expr.binop Ty.Ty_int Ty.Binop.Xor l r
  ;;

  let exists vs ph =
    Smtml.Expr.exists (List.map (fun s -> Smtml.Expr.symbol (Symbol.make Ty_int s)) vs) ph
  ;;

  let true_ = Expr.Bool.true_
  let false_ = Expr.Bool.false_
  let not = Expr.Bool.not

  let land_ = function
    | [] -> false_
    | h :: tl -> List.fold_left Expr.Bool.and_ h tl
  ;;

  let lor_ = function
    | [] -> true_
    | h :: tl -> List.fold_left Expr.Bool.or_ h tl
  ;;

  let eq l r = Expr.relop Ty.Ty_bool Ty.Relop.Eq l r
  let leq l r = Expr.relop Ty.Ty_int Ty.Relop.Le l r
  let lt l r = Expr.relop Ty.Ty_int Ty.Relop.Lt l r
  let ( = ) = eq
  let ( < ) = lt
  let ( <= ) = leq
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

let check ast =
  let tracing_on =
    match Sys.getenv "CHRO_TRACE_OPT" with
    | exception Not_found -> false
    | "1" -> true
    | _ -> false
  in
  let exception Bitwise_inside in
  let exception String_inside in
  cache := Base.Map.empty (module Base.String);
  let rec helper = function
    | Ast.Land xs -> Symantics.land_ (List.map helper xs)
    | Lor xs -> Symantics.lor_ (List.map helper xs)
    | Lnot x -> Symantics.not (helper x)
    | True -> Symantics.true_
    | Eia e -> helper_eia e
    | Pred s -> Symantics.var s
    | Exists (vs, ph) ->
      let vs =
        List.filter_map
          (function
            | Ast.Var s -> Some s
            | Ast.Const _ -> None)
          vs
      in
      Symantics.exists vs (helper ph)
    | Str _ -> raise_notrace String_inside
  and helperT = function
    | Ast.Eia.Atom (Ast.Const n) -> Symantics.const (Z.to_int n)
    | Atom (Ast.Var s) -> Symantics.var s
    | Add terms -> Symantics.add (List.map helperT terms)
    | Mul terms -> Symantics.mul (List.map helperT terms)
    | Pow (Atom (Ast.Const base), Atom (Ast.Var x)) when base = Z.of_int 2 ->
      Symantics.var (gensym x)
    | Pow (base, p) -> Symantics.pow (helperT base) (helperT p)
    | Bwand _ | Bwor _ | Bwxor _ -> raise_notrace Bitwise_inside
    | Len _ | Stoi _ -> raise_notrace String_inside
  and helper_eia eia =
    try
      match eia with
      | Ast.Eia.Eq (l, r) -> Symantics.(helperT l = helperT r)
      | Leq (l, r) -> Symantics.(helperT l <= helperT r)
    with
    | String_inside | Bitwise_inside -> Symantics.true_
  in
  let _repr = helper ast in
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
