let log = Debug.printfln

module type s_term = sig
  type term

  val pow : term -> term -> term
  val mul : term list -> term
  val add : term list -> term
  val bw : Me.sup_binop -> term -> term -> term
  val const : int -> term
  val var : string -> term
end

module type s_ph = sig
  type ph
  type term

  val land_ : ph list -> ph
  val lor_ : ph list -> ph
  val not : ph -> ph
  val true_ : ph
  val false_ : ph
  val eq : term -> term -> ph
  val leq : term -> term -> ph
  val lt : term -> term -> ph
end

module type s_extra = sig
  type term
  type ph

  val ( <= ) : term -> term -> ph
  val ( < ) : term -> term -> ph
  val ( = ) : term -> term -> ph
end

let cache : Smtml.Expr.t list ref = ref []

(** SYntax + seMANTICS *)
module Symantics : sig
  include s_term with type term := Smtml.Expr.t
  include s_ph with type ph := Smtml.Expr.t and type term = Smtml.Expr.t
  include s_extra with type ph := Smtml.Expr.t and type term = Smtml.Expr.t
end = struct
  open Smtml

  type term = Expr.t
  type ph = Expr.t [@@warning "-34"]

  let const n = Smtml.Expr.value (Value.Int n)
  let var s = Smtml.Expr.symbol (Smtml.Symbol.make Smtml.Ty.Ty_int s)
  let pow base p = Expr.binop Ty.Ty_int Ty.Binop.Pow base p

  let mul = function
    | [] -> failwith "bad argument"
    | x :: xs -> List.fold_left (Expr.binop Ty.Ty_int Ty.Binop.Mul) x xs
  ;;

  let add = function
    | [] -> failwith "bad argument"
    | x :: xs -> List.fold_left (Expr.binop Ty.Ty_int Ty.Binop.Add) x xs
  ;;

  let bw op l r =
    match op with
    | Me.Bwand -> Expr.binop Ty.Ty_int Ty.Binop.And l r
    | Bwor -> Expr.binop Ty.Ty_int Ty.Binop.Or l r
    | Bwxor -> Expr.binop Ty.Ty_int Ty.Binop.Xor l r
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

  let eq _ = assert false
  let leq l r = Expr.relop Ty.Ty_int Ty.Relop.Le l r
  let lt l r = Expr.relop Ty.Ty_int Ty.Relop.Lt l r
  let ( = ) = eq
  let ( < ) = lt
  let ( <= ) = leq
end

let gensym =
  let n = ref 0 in
  fun ?prefix () ->
    incr n;
    match prefix with
    | Some p -> Printf.sprintf "%s%d" p !n
    | None -> Printf.sprintf "__%d" !n
;;

let check ast =
  let exception Bitwise_inside in
  cache := [];
  let extend ph = cache := ph :: !cache in
  let rec helper = function
    | Ast.Land xs -> Symantics.land_ (List.map helper xs)
    | Lor xs -> Symantics.lor_ (List.map helper xs)
    | Lnot x -> Symantics.not (helper x)
    | True -> Symantics.true_
    | Eia e -> helper_eia e
    | Pred s -> Symantics.var s
    | Exists (vs, ph) as other ->
      Format.eprintf "Unsupported: %a\n%!" Ast.pp other;
      exit 2
  and helperT = function
    | Ast.Eia.Atom (Ast.Const n) -> Symantics.const n
    | Atom (Ast.Var s) -> Symantics.var s
    | Add terms -> Symantics.add (List.map helperT terms)
    | Mul terms -> Symantics.mul (List.map helperT terms)
    | Pow (Atom (Ast.Const 2), Atom (Ast.Var x)) ->
      let fv = Symantics.var (gensym ~prefix:"exp_2_" ()) in
      (* TODO: duplicates? *)
      extend Symantics.(var x < fv);
      fv
    | Pow (base, p) -> Symantics.pow (helperT base) (helperT p)
    | Bwand _ | Bwor _ | Bwxor _ -> raise_notrace Bitwise_inside
  (* | other ->
      Format.eprintf "Unsupported term: %a\n%!" Ast.Eia.pp_term other;
      exit 2 *)
  and helper_eia eia =
    try
      match eia with
      | Ast.Eia.Eq (l, r) -> Symantics.(helperT l = helperT r)
      | Leq (l, r) -> Symantics.(helperT l <= helperT r)
    with
    | Bitwise_inside -> Symantics.true_
  in
  let _repr = helper ast in
  let whole = Symantics.land_ (_repr :: !cache) in
  log "whole: %a\n%!" Smtml.Expr.pp whole;
  let solver = Smtml.Z3_mappings.Solver.make () in
  Smtml.Z3_mappings.Solver.reset solver;
  match Smtml.Z3_mappings.Solver.check solver ~assumptions:[ whole ] with
  | `Unsat ->
    log "Early Unsat in %s" __FILE__;
    `Unsat
  | `Unknown -> `Unknown
  | `Sat ->
    log "Early SAT in %s ~~> Unknown" __FILE__;
    let _printing_module_disabled () =
      match Smtml.Z3_mappings.Solver.model solver with
      | Some m ->
        let m = Smtml.Z3_mappings.values_of_model m in
        log "%a\n" (Smtml.Model.pp ~no_values:false) m;
        ()
      | None -> ()
    in
    `Unknown
;;
