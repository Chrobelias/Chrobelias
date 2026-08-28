(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2026, Chrobelias. *)

module Map = Base.Map.Poly
module Set = Base.Set.Poly
open Lib

exception Too_long_model
exception Lics_Underapprox_unsuccessful

let () = Printexc.record_backtrace true
let config = Config.config
let () = Config.parse_args ()
let trace_log fmt = Debug.trace "chro" fmt
let smt_status = ref None
let sat_found = ref false
let is_internal = String.starts_with ~prefix:"%"

(* Post-checks for different disequalities may share a variable, so the partial
   models they produce are not necessarily disjoint. Agreeing bindings merge
   cleanly; on a genuine conflict keep the already-accumulated one rather than
   raising from [merge_disjoint_exn] after [sat] has already been reported. *)
let merge_models : Model.t -> Model.t -> Model.t =
  fun model1 model2 ->
  Map.merge_skewed model1 model2 ~combine:(fun ~key v1 v2 ->
    if Stdlib.(v1 = v2)
    then v1
    else (
      trace_log "conflicting bindings for %S while merging models\n%!" key;
      v1))
;;

let () =
  Sys.set_signal
    Sys.sigterm
    (Sys.Signal_handle
       (fun _ ->
         if !sat_found
         then print_endline "no short model found (timeout)"
         else print_endline "timeout";
         exit 1))
;;

type rez =
  | Sat of
      string
      * (Ast.t
        * Env.t
        * (Model.tys -> (Model.t, [ `Too_long | `No_model ]) Result.t)
        * (string, Nfa.String.u) Map.t)
  | Unknown of Ast.t * Env.t
  | Unsat of string * Ast.t

let sat
      ?(env = Env.empty)
      ?(get_model = fun _ -> Result.Ok Map.empty)
      ?(regexes = Map.empty)
      desc
      ast
  =
  Sat (desc, (ast, env, get_model, regexes))
;;

let unsat desc core = Unsat (desc, core)
let unknown ast env = Unknown (ast, env)

(* Like [Seq.fold_left], but stops as soon as the accumulator is [Sat] instead
   of forcing the rest of a lazy — and potentially expensive — sequence. *)
let rec fold_until_sat f acc seq =
  match acc with
  | Sat _ -> acc
  | Unknown _ | Unsat _ ->
    (match seq () with
     | Seq.Nil -> acc
     | Seq.Cons (x, rest) -> fold_until_sat f (f acc x) rest)
;;

