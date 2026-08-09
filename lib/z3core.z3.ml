(* TEMPORARY: this talks to the Z3 bindings directly, bypassing Smtml, because
   Smtml's solver interface has no [get_unsat_core] (see issue-unsat-cores.md).
   Fold this back into the Smtml path once it grows one. *)
let z3_ctx = lazy (Z3.mk_context [])

let z3_symantics ctx : (module Lowering.Core_symantics with type repr = Z3.Expr.expr) =
  (module struct
    type repr = Z3.Expr.expr

    let true_ = Z3.Boolean.mk_true ctx
    let false_ = Z3.Boolean.mk_false ctx
    let not = Z3.Boolean.mk_not ctx

    (* The empty-list cases mirror [FT_SIG.To_smtml_symantics] exactly, odd as
       they look: the two lowerings must agree on every input. *)
    let land_ = function
      | [] -> false_
      | phs -> Z3.Boolean.mk_and ctx phs
    ;;

    let lor_ = function
      | [] -> true_
      | phs -> Z3.Boolean.mk_or ctx phs
    ;;

    let var s = Z3.Arithmetic.Integer.mk_const_s ctx s

    let exists vs ph =
      Z3.Quantifier.mk_exists_const ctx (List.map var vs) ph None [] [] None None
      |> Z3.Quantifier.expr_of_quantifier
    ;;

    let constz z = Z3.Arithmetic.Integer.mk_numeral_s ctx (Z.to_string z)

    let add = function
      | [] -> failwith (Printf.sprintf "Bad argument: %s" __FUNCTION__)
      | ts -> Z3.Arithmetic.mk_add ctx ts
    ;;

    let mul = function
      | [] -> constz Z.one
      | ts -> Z3.Arithmetic.mk_mul ctx ts
    ;;

    let pow b e = Z3.Arithmetic.mk_power ctx b e

    let mod_ t z =
      if Z.(z > zero)
      then Z3.Arithmetic.Integer.mk_rem ctx t (constz z)
      else failwith "mod_: non-positive divisor"
    ;;

    let ( <= ) l r = Z3.Arithmetic.mk_le ctx l r
    let ( < ) l r = Z3.Arithmetic.mk_lt ctx l r
    let ( = ) l r = Z3.Boolean.mk_eq ctx l r
    let ( <> ) l r = not (l = r)
    let prj = Fun.id
  end)
;;

(* Each abstraction is guarded by a fresh boolean literal and the literals are
   passed as assumptions, so Z3 reports the core natively in one check. The core
   Z3 returns is small but not guaranteed minimal, so a deletion pass runs over
   it -- a handful of checks over already-internalized literals, where deletion
   over the raw abstractions used to cost one check per conjunct with every
   assumption re-internalized each time. *)
let check_length_core ~parts ~facts =
  Lowering.reset_cache ();
  let ctx = Lazy.force z3_ctx in
  let module S = (val z3_symantics ctx) in
  let to_z3 = Lowering.apply_symnatics (module S) in
  (* Translate everything before reading the cache: [apply_symnatics] populates it
     while lowering [Pow], and the bounds it records belong with the facts. *)
  let assumptions = List.map (fun (ph, abstraction) -> ph, to_z3 abstraction) parts in
  let fact_exprs = List.map to_z3 facts in
  let fact_exprs = fact_exprs @ Lowering.formulas_of_cache (module S) in
  let solver = Z3.Solver.mk_solver ctx None in
  let () =
    let params = Z3.Params.mk_params ctx in
    Z3.Params.add_int params (Z3.Symbol.mk_string ctx "timeout") 200_000;
    Z3.Params.add_int params (Z3.Symbol.mk_string ctx "random_seed") 42;
    Z3.Solver.set_parameters solver params
  in
  Z3.Solver.add solver fact_exprs;
  let guarded =
    List.mapi
      (fun i (ph, abstraction) ->
         let guard = Z3.Boolean.mk_const_s ctx (Printf.sprintf "core!guard!%d" i) in
         Z3.Solver.add solver [ Z3.Boolean.mk_implies ctx guard abstraction ];
         guard, ph)
      assumptions
  in
  let unsat_with guards =
    match Z3.Solver.check solver guards with
    | Z3.Solver.UNSATISFIABLE -> true
    | SATISFIABLE | UNKNOWN -> false
  in
  if not (unsat_with (List.map fst guarded))
  then `Unknown
  else (
    let core = Z3.Solver.get_unsat_core solver in
    let in_core g = List.exists (Z3.Expr.equal g) core in
    let candidates = List.filter (fun (g, _) -> in_core g) guarded in
    let rec minimize kept = function
      | [] -> List.rev kept
      | p :: rest ->
        if unsat_with (List.map fst (List.rev_append kept rest))
        then minimize kept rest
        else minimize (p :: kept) rest
    in
    match minimize [] candidates with
    (* The facts alone are contradictory, so no conjunct is to blame. *)
    | [] -> `Unknown
    | survivors -> `Unsat (List.map snd survivors))
;;
