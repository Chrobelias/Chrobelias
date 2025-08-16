let log = Debug.printfln

module type s_term = sig
  type term

  val pow : term -> term -> term
  val mul : term list -> term
  val add : term list -> term
  val const : int -> term
  val var : string -> term
end

module type s_ph = sig
  type ph
  type term

  val land_ : ph list -> ph
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

module Semantics : sig
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

  let land_ = function
    | [] -> Expr.Bool.false_
    | h :: tl -> List.fold_left Expr.Bool.and_ h tl
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
  cache := [];
  let extend ph = cache := ph :: !cache in
  let rec helper = function
    | Ast.Land xs -> Semantics.land_ (List.map helper xs)
    | Eia e -> helper_eia e
    | other ->
      Format.eprintf "Unsupported: %a\n%!" Ast.pp other;
      exit 2
  and helperT = function
    | Ast.Eia.Atom (Ast.Const n) -> Semantics.const n
    | Atom (Ast.Var s) -> Semantics.var s
    | Add terms -> Semantics.add (List.map helperT terms)
    | Mul terms -> Semantics.mul (List.map helperT terms)
    | Pow (Atom (Ast.Const 2), Atom (Ast.Var x)) ->
      let fv = Semantics.var (gensym ~prefix:"exp_2_" ()) in
      (* TODO: duplicates? *)
      extend Semantics.(var x < fv);
      fv
    | Pow (base, p) -> Semantics.pow (helperT base) (helperT p)
    | other ->
      Format.eprintf "Unsupported term: %a\n%!" Ast.Eia.pp_term other;
      exit 2
  and helper_eia = function
    | Ast.Eia.Eq (l, r) -> Semantics.(helperT l = helperT r)
    | Leq (l, r) -> Semantics.(helperT l <= helperT r)
  in
  let _repr = helper ast in
  let whole = Semantics.land_ (_repr :: !cache) in
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
    (match Smtml.Z3_mappings.Solver.model solver with
     | Some m ->
       let m = Smtml.Z3_mappings.values_of_model m in
       log "%a\n" (Smtml.Model.pp ~no_values:false) m;
       ()
     | None -> ());
    `Unknown
;;