let construct_model tys env model regexes =
  let module NfaS = Nfa.String in
  let join_int_model prefix m =
    let open Ast in
    Debug.trace "Model" "Prefix %a\n%!" (Env.pp ~title:"prefix") prefix;
    Debug.trace "Model" "Model %s\n%!" (Model.to_string m);
    let prefix =
      let shrink_ir_model = Map.map_keys_exn m ~f:(fun s -> Any_atom (Ast.var s Ast.I)) in
      Env.enrich prefix shrink_ir_model
    in
    let rec seek prefix key =
      match Env.lookup_int key prefix with
      | Some eia ->
        (match SimplII.subst_term prefix eia with
         | Eia.Const c -> Option.some (`Int c)
         | Eia.Str_const s -> Option.some (`Str s)
         | Eia.Atom (Var (v, _)) -> seek prefix v
         | Eia.Len (Eia.Atom (Var (v, _))) -> seek prefix ("strlen" ^ v)
         | _ -> None)
      | None ->
        (match Env.lookup_string key prefix with
         | Some str ->
           (match SimplII.subst_term prefix str with
            | Eia.Const c -> Option.some (`Int c)
            | Eia.Str_const s -> Option.some (`Str s)
            | Eia.Atom (Var (v, _)) -> seek prefix v
            | _ -> None)
         | None -> None)
    in
    let rec saturate env =
      let env' : Env.t =
        Env.fold
          env
          ~f:(fun ~key ~data acc ->
            begin match data with
            | TT (Ast.I, term) -> Env.extend_int_exn acc key (SimplII.subst_term env term)
            | TT (Ast.S, term) ->
              Env.extend_string_exn acc key (SimplII.subst_term env term)
            end)
          ~init:Env.empty
      in
      if Env.equal env' env then env' else saturate env'
    in
    let prefix = saturate prefix in
    let unknown_vars =
      Env.fold
        ~init:Set.empty
        ~f:(fun ~key:_ ~data:tt acc ->
          match tt with
          | TT (Ast.I, eia) ->
            Set.union
              acc
              (get_int_vars (Eia (Eia.eq (Eia.const Z.zero) eia Ast.I)) |> Set.of_list)
          | TT (Ast.S, _) -> acc)
        prefix
    in
    let prefix =
      Set.fold unknown_vars ~init:prefix ~f:(fun acc var ->
        Env.extend_int_exn acc var (Eia.const Z.zero))
    in
    Env.fold prefix ~init:m ~f:(fun ~key ~data:_ acc ->
      match seek prefix key with
      | Some value -> Map.set acc ~key ~data:value
      | None -> acc)
    |> Map.filter_keys ~f:(Fun.negate is_internal)
  in
  let prefix = "strlen" in
  let strlenvar var = prefix ^ var in
  let dearithmetize (model : Model.t) : Model.t =
    Map.to_alist model
    |> List.filter_map (fun (key, data) ->
      match key with
      | key when String.starts_with ~prefix key ->
        let prefix_len = String.length prefix in
        let string_var = String.sub key prefix_len (String.length key - prefix_len) in
        let data =
          match data with
          | `Int c ->
            if c > Z.(pow (Z.of_int !Lib.Config.base) (Lib.Config.huge_const ()))
            then raise Too_long_model
            else (
              try Z.to_int c with
              | Z.Overflow -> raise Too_long_model)
          | _ -> assert false
        in
        if Map.mem model string_var
        then None
        else if Map.mem regexes string_var
        then (
          let regex = Map.find_exn regexes string_var in
          let path =
            if data = 0
            then []
            else
              NfaS.path_of_len2 ~var:0 ~len:data regex
              |> function
              | Some path -> path
              | None ->
                failwith
                  (Format.asprintf
                     "Unable to find a path of length %d for variable %s in its regex"
                     data
                     string_var)
          in
          Some (string_var, `Str (List.to_seq path |> String.of_seq)))
        else Some (string_var, `Str (String.init data (fun _ -> '0')))
      | key ->
        let data =
          match data with
          | `Str c -> `Str c
          | `Int d ->
            (match Map.find tys key with
             | Some `Str ->
               let model =
                 if not (Map.mem regexes key)
                 then Z.to_string d
                 else (
                   let re =
                     Map.find_exn regexes key
                     |> NfaS.intersect (Regex.int_to_re_all d |> NfaS.of_regex)
                   in
                   NfaS.any_path re [ 0 ]
                   |> Option.get
                   |> fun (l, _) ->
                   List.nth l 0 |> List.rev |> List.to_seq |> String.of_seq)
               in
               `Str model
             | Some `Int | None -> `Int d)
        in
        let result =
          match data with
          | `Str str ->
            let len =
              match Map.find model (strlenvar key) with
              | Some (`Int len) -> Z.to_int len
              | _ -> String.length str
            in
            let str =
              if len = 0
              then ""
              else if len > String.length str
              then String.init (len - String.length str) (fun _ -> '0') ^ str
              else str
            in
            `Str str
          | `Int d -> `Int d
        in
        Some (key, result))
    |> Map.of_alist_exn
  in
  let string_model =
    Map.fold
      ~init:(model |> join_int_model env |> dearithmetize)
      ~f:(fun ~key:var ~data:re acc ->
        if
          (not (Map.mem acc var))
          && (not (Map.mem acc (strlenvar var)))
          && Env.is_absent_key var env
          && Env.is_absent_key (strlenvar var) env
        then (
          let path = NfaS.any_path re [ 0 ] |> Option.get |> fun (l, _) -> List.nth l 0 in
          Map.add_exn ~key:var ~data:(`Str (List.to_seq path |> String.of_seq)) acc)
        else acc)
      regexes
  in
  Debug.trace "Model" "tys length = %d" (Map.length tys);
  Debug.trace
    "Model"
    "String model:\n  %s"
    (Model.to_string (Map.filter_keys ~f:(Map.mem tys) string_model));
  let env = Env.enrich2 env string_model in
  (* Pin every still-free variable to its default before resolving, not while
     printing: a bound variable may refer to a free one -- e.g. the string
     under-approximation can answer with [x -> (str.++ m "ab")] where any [m]
     works -- and resolving that term needs [m]'s value in the environment.
     Defaulting [m] only at print time left [x] unresolvable, silently
     dropping it from the model. *)
  let env =
    Map.fold
      ~init:env
      ~f:(fun ~key ~data env ->
        if Env.is_absent_key key env
        then (
          match data with
          | `Str -> Env.extend_string_exn env key (Ast.Eia.Str_const "")
          | `Int -> Env.extend_int_exn env key (Ast.Eia.Const Z.zero))
        else env)
      tys
  in
  let resolve_from_env key =
    let open Ast in
    let rec seek key steps =
      if steps <= 0
      then None
      else (
        let of_term : type a. a Eia.term -> _ = function
          | Eia.Const c -> Option.some (`Int c)
          | Eia.Str_const s -> Option.some (`Str s)
          | Eia.Atom (Var (v, _)) -> seek v (steps - 1)
          | _ -> None
        in
        match Env.lookup_int key env with
        | Some eia -> of_term (SimplII.subst_term env eia)
        | None ->
          (match Env.lookup_string key env with
           | Some str -> of_term (SimplII.subst_term env str)
           | None -> None))
    in
    seek key (Env.length env + 1)
  in
  Map.fold
    ~f:(fun ~key ~data acc ->
      if Map.mem acc key
      then acc
      else (
        match resolve_from_env key, data with
        | Some (`Str s), `Str -> Map.add_exn acc ~key ~data:(`Str s)
        | Some (`Int c), `Int -> Map.add_exn acc ~key ~data:(`Int c)
        | Some (`Int c), `Str -> Map.add_exn acc ~key ~data:(`Str (Z.to_string c))
        | Some (`Str _), `Int | None, _ -> acc))
    ~init:(Map.filter_keys ~f:(Map.mem tys) string_model)
    tys
;;

let calculate_model tys env model regexes =
  Debug.trace "Model" "Calculating the model";
  Debug.trace "Model" "Env      :\n  %a" (Env.pp ~title:"") env;
  Debug.trace "Model" "NFA model:\n  %s" (Model.to_string model);
  Debug.trace "Model" "Regexes: :\n";
  let module NfaS = Nfa.String in
  Map.iteri
    ~f:(fun ~key ~data ->
      trace_log "%s -> " key;
      Debug.dump_nfa ~msg:"%s" NfaS.format_nfa data)
    regexes;
  Debug.trace "Model" "";
  try construct_model tys env model regexes with
  | Too_long_model -> raise Too_long_model
  | exn ->
    trace_log "model construction failed: %s\n%!" (Printexc.to_string exn);
    raise Too_long_model
;;

let print_model model = Format.printf "%s\n%!" (Model.to_string model)

let report_result ?(verbose = false) rez =
  let check_answer () =
    Format.printf "%!";
    Format.eprintf "%!";
    match rez, !smt_status with
    | _, None | _, Some `Unknown | `Unsat _, Some `Unsat | `Sat _, Some `Sat -> ()
    | `Unknown _, Some `Sat ->
      Printf.eprintf "(warning: check annotation that says 'sat')\n%!"
    | `Unknown _, Some `Unsat ->
      Printf.eprintf "(warning:  check annotation that says 'unsat')\n%!"
    | `Unsat _, Some `Sat ->
      Printf.eprintf "(error: check annotation that says 'sat')\n%!"
    | `Sat _, Some `Unsat ->
      Printf.eprintf "(error: check annotation that says 'unsat')\n%!"
  in
  let () = if Debug.flag () || not verbose then () else check_answer () in
  if verbose
  then (
    match rez with
    | `Sat s ->
      if config.with_info then Format.printf "sat (%s)\n%!" s else Format.printf "sat\n%!"
    | `Unsat s ->
      if config.with_info
      then Format.printf "unsat (%s)\n%!" s
      else Format.printf "unsat\n%!"
    | `Unknown s -> Format.printf "unknown %s\n%!" (if s <> "" then "(" ^ s ^ ")" else ""))
  else ()
;;

let reason lhs rhs =
  let ord =
    [ "nfa"; "simpl"; "over"; "nia"; "presimpl int"; "lengths"; "presimpl str"; "?" ]
  in
  let lhs' = List.find_index (( = ) lhs) ord |> Option.value ~default:(List.length ord) in
  let rhs' = List.find_index (( = ) rhs) ord |> Option.value ~default:(List.length ord) in
  if lhs' <= rhs' then lhs else rhs
;;

let z3_timeout_ms = 60_000

let dpll check_sat ?(verbose = false) ast =
  let module Z3 = Smtml.Z3_mappings.Solver in
  let module Literal_type = struct
    type t =
      | P
      | N
  end
  in
  let get_literal var = function
    | Literal_type.P -> var
    | Literal_type.N -> Ast.lnot var
  in
  let bool_internalc = ref 0 in
  let bool_internal_name () =
    let r = Format.asprintf "$%d" !bool_internalc in
    bool_internalc := !bool_internalc + 1;
    r
  in
  let th_map, bool_map = ref Map.empty, ref Map.empty in
  let to_bool_skeleton ?allow_new ast =
    let eia_to_bool ?allow_new eia =
      let eia =
        match eia with
        | Ast.Eia eia -> Ast.Eia (SimplII.normalize eia)
        | Unsupp _ as ast -> ast
        | _ -> assert false
      in
      match Map.find !th_map eia with
      | Some (var, t) -> get_literal var t
      | None when allow_new |> Option.value ~default:false ->
        (match Map.find !th_map eia with
         | Some (var, t) -> get_literal var t
         | None ->
           let s = bool_internal_name () in
           th_map := Map.add_exn !th_map ~key:eia ~data:(Ast.pred s, Literal_type.P);
           (match Ast.lnot eia with
            | Eia eia ->
              th_map
              := (match
                    Map.add
                      !th_map
                      ~key:(Eia (SimplII.normalize eia))
                      ~data:(Ast.pred s, Literal_type.N)
                  with
                   | `Ok th_map -> th_map
                   | `Duplicate -> !th_map)
            | _ -> ());
           bool_map := Map.add_exn !bool_map ~key:s ~data:eia;
           Ast.pred s)
      | None ->
        failwith
          (Format.asprintf
             "Unexpected state: unable to find a predicate for %a, available keys: %a"
             Ast.pp_smtlib2
             eia
             (Format.pp_print_list Ast.pp_smtlib2)
             (Map.keys !th_map))
    in
    try
      Ast.map
        (function
          | Eia _ as ast -> eia_to_bool ?allow_new ast
          | Unsupp (`Check _) as ast -> eia_to_bool ?allow_new ast
          | (True | Land _ | Lnot _ | Lor _ | Exists _ | Pred _ | Unsupp _) as ast -> ast)
        ast
    with
    | expr ->
      Debug.trace
        "DPLL"
        "Error while skeletoning the formula %s"
        (Printexc.to_string expr);
      raise_notrace expr
  in
  let bool_to_eia s =
    match Map.find !bool_map s with
    | Some eia -> eia
    | None ->
      Format.kasprintf
        failwith
        "Unexpected state: predicate %s is in the original definition"
        s
  in
  let of_bool_model ~map z3_model =
    Hashtbl.fold
      (fun sym value acc ->
         match value with
         | Smtml.Value.True -> map (Fe.sym_to_pred sym) :: acc
         | Smtml.Value.False -> Ast.lnot (map (Fe.sym_to_pred sym)) :: acc
         | _ -> acc)
      z3_model
      []
    |> Ast.land_
  in
  let unsat_reason = ref "bool" in
  let can_be_unk = ref false in
  Debug.trace "DPLL" "Theory ast: %a\n%!" Ast.pp_smtlib2 ast;
  let assumptions = ast |> to_bool_skeleton ~allow_new:true in
  let rec dpll new_assumptions solver =
    Debug.trace "DPLL" "Into Z3 added: %a%!" Ast.pp_smtlib2 new_assumptions;
    Z3.add solver [ new_assumptions |> Fe.of_ast ];
    match Z3.check solver ~assumptions:[] with
    | `Sat ->
      let model = Z3.model solver |> Option.get |> Smtml.Z3_mappings.values_of_model in
      let skeletoned_candidate = of_bool_model ~map:Ast.pred model in
      let candidate = of_bool_model ~map:bool_to_eia model in
      Debug.trace "DPLL" "Trying %a%!" Ast.pp_smtlib2 candidate;
      (match check_sat candidate with
       | Sat (s, _) as result ->
         report_result ~verbose (`Sat s);
         result
       | Unsat (s, core) ->
         (*Debug.trace "DPLL" "Unsat core: %a\n%!" Ast.pp_smtlib2 core;*)
         unsat_reason := reason s !unsat_reason;
         let unsat_core_contra_sat_ast =
           if core = Lnot True
           then Ast.lnot skeletoned_candidate
           else (
             try
               let ast = Ast.lnot (to_bool_skeleton ~allow_new:false core) in
               Debug.trace "DPLL" "Outer DPLL unsat core: %a\n%!" Ast.pp_smtlib2 core;
               ast
             with
             | _ -> Ast.lnot skeletoned_candidate)
         in
         dpll unsat_core_contra_sat_ast solver
       | Unknown _ ->
         can_be_unk := true;
         let unsat_core_contra_sat_ast = Ast.lnot skeletoned_candidate in
         dpll unsat_core_contra_sat_ast solver)
    | `Unsat ->
      Debug.trace "DPLL" "Bool unsat found\n%!";
      if !can_be_unk
      then (
        report_result ~verbose (`Unknown "");
        unknown Ast.true_ Env.empty)
      else (
        report_result ~verbose (`Unsat !unsat_reason);
        unsat !unsat_reason Ast.true_)
    | `Unknown ->
      Debug.trace "DPLL" "Z3 SAT-solver gives 'unknown'\n%!";
      unknown Ast.true_ Env.empty
  in
  (* Debug.trace "DPLL" "Theory ast: %a\n%!" Ast.pp_smtlib2 ast; *)
  dpll
    assumptions
    (Z3.make
       ~params:Smtml.Params.(default () $ (Timeout, z3_timeout_ms) $ (Random_seed, 42))
       ())
;;

let rec check_sat ?(verbose = false) (tys : Model.tys) ast : rez =
  let report_result2 s = report_result ~verbose s in
  let check_nfa_sat ast e =
    trace_log "Checking nfa sat (ast = %a)\n%!" Ast.pp_smtlib2 ast;
    Debug.trace "NFA" "Ast to NFA Solver: %a" Ast.pp_smtlib2 ast;
    match Me.ir_of_ast e ast with
    | Ok ir ->
      let ir = ir |> Ir.simpl |> Ir.simpl_ineq in
      let e, ir = if config.simpl_mono then Ir.simpl_monotonicty e ir else e, ir in
      let ir = if config.simpl_alpha then Simpl_alpha.simplify ir else ir in
      (match ir with
       | Lib.Ir.True -> sat "simpl" ast ~env:e
       | Lnot True -> unsat "simpl" ast
       | _ ->
         if config.dump_simpl then Format.printf "%a\n%!" Ir.pp_smtlib2 ir;
         if config.stop_after = `Simpl then exit 0;
         trace_log "Starting NFA Solver ...\n%!";
         (match Solver.check_sat ir with
          | `Sat get_model -> sat "nfa" ast ~env:e ~get_model
          | `Unsat -> unsat "nfa" ast
          | `Unknown _ir -> unknown ast e))
    | Error s ->
      report_result2 (`Unknown (Format.sprintf "(nfa) %s" s));
      exit 0
  in
  let ( <+> ) =
    fun rez f ->
    match rez with
    | Unknown (ast, e) -> f ast e
    | Unsat _ as rez -> rez
    | Sat _ -> rez
  in
  let lift desc ast = function
    | `Sat e -> sat desc ast ~env:e
    | `Unsat core -> unsat desc core
    | `Unknown (ast, e) -> unknown ast e
  in
  let check_eia_sat ast e =
    trace_log "Checking eia sat (ast = %a)\n%!" Ast.pp_smtlib2 ast;
    let can_be_unk = ref false in
    let apporx_rez =
      unknown ast e
      <+> (fun ast e ->
      if not config.pre_simpl
      then unknown ast e
      else lift "presimpl int" ast (SimplII.run_basic_simplify ~env:e ast))
      <+> (fun ast e ->
      if config.dump_pre_simpl then Format.printf "@[%a@]\n%!" Ast.pp_smtlib2 ast;
      unknown ast e)
      <+> (fun ast e ->
      if config.stop_after = `Pre_simplify then exit 0 else unknown ast e)
      <+> (fun ast e ->
      if config.under_approx >= 0
      then (
        let merge =
          Env.merge
            ~sf:(fun ~key:_ ~data1 ~data2:_ -> data1)
            ~zf:(fun ~key:_ ~data1 ~data2:_ -> data1)
        in
        match Underapprox.check config.under_approx ast with
        | `Sat (s, e0) -> sat s ast ~env:(merge e0 e)
        | `Unsat s -> unsat s ast
        | `Unknown _ -> unknown ast e)
      else unknown ast e)
      <+> (fun ast e ->
      if config.over_approx
      then (
        match Overapprox.check ast with
        | `Sat _ -> unknown ast e
        | `Unsat -> unsat "over" ast
        | `Unknown ast -> unknown ast e)
      else unknown ast e)
      <+> fun ast e ->
      match SimplII.has_unsupported_nonlinearity ast with
      | Result.Ok () -> unknown ast e
      | Error terms ->
        trace_log "@[<v 2>";
        trace_log "@[Non linear arithmetic between@]@,";
        List.iteri (fun i -> trace_log "@[%d) %a@]@," i Ast.pp_term_smtlib2) terms;
        trace_log "@]@,";
        if config.logic = `Eia
        then (
          match SimplII.check_nia e ast with
          | `Sat env -> sat "nia" ast ~env
          | `Unsat -> unsat "nia" ast
          | `Unknown ->
            report_result2 (`Unknown "nia");
            exit 0)
        else unknown ast e
    in
    match apporx_rez with
    | Unknown (ast, e) ->
      if config.mode = `Msb
      then check_nfa_sat ast e
      else (
        let asts_nat = Ast.to_nat ast in
        trace_log "To IN gives %d asts..." (List.length asts_nat);
        let check ast =
          trace_log "Over IN: %a\n" Ast.pp_smtlib2 ast;
          match check_nfa_sat ast e with
          | Sat (s, (ast, env, get_model, regexes)) ->
            Some (s, ast, env, get_model, regexes)
          | Unknown _ ->
            can_be_unk := true;
            None
          | Unsat _ -> None
        in
        match List.find_map check asts_nat with
        | Some (s, ast, env, get_model, regexes) -> sat s ast ~env ~get_model ~regexes
        | None -> if !can_be_unk then unknown ast Env.empty else unsat "nfa" ast)
    | _ -> apporx_rez
  in
  let check_string_sat env ast =
    trace_log "Checking string sat (ast = %a)\n%!" Ast.pp_smtlib2 ast;
    let open Ast in
    let open Ast.Eia in
    let split_vars =
      let non_num v = eia (leq (iofs (Atom (var v S))) (Const Z.minus_one)) in
      Ast.get_stoi_conc_vars ast
      |> List.map (fun var -> lor_ [ non_num var; lnot (non_num var) ])
    in
    let can_be_unk = ref false in
    let ast = SimplII.unfold_neq ast in
    let ast = if config.light_dpll then ast else land_ (ast :: split_vars) in
    trace_log "After string approximations: %a\n%!" pp_smtlib2 ast;
    if config.stop_after == `Pre_dpll
    then unknown ast Env.empty
    else (
      (*report_result
          (`Unknown
              (Format.asprintf
                 "has partially supported operations: %a"
                 (Format.pp_print_list Ast.pp_smtlib2)
                 unsupported));*)
      let arithmetize_and_check env ast =
        let ast =
          Ast.map
            (function
              | Lnot (Unsupp (`Check _)) -> Ast.true_
              | ast -> ast)
            ast
        in
        let post =
          Ast.fold
            (fun acc -> function
               | Unsupp (`Check p) -> p :: acc
               | _ -> acc)
            []
            ast
        in
        let ast =
          Ast.map
            (function
              | Unsupp (`Check _) -> Ast.true_
              | ast -> ast)
            ast
        in
        let ast' = ast in
        let ast, unsupported =
          SimplII.extract_and_filter_unsupported_atomic_formulas ast'
        in
        if not (List.is_empty unsupported)
        then (
          trace_log "Filtered assertions: %a\n%!" Ast.pp_smtlib2 ast;
          trace_log
            "Unsupported assertions: %a\n%!"
            (Format.pp_print_list pp_smtlib2)
            unsupported);
        match Overapprox.check_length_core ast' with
        | `Unsat core ->
          Debug.trace "Length" "Length overapprox unsat, core = %a" Ast.pp_smtlib2 core;
          unsat "lengths" core
        | `Unknown ->
          let str_vars = Ast.collect_str_vars ast in
          trace_log "Run basic simplify (ast = %a)" Ast.pp_smtlib2 ast;
          (match
             begin match SimplII.run_basic_simplify ~env ast with
             | `Sat env ->
               trace_log "Basic simplify sat (ast = %a)" Ast.pp_smtlib2 ast;
               sat "presimpl str" ast ~env
             | `Unsat core ->
               trace_log "Basic simplify unsat (ast = %a)" Ast.pp_smtlib2 ast;
               unsat "presimpl str" core
             | `Unknown (ast, env) ->
               trace_log
                 "Basic simplify unknown (ast = %a, env = %a)"
                 Ast.pp_smtlib2
                 ast
                 (Env.pp ~title:"")
                 env;
               let orig_ast = ast in
               let arithmetized_asts = SimplII.arithmetize str_vars ast env in
               fold_until_sat
                 (fun acc (ast, e, regexes) ->
                    trace_log "Arithmetized: %a\n" Ast.pp_smtlib2 ast;
                    match acc with
                    | Sat _ as rez -> rez
                    | Unknown _ | Unsat _ ->
                      let unsat_or_unknown rez =
                        match acc with
                        | Sat _ -> assert false
                        | Unknown _ as rez -> rez
                        | Unsat _ -> rez
                      in
                      (match check_eia_sat ast e with
                       | Sat (s, (ast, env, get_model, _)) -> begin
                         let env = Env.merge_exn env e in
                         let result = sat s ast ~env ~get_model ~regexes in
                         if List.is_empty post
                         then result
                         else (
                           match get_model tys with
                           | Result.Ok model ->
                             let model = construct_model tys env model regexes in
                             begin
                               let ( let* ) = Option.bind in
                               match
                                 List.fold_left
                                   (fun acc post ->
                                      let* acc = acc in
                                      match
                                        post model orig_ast regexes (fun ast ->
                                          match (check_sat tys) ast with
                                          | Sat (_, (_, env, get_model, regexes)) ->
                                            `Sat
                                              (fun () ->
                                                begin
                                                  let intm_model =
                                                    calculate_model
                                                      tys
                                                      env
                                                      (get_model tys |> Result.get_ok)
                                                      regexes
                                                  in
                                                  intm_model
                                                end)
                                          | _ -> `Unknown)
                                      with
                                      | `Sat get_model ->
                                        Some
                                          (fun () ->
                                            let model1 = acc () in
                                            let model2 = get_model () in
                                            (* Can be not disjoint. *)
                                            merge_models model1 model2)
                                      | `Unknown -> None)
                                   (Some (fun () -> Map.empty))
                                   post
                               with
                               | Some get_model' ->
                                 let get_model tys =
                                   let model1 = get_model tys |> Result.get_ok in
                                   let model2 = get_model' () in
                                   Result.ok (merge_models model1 model2)
                                 in
                                 sat s ast ~env ~get_model ~regexes
                               | None ->
                                 can_be_unk := true;
                                 unknown ast Env.empty
                             end
                           | Result.Error _ ->
                             can_be_unk := true;
                             unknown ast Env.empty)
                         end
                       | Unknown _ as rez -> rez
                       | Unsat _ as rez -> unsat_or_unknown rez))
                 (Unsat ("", ast))
                 arithmetized_asts
             end
           with
           | Unsat (_, ast) when not (List.is_empty unsupported) ->
             Unknown (ast, Env.empty)
           | _ as rez -> rez)
      in
      let light_dpll check_sat env ast =
        let module Z3 = Smtml.Z3_mappings.Solver in
        let non_num v = pred (String.concat "" [ "s"; v ]) in
        let num v = pred (String.concat "" [ "n"; v ]) in
        let empty v = pred (String.concat "" [ "e"; v ]) in
        let split_vars_skeleton =
          get_stoi_conc_vars ast
          |> List.map (fun var -> lxor_ [ non_num var; num var; empty var ])
          |> Ast.land_
          |> Fe.of_ast
        in
        let empty v = eia (eq (Atom (var v S)) (Str_const "") S) in
        let str_vars_skeleton_of_bool z3_model =
          Hashtbl.fold
            (fun sym value acc ->
               let sym = Fe.sym_to_pred sym in
               match value with
               | Smtml.Value.False -> acc
               | Smtml.Value.True -> Ast.pred sym :: acc
               | _ -> acc)
            z3_model
            []
        in
        let can_be_unk = ref false in
        let str_vars_of_bool_model z3_model =
          Hashtbl.fold
            (fun sym value acc ->
               let sym = Fe.sym_to_pred sym in
               let c = String.unsafe_get sym 0 in
               let sym' = String.sub sym 1 (String.length sym - 1) in
               match value, sym with
               | Smtml.Value.False, _ -> acc
               | _, _ when c = 's' -> non_num sym' :: acc
               | _, _ when c = 'n' -> Ast.lnot (non_num sym') :: acc
               | _, _ when c = 'e' -> empty sym' :: acc
               | _ -> acc)
            z3_model
            []
        in
        let rec aux solver env =
          match Z3.check ~assumptions:[] solver with
          | `Sat ->
            let model =
              Z3.model solver |> Option.get |> Smtml.Z3_mappings.values_of_model
            in
            let str_vars_skeleton = Ast.land_ (str_vars_skeleton_of_bool model) in
            let str_vars_of_bool_model = str_vars_of_bool_model model in
            let ast' = Ast.land_ (ast :: str_vars_of_bool_model) in
            begin
              trace_log
                "trying str_vars %a"
                Ast.pp_smtlib2
                (Ast.land_ str_vars_of_bool_model);
              match SimplII.run_basic_simplify ~env ast' with
              | `Sat _ as rez -> lift "simpl" ast rez
              | `Unsat core -> begin
                let afs =
                  match core with
                  | Ast.Land xs -> xs
                  | x -> [ x ]
                in
                let common_afs =
                  Set.of_list afs |> Set.inter (Set.of_list str_vars_of_bool_model)
                in
                let real_unsat_core =
                  if Set.is_empty common_afs
                  then str_vars_skeleton
                  else (
                    let ast =
                      land_
                        (Set.to_list common_afs
                         |> List.map
                              (let open Ast.Eia in
                               let open Ast in
                               function
                               | Eia (Eq (Atom (Var (vn, S)), Str_const "", S)) ->
                                 empty vn
                               | Eia
                                   (Leq
                                      (Mul [ Const d; Iofs (Atom (Var (vn, S))) ], Const c))
                                 when c = Z.zero && d = Z.minus_one -> num vn
                               | Eia
                                   (Leq
                                      (Add [ Const d; Iofs (Atom (Var (vn, S))) ], Const c))
                                 when c = Z.zero && d = Z.one -> non_num vn
                               | a -> failwith (Format.asprintf "%a" Ast.pp_smtlib2 a)))
                    in
                    Debug.trace
                      "DPLL"
                      "Inner dpll unsat core: %a"
                      Ast.pp_smtlib2
                      (Ast.land_ (Set.to_list common_afs));
                    ast)
                in
                Z3.add solver [ Ast.lnot real_unsat_core |> Fe.of_ast ];
                aux solver env
                end
              (*| `Unknown (Lnot True, _) ->
              Z3.add solver [ (Ast.lnot str_vars_skeleton) |> Fe.of_ast ];
              aux solver env*)
              | `Unknown (_, _) ->
                begin match check_sat env ast' with
                | Sat _ as rez -> rez
                | Unknown _ ->
                  can_be_unk := true;
                  Z3.add solver [ Ast.lnot str_vars_skeleton |> Fe.of_ast ];
                  aux solver env
                | Unsat _ ->
                  Z3.add solver [ Ast.lnot str_vars_skeleton |> Fe.of_ast ];
                  aux solver env
                end
            end
          | `Unknown ->
            (* Z3 gave up on the boolean skeleton (e.g. hit the timeout); the
               outer [dpll] degrades to unknown here too. *)
            Debug.trace "DPLL" "Z3 SAT-solver gives 'unknown'\n%!";
            unknown ast Env.empty
          | `Unsat when !can_be_unk -> unknown ast Env.empty
          | `Unsat -> Unsat ("todo", ast)
        in
        let z3_light =
          Z3.make
            ~params:
              Smtml.Params.(default () $ (Timeout, z3_timeout_ms) $ (Random_seed, 42))
            ()
        in
        Z3.add z3_light [ split_vars_skeleton ];
        aux z3_light env
      in
      let light_dpll = if config.light_dpll then light_dpll else Fun.id in
      match dpll (light_dpll arithmetize_and_check env) ~verbose:false ast with
      | Sat _ as rez -> rez
      | Unknown _ as rez -> rez
      | Unsat _ as rez when not !can_be_unk -> rez
      | Unsat (_reason, ast) -> unknown ast Env.empty)
  in
  let handle =
    fun result f ->
    match result with
    | Sat (s, _) as rez ->
      report_result2 (`Sat s);
      rez
    | Unsat (s, _) as rez ->
      report_result2 (`Unsat s);
      rez
    | Unknown _ -> f ()
  in
  try
    if config.logic = `Str || config.logic = `StrBv
    then (
      let unsat_reason = ref "presimpl str" in
      let can_be_unk = ref false in
      try
        match SimplII.run_string_simplify ast with
        | `Sat e ->
          report_result2 (`Sat "presimpl str");
          sat "presimpl str" ast ~env:e
        | `Unsat core ->
          report_result2 (`Unsat "presimpl str");
          unsat "presimpl str" core
        | `Unknown (ast, e, seq_of_variants) ->
          (match SimplII.run_length_simplify e ast with
           | `Unknown ast ->
             (match Overapprox.check_length ast with
              | `Unsat ->
                report_result2 (`Unsat "lengths");
                unsat "lengths" ast
              | `Unknown _ ->
                begin if Seq.is_empty seq_of_variants
                then
                  handle (check_string_sat e ast) (fun () ->
                    report_result2 (`Unknown "nfa");
                    unknown ast Env.empty)
                else
                  (* Under-approximations first: cheap, they can only answer [Sat],
                     and the sequence ends with [[ ast, e ]] -- the original problem
                     -- so nothing is lost by not running the full check eagerly. *)
                  handle (unknown ast e) (fun () ->
                    (* Budget the under-approximations. They can only answer [Sat], so
                       on an unsatisfiable formula every second spent here is lost --
                       but the answers they do find come almost immediately. The
                       deadline is checked between variants; the full problem is
                       appended afterwards and is never skipped. *)
                    let deadline =
                      if config.under_str_budget < 0.0
                      then infinity
                      else Unix.gettimeofday () +. config.under_str_budget
                    in
                    let in_budget () = Unix.gettimeofday () < deadline in
                    seq_of_variants
                    |> Seq.take_while (fun _ -> in_budget ())
                    |> (fun x -> Seq.append x (Seq.return [ ast, e ]))
                    |> Seq.find_map (fun variants ->
                      List.find_map
                        (fun (ast, env) ->
                           match check_string_sat env ast with
                           | Unsat (s, _) ->
                             unsat_reason := reason s !unsat_reason;
                             None
                           | Sat (reason, _) as s ->
                             report_result2 (`Sat reason);
                             Some s
                           | Unknown _ ->
                             can_be_unk := true;
                             None)
                        variants)
                    |> fun v ->
                    match v, !can_be_unk with
                    | Some v, _ -> v
                    | None, true ->
                      if !Config.bounded_unsat
                      then (
                        trace_log
                          "Can't decide with bres=%d and bstates=%d\n%!"
                          config.bound_res
                          config.bound_states;
                        raise Lics_Underapprox_unsuccessful)
                      else (
                        report_result2 (`Unknown "");
                        unknown ast Env.empty)
                    | None, false ->
                      report_result2 (`Unsat !unsat_reason);
                      Unsat (!unsat_reason, ast))
                end)
           | `Unsat core ->
             report_result2 (`Unsat "presimpl str");
             unsat "presimpl str" core)
      with
      | SimplII.Str_Underapprox_fired env ->
        let s = "under str" in
        report_result2 (`Sat s);
        sat s ast ~env)
    else (
      (* Standard [**] semantics: the engine's partial Pow relation is exact
         only on nonnegative exponents, so powers it cannot express are
         totalized by [std_exp_split] into guarded sign/parity disjunctions,
         and the formula is decided on that split form -- sound by
         construction. Formulas the split leaves unchanged (all exponents
         provably nonnegative, or no powers at all) go straight through the
         regular pipeline. *)
      let ast_split = SimplII.std_exp_split ast in
      let fallback ast =
        fun () ->
        report_result2 (`Unknown "nfa");
        unknown ast Env.empty
      in
      (* A model coming out of a per-branch pipeline run (below) needs
         confirmation: the pipeline's model export can be partial, and its
         simplifier applies exponent laws (b^i * b^j = b^(i+j),
         c * b^(e-1) = (c/b) * b^e) whose in-branch soundness rests on the
         sign guards, so a Sat is only accepted once the model provably
         satisfies the *original* formula. The check is a ground evaluator
         independent of the simplifier -- the legacy laws live there, so a
         model check that reuses it would vouch for itself. Everything the
         evaluator cannot decide counts as unconfirmed. *)
      let confirmed = function
        | Sat (_, (_, env, get_model, _)) ->
          let pins = Hashtbl.create 8 in
          (* Variables eliminated by substitution are bound to *terms* in
             the env (e.g. y := 2^z * (1 + 2^u)); collect those separately
             and evaluate them on demand, or the evaluator would default a
             determined variable to 0 and refute the genuine model. *)
          let defs : (string, Z.t Ast.Eia.term) Hashtbl.t = Hashtbl.create 8 in
          Env.fold env ~init:() ~f:(fun ~key ~data () ->
            match data with
            | Ast.TT (Ast.I, Ast.Eia.Const c) -> Hashtbl.replace pins key c
            | Ast.TT (Ast.I, t) -> Hashtbl.replace defs key t
            | _ -> ());
          (match get_model tys with
           | Result.Ok model ->
             Map.iteri model ~f:(fun ~key ~data ->
               match data with
               | `Int c -> Hashtbl.replace pins key c
               | `Str _ -> ())
           | Result.Error _ -> ());
          let visiting = Hashtbl.create 8 in
          let rec term : Z.t Ast.Eia.term -> Z.t option = function
            | Ast.Eia.Const c -> Some c
            | Ast.Eia.Atom (Ast.Var (v, Ast.I)) ->
              (match Hashtbl.find_opt pins v with
               | Some c -> Some c
               | None ->
                 (* Unpinned variables default to 0: a total assignment
                    that evaluates to true is a genuine model wherever its
                    values came from, and partial solver models leave
                    exactly the don't-care variables out. A failed or
                    cyclic env definition degrades to the same default,
                    which can only make confirmation fail, never lie. *)
                 let fallback = Z.zero in
                 (match Hashtbl.find_opt defs v with
                  | Some t when not (Hashtbl.mem visiting v) ->
                    Hashtbl.replace visiting v ();
                    let r = term t in
                    Hashtbl.remove visiting v;
                    let c = Option.value ~default:fallback r in
                    Hashtbl.replace pins v c;
                    Some c
                  | _ -> Some fallback))
            | Ast.Eia.Add ts ->
              List.fold_left
                (fun acc t ->
                   match acc, term t with
                   | Some a, Some b -> Some (Z.add a b)
                   | _ -> None)
                (Some Z.zero)
                ts
            | Ast.Eia.Mul ts ->
              List.fold_left
                (fun acc t ->
                   match acc, term t with
                   | Some a, Some b -> Some (Z.mul a b)
                   | _ -> None)
                (Some Z.one)
                ts
            | Ast.Eia.Mod (t, z) -> Option.map (fun v -> Z.erem v z) (term t)
            | Ast.Eia.Pow (b, e) ->
              (match term b, term e with
               | Some b, Some e ->
                 if Z.(geq e zero)
                 then
                   if Z.(gt e (of_int 131072)) && Z.(gt (abs b) one)
                   then None
                   else Some (Utils.powz ~base:b e)
                 else if Z.(equal (abs b) one)
                 then Some (if Z.is_even e then Z.one else b)
                 else Some Z.zero
               | _ -> None)
            | _ -> None
          in
          let rec ph : Ast.t -> bool option = function
            | Ast.True -> Some true
            | Ast.Land xs ->
              List.fold_left
                (fun acc x ->
                   match acc, ph x with
                   | Some a, Some b -> Some (a && b)
                   | _ -> None)
                (Some true)
                xs
            | Ast.Lor xs ->
              List.fold_left
                (fun acc x ->
                   match acc, ph x with
                   | Some a, Some b -> Some (a || b)
                   | _ -> None)
                (Some false)
                xs
            | Ast.Lnot x -> Option.map not (ph x)
            | Ast.Eia (Ast.Eia.Eq (l, r, Ast.I)) ->
              (match term l, term r with
               | Some l, Some r -> Some (Z.equal l r)
               | _ -> None)
            | Ast.Eia (Ast.Eia.Neq (l, r, Ast.I)) ->
              (match term l, term r with
               | Some l, Some r -> Some (not (Z.equal l r))
               | _ -> None)
            | Ast.Eia (Ast.Eia.Leq (l, r)) ->
              (match term l, term r with
               | Some l, Some r -> Some (Z.leq l r)
               | _ -> None)
            | _ -> None
          in
          let rez = ph ast in
          if Sys.getenv_opt "CHRO_CONFIRM_DEBUG" <> None
          then
            Printf.eprintf
              "[confirm] pins=%s ph=%s\n%!"
              (Hashtbl.fold (fun k v acc -> acc ^ k ^ "=" ^ Z.to_string v ^ " ") pins "")
              (match rez with
               | Some true -> "true"
               | Some false -> "false"
               | None -> "none");
          rez = Some true
        | Unsat _ | Unknown _ -> false
      in
      (* A branch unsat whose minimized core contains no power at all is
         trusted: the deletion-based minimization re-verifies the core by
         itself, and no rewrite manufactures powers out of pow-free atoms,
         so that derivation holds under any pow semantics. Cores that do
         mention powers may rest on the legacy laws and are not trusted. *)
      let pow_free ph =
        not
          (Ast.fold
             (fun acc -> function
                | Ast.Eia eia ->
                  acc
                  || Ast.Eia.fold2
                       (fun acc -> function
                          | Ast.Eia.Pow _ -> true
                          | _ -> acc)
                       (fun acc _ -> acc)
                       false
                       eia
                | _ -> acc)
             false
             ph)
      in
      (* Try a small case enumeration over the split's definition
         disjunctions before the heavy pipeline. Every disjunct of the split
         formula either carries its sign/parity guards or is power-free, so
         the simplifier's verdict on a branch conjunction is exact: unsat on
         every branch proves unsat, and any branch model is a model. Falls
         through on an undecided branch or a large product. *)
      let solve_split () =
        let members =
          match ast_split with
          | Ast.Land xs -> xs
          | ph -> [ ph ]
        in
        let defs, core =
          List.partition
            (function
              | Ast.Lor _ -> true
              | _ -> false)
            members
        in
        (* The branch count is computed before materializing the product:
           formulas bring their own disjunctions, and an eager cartesian
           product over dozens of them allocates itself to death long
           before any size check could reject it. *)
        let branch_count =
          List.fold_left
            (fun acc -> function
               | Ast.Lor arms when acc <= 16 -> acc * List.length arms
               | _ -> acc)
            1
            defs
        in
        let quick =
          (* Also size-gated: a branch conjunction goes through the full
             simplifier fixpoint, which on CHC-sized inputs costs seconds
             per branch. *)
          if List.is_empty defs || branch_count > 16 || List.length core > 40
          then None
          else (
            let branches =
              List.fold_left
                (fun acc -> function
                   | Ast.Lor arms ->
                     List.concat_map
                       (fun sel -> List.map (fun arm -> arm :: sel) arms)
                       acc
                   | _ -> acc)
                [ [] ]
                defs
            in
            (* Branches are scanned with early exits: a Sat branch is a
               model, and only an all-Unsat scan proves unsat -- so the
               first undecided branch aborts the enumeration rather than
               burning a full simplifier run per remaining branch. *)
            let rec scan = function
              | [] -> Some (unsat "presimpl int" ast_split)
              | sel :: rest ->
                (match
                   SimplII.run_basic_simplify ~minimize:false (Ast.land_ (core @ sel))
                 with
                 | `Sat env -> Some (sat "presimpl int" ast_split ~env)
                 | `Unsat _ -> scan rest
                 | `Unknown _ ->
                   (* The presimpl scan cannot decide branches that keep real
                      powers, but splitting also costs the engine its exponent
                      laws: substituting the fresh result variable turns
                      2^z * (1 + 2^u) into the var-by-var product
                      2^z * (1 + r), which no automaton expresses -- while
                      inside this branch the sign guards make the laws sound
                      on the *unsplit* conjunction. So the full pipeline runs
                      on the branch, and its verdicts are vetted: Sat only if
                      the ground evaluator confirms it against the original
                      formula, unsat only on a pow-free core. *)
                   let branch = Ast.land_ (core @ sel) in
                   if not (SimplII.engine_pows_only branch)
                   then None
                   else (
                     match
                       try Some (check_eia_sat branch Env.empty) with
                       | _ -> None
                     with
                     | Some (Sat _ as rez) when confirmed rez -> Some rez
                     | Some (Unsat (_, ucore)) when pow_free ucore -> scan rest
                     | _ -> None))
            in
            scan branches)
        in
        match quick with
        | Some rez -> handle rez (fallback ast_split)
        | None -> handle (check_eia_sat ast_split Env.empty) (fallback ast_split)
      in
      if Stdlib.compare ast ast_split = 0
      then handle (check_eia_sat ast Env.empty) (fallback ast)
      else solve_split ())
  with
  | Lics_Underapprox_unsuccessful -> raise Lics_Underapprox_unsuccessful
  | Nfa.Too_big_nfa ->
    report_result2 (`Unknown "too big nfa during the computations");
    unknown ast Env.empty
  | s ->
    if config.quiet == true
    then (
      report_result2 (`Unknown "");
      unknown ast Env.empty)
    else raise s
;;

let check_model tys (ast : Ast.t) (model : Model.t) =
  let ast =
    Map.fold
      ~init:ast
      ~f:(fun ~key ~data ast ->
        let open Ast in
        let ast' =
          match data with
          | `Int c -> eia (Eia.eq (Eia.atom (var key I)) (Ast.Eia.const c) I)
          | `Str c -> eia (Eia.eq (Eia.atom (var key S)) (Ast.Eia.str_const c) S)
        in
        Ast.land_ [ ast'; ast ])
      model
  in
  smt_status := Some `Unknown;
  trace_log "Checking model correctness;\n  ast=%a\n%!" Ast.pp_smtlib2 ast;
  try
    begin match check_sat tys ast with
    | Sat _ -> ()
    | Unsat _ -> Printf.eprintf "(error: model check has failed; incorrect model)\n%!"
    | Unknown _ -> Printf.eprintf "(warning: the correctness of model is unknown)\n%!"
    end
  with
  | ex ->
    Printf.eprintf "(info: unable to check the model: %s)\n%!" (Printexc.to_string ex)
;;

type state =
  { asserts : Ast.t list
  ; prev : state option
  ; last_result : rez option
  ; tys : Model.tys
  }

let () =
  let f =
    match Fpath.of_string config.input_file with
    | Result.Error (`Msg msg) ->
      Format.eprintf "%s\n%!" msg;
      exit 1
    | Ok file -> Smtml.Parse.from_file file
  in
  let exec ({ prev; _ } as state) =
    let get_model ?(noprint = false) ast (rez : rez) =
      let rec merge_tys state =
        match state.prev with
        | Some state' ->
          Map.merge
            ~f:(fun ~key:_ -> function
               | `Left x -> Some x
               | `Right x -> Some x
               | `Both (x, _) -> Some x)
            state.tys
            (merge_tys state')
        | None -> state.tys
      in
      let printf = if not noprint then Format.printf else fun _ -> () in
      let print_model = if not noprint then print_model else fun _ -> () in
      match rez with
      | Unknown _ | Unsat _ -> printf "no model"
      | Sat (_, (_, env, get_model, regexes)) ->
        sat_found := true;
        let tys = merge_tys state in
        let rec shrink_model ?len () =
          let attempt, len =
            if Option.is_some len then 2, Option.get len else 1, Config.huge_path ()
          in
          trace_log "model is TOO big after %d attempt\n%!" attempt;
          let shrinked_ast =
            Map.fold ~init:[ ast ] state.tys ~f:(fun ~key ~data acc ->
              match key, data with
              | v, `Str ->
                Ast.(eia (Eia.leq (Len (Atom (Var (v, S)))) (Const (Z.of_int len))))
                :: acc
              | v, `Int ->
                Ast.(
                  eia
                    (Eia.leq
                       (Atom (Var (v, I)))
                       (Const
                          Z.(pow (Z.of_int !Lib.Config.base) (Lib.Config.huge_const ())))))
                :: acc)
            |> Lib.Ast.land_
          in
          trace_log "Shrinked AST: @[%a@]\n%!" Ast.pp_smtlib2 shrinked_ast;
          config.under_approx <- -1;
          try
            match check_sat tys shrinked_ast with
            | Unknown _ | Unsat _ -> printf "no short model\n%!"
            | Sat (_, (_, env, get_model, _regexes)) ->
              (* let tys = merge_tys state in *)
                (match get_model tys with
                 | Result.Ok model ->
                   let model = calculate_model tys env model regexes in
                   print_model model;
                   if config.check_model then check_model tys ast model else ()
                 | Result.Error `Too_long -> printf "no short model\n%!"
                 | Result.Error `No_model -> assert false)
          with
          | Lics_Underapprox_unsuccessful ->
            config.bound_res <- -1;
            config.bound_states <- -1;
            shrink_model ~len:(Config.huge_const_for_model ()) ()
          | Nfa.Too_big_nfa ->
            if attempt == 1
            then shrink_model ~len:(Config.huge_const_for_model ()) ()
            else printf "no short model found (nfa)\n%!"
        in
        let () =
          try
            match
              try
                get_model tys
                |> Result.map (fun model ->
                  let model = calculate_model tys env model regexes in
                  print_model model;
                  if config.check_model then check_model tys ast model else ())
              with
              | Too_long_model | Solver.Too_long_model -> Result.error `Too_long
            with
            | Result.Ok () -> ()
            | Result.Error `Too_long -> shrink_model ()
            | Result.Error `No_model -> Format.printf "no model mode\n%!"
          with
          | Nfa.Too_big_nfa -> shrink_model ~len:(Config.huge_const_for_model ()) ()
        in
        ()
    in
    function
    | Smtml.Ast.Declare_const { id; sort; _ }
    | Smtml.Ast.Declare_fun { id; sort; args = [] } ->
      let id = Smtml.Symbol.to_string id in
      let sort = Smtml.Symbol.to_string sort in
      let tys =
        match sort with
        | "Int" -> Map.set ~key:id ~data:`Int state.tys
        | "String" -> Map.set ~key:id ~data:`Str state.tys
        | _ -> state.tys
      in
      { state with tys }
    | Smtml.Ast.Set_logic Smtml.Logic.QF_S ->
      config.logic <- (if Lib.Config.config.no_str_bv then `Str else `StrBv);
      (* config.under_approx <- 0; *)
      config.over_approx <- false;
      config.simpl_alpha <- false;
      config.simpl_mono <- true;
      config.base <- Some 10;
      (* config.pre_simpl <- false; *)
      state
    | Smtml.Ast.Push _ ->
      { asserts = []; prev = Some state; last_result = None; tys = state.tys }
    | Smtml.Ast.Pop _ ->
      begin match prev with
      | Some state -> state
      | None -> failwith "Nothing to pop"
      end
    | Smtml.Ast.Check_sat exprs ->
      config.with_check_sat <- true;
      let expr_irs = List.map (Fe.to_ast state.tys) exprs in
      let rec get_ast { asserts; prev; _ } =
        match prev with
        | Some state -> asserts @ get_ast state
        | None -> asserts
      in
      let all_asserts = expr_irs @ get_ast state in
      let ast =
        Ast.land_ (if List.is_empty all_asserts then [ Ast.True ] else all_asserts)
      in
      Set.diff (Ast.collect_free_vars ast) (Set.of_list (Map.keys state.tys))
      |> Set.filter ~f:(Fun.negate is_internal)
      |> Set.iter ~f:(fun var -> Printf.eprintf "(error: unknown constant %s)\n%!" var);
      if config.logic = `Eia && Lib.Ast.is_str ast
      then config.logic <- (if Lib.Config.config.no_str_bv then `Str else `StrBv);
      let common_base = Lib.Ast.find_common_base ast |> Option.map Z.to_int in
      let () = Lib.Config.set_base ?ast_base:common_base () in
      trace_log "Base now is %d\n%!" !Lib.Config.base;
      (try
         if config.logic = `Eia && Ast.is_str ast
         then config.logic <- (if config.no_str_bv then `Str else `StrBv);
         let rez = check_sat ~verbose:true state.tys ast in
         if config.check_model then get_model ~noprint:true ast rez;
         { state with last_result = Some rez }
       with
       | Lics_Underapprox_unsuccessful ->
         config.bound_res <- -1;
         config.bound_states <- -1;
         Config.bounded_unsat := false;
         let rez = check_sat ~verbose:true state.tys ast in
         if config.check_model then get_model ~noprint:true ast rez;
         { state with last_result = Some rez }
       | exn ->
         Format.printf "unknown\n%!";
         Format.eprintf
           "(exception: %s)\n%s"
           (Printexc.to_string exn)
           (Printexc.get_backtrace ());
         state)
    | Smtml.Ast.Get_model ->
      if config.no_model = true
      then (
        Format.printf "no-model mode\n%!";
        state)
      else (
        let rec get_ast { asserts; prev; _ } =
          match prev with
          | Some state -> asserts @ get_ast state
          | None -> asserts
        in
        let ast = Lib.Ast.land_ (get_ast state) in
        if config.logic = `Eia && Lib.Ast.is_str ast
        then config.logic <- (if Lib.Config.config.no_str_bv then `Str else `StrBv);
        let common_base = Lib.Ast.find_common_base ast |> Option.map Z.to_int in
        let () = Lib.Config.set_base ?ast_base:common_base () in
        trace_log "Base now is %d\n%!" !Lib.Config.base;
        let rez =
          match state.last_result with
          | Some r -> r
          | None -> check_sat state.tys ast
        in
        get_model ast rez;
        state)
    | Smtml.Ast.Assert expr -> begin
      let ast = expr |> Fe.to_ast state.tys in
      { state with asserts = ast :: state.asserts }
      end
    | Smtml.Ast.Set_info e ->
      let open Smtml in
      (match Expr.view e with
       | Smtml.Expr.App ({ Smtml.Symbol.name = Smtml.Symbol.Simple ":status"; _ }, [ r ])
         ->
         let set_status ans = smt_status := Some ans in
         (match Smtml.Expr.view r with
          | Expr.Symbol { name = Smtml.Symbol.Simple "sat"; _ } -> set_status `Sat
          | Expr.Symbol { name = Smtml.Symbol.Simple "unsat"; _ } -> set_status `Unsat
          | Expr.Symbol { name = Smtml.Symbol.Simple "unknown"; _ } -> set_status `Unknown
          | Expr.Symbol { name = Smtml.Symbol.Simple "timeout"; _ } -> set_status `Unknown
          | _ -> Format.eprintf "(warning: invalid ':status' attribute)\n%!")
       | _ -> ());
      state
    | _ast ->
      (* Format.eprintf "skipped: @[%a@]\n%!" Smtml.Ast.pp ast; *)
      state
  in
  let solve_all () =
    let _ =
      try
        List.fold_left
          exec
          { asserts = []; prev = None; last_result = None; tys = Map.empty }
          (f |> Result.get_ok)
      with
      | Fe.UnsupportedException _ when Config.is_quiet () ->
        Format.eprintf "\027[31mFronted error\027[0m\n%!";
        exit 1
      | exn ->
        Format.printf "unknown\n%!";
        Format.eprintf
          "(toplevel-exception: %s)\n%s"
          (Printexc.to_string exn)
          (Printexc.get_backtrace ());
        exit 0
    in
    ()
  in
  if not config.parallel
  then solve_all ()
  else (
    (* Run both strategies at once and keep the first definitive answer.

       Separate processes rather than threads: the solver carries a lot of global
       mutable state -- fresh-name counters, the exponent cache, [smt_status] -- and
       Z3 contexts are not safe to share, so forking is what makes the two runs
       independent without auditing every one of them. *)
    (* The under-approximation children get a larger enumeration budget:
       spending seconds on candidate substitution is their whole purpose, and
       the racing normal child keeps unsat latency unaffected. Deep product
       witnesses (the stringfuzz [("0s", "0")] pairs) sit a few seconds into
       the now honestly-chunked rounds. Explicit -budget still wins. *)
    let deep_under () =
      config.under_str_all <- true;
      if Float.equal config.under_str_budget 1.0 then config.under_str_budget <- 4.0
    in
    let strategies =
      [ "under", deep_under
      ; ("normal", fun () -> ())
        (* Nielsen splitting is qualitatively stronger on word-equation
           suites -- it cracks RElnc timeouts that more time alone never
           does -- but ~10x slower on equations whose variables are pinned
           by str.to_int, so it races as its own strategy rather than
           being the default. Combined with the string underapproximation
           because that pairing dominates: on the RElnc timeout set it
           solves 40/42 (8 uniquely) where plain nielsen gets 34. *)
      ; ( "nielsen"
        , fun () ->
            config.nielsen <- true;
            deep_under () )
      ]
    in
    let children =
      List.map
        (fun (name, configure) ->
           let out = Filename.temp_file "chro-par-" ("-" ^ name) in
           (* Capture stderr per child as well: both children reach the
              diagnostics ((warning: check annotation ...), exceptions), and
              with stderr merely inherited every such line was printed once
              per child. The parent replays only the winner's. *)
           let err = Filename.temp_file "chro-par-" ("-" ^ name ^ "-err") in
           match Unix.fork () with
           | 0 ->
             let fd = Unix.openfile out [ Unix.O_WRONLY; Unix.O_TRUNC ] 0o600 in
             Unix.dup2 fd Unix.stdout;
             let fd_err = Unix.openfile err [ Unix.O_WRONLY; Unix.O_TRUNC ] 0o600 in
             Unix.dup2 fd_err Unix.stderr;
             configure ();
             solve_all ();
             (* [Unix._exit] skips [at_exit], which is what normally flushes the
                Format buffers -- and e.g. "no model" is printed without [%!],
                so without this it never reaches the file. *)
             Format.pp_print_flush Format.std_formatter ();
             Format.pp_print_flush Format.err_formatter ();
             Stdlib.flush Stdlib.stdout;
             Stdlib.flush Stdlib.stderr;
             Unix._exit 0
           | pid -> pid, (out, err))
        strategies
    in
    let read_file p =
      try In_channel.with_open_bin p In_channel.input_all with
      | _ -> ""
    in
    (* Under [CHRO_DEBUG] the capture must not swallow the traces: the winner's
       replay only ever shows one strategy, and a timeout or Ctrl-C used to
       show nothing at all -- which is exactly when the traces are wanted.
       Everything goes to stderr, bannered per strategy, so the answer on
       stdout stays machine-readable. *)
    let dump_captured () =
      if Debug.flag ()
      then
        List.iter2
          (fun (name, _) (_, (out, err)) ->
             Printf.eprintf "--- %s: captured stdout ---\n%s" name (read_file out);
             Printf.eprintf "--- %s: captured stderr ---\n%s%!" name (read_file err))
          strategies
          children
    in
    (* [timeout] and Ctrl-C signal only this process, so without this the children
       outlive the parent as orphans -- which, run across a benchmark suite, piles up
       until the machine runs out of memory. *)
    let () =
      let terminate _ =
        List.iter
          (fun (pid, _) ->
             try Unix.kill pid Sys.sigkill with
             | _ -> ())
          children;
        dump_captured ();
        (* Keep the report the toplevel SIGTERM handler (which this one
           overrides) would have given. *)
        print_endline "timeout";
        Stdlib.exit 1
      in
      Sys.set_signal Sys.sigterm (Sys.Signal_handle terminate);
      Sys.set_signal Sys.sigint (Sys.Signal_handle terminate)
    in
    let definitive text =
      let has w =
        let re = Str.regexp_string w in
        try
          ignore (Str.search_forward re text 0);
          true
        with
        | Not_found -> false
      in
      (has "sat" || has "unsat") && not (has "unknown")
    in
    let kill_all () =
      List.iter
        (fun (pid, _) ->
           try Unix.kill pid Sys.sigkill with
           | _ -> ())
        children
    in
    let report (text, err_text) =
      print_string text;
      prerr_string err_text;
      flush stderr
    in
    let rec collect remaining fallback =
      if remaining = 0
      then report fallback
      else (
        match Unix.wait () with
        | pid, _ ->
          let texts =
            match List.assoc_opt pid children with
            | Some (out, err) -> read_file out, read_file err
            | None -> "", ""
          in
          if definitive (fst texts)
          then (
            kill_all ();
            report texts)
          else collect (remaining - 1) (if fst fallback = "" then texts else fallback)
        | exception _ -> report fallback)
    in
    collect (List.length children) ("", "");
    dump_captured ();
    List.iter
      (fun (_, (out, err)) ->
         (try Sys.remove out with
          | _ -> ());
         try Sys.remove err with
         | _ -> ())
      children)
;;
