(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)
let trace_log fmt = Lib.Debug.trace "chro" fmt

(* let () = Memtrace.trace_if_requested ~context:"my program" () *)

module Map = Base.Map.Poly

let () = trace_log "Starting Chrobelias with config: %a" Lib.Config.pp_config Lib.Config.config ;;

let answer_guess = ref None
let sat_found = ref false
let set_guess v = answer_guess := Some v

let _config = Lib.Config.config
let _base = Lib.Config.config.enc_base

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
      * Lib.Ast.t
      * Lib.Env.t
      * ((Lib.Ir.atom, [ `Str | `Int ]) Map.t
         -> (Lib.Ir.model, [ `Too_long | `No_model ]) Result.t)
      * (string, Lib.Nfa.Lsb(Lib.Nfa.Str).u) Base.Map.Poly.t
  | Unknown of Lib.Ast.t * Lib.Env.t
  | Unsat of string

let unknown ast e = Unknown (ast, e)
let sat desc ast e get_model regexes = Sat (desc, ast, e, get_model, regexes)

let ( <+> ) =
  fun rez f ->
  match rez with
  | Unknown (ast, e) -> f ast e
  | Sat _ | Unsat _ -> rez
;;

let lift ?(unsat_info = "") ast = function
  | `Unknown (ast, e) -> Unknown (ast, e)
  | `Unsat -> Unsat unsat_info
  | `Sat (s, e) -> Sat (s, ast, e, (fun _ -> Result.Ok Map.empty), Map.empty)
;;

let logBaseZ n =
  let rec helper acc n = if n = Z.zero then acc else helper Z.(acc + one) Z.(n / Z.of_int _base) in
  helper Z.minus_one n
;;

let rec model_from_parts_regexes_env tys model regexes env' =
  let model =
    model
    |> Map.mapi ~f:(fun ~key ~data ->
      match data with
      | `Str str -> `Str str
      | `Int eia ->
        begin match key with
        | Lib.Ir.Var _ -> data
        | Lib.Ir.Pow _ -> `Int (logBaseZ eia)
        end)
    |> Map.map_keys_exn ~f:(function
      | Lib.Ir.Var _ as v -> v
      | Lib.Ir.Pow v -> Lib.Ir.Var v)
  in
  (*New code goes here *)
  let var = Lib.Ir.var in
  let raw_model = model in
  let prefix = "strlen" in
  let prefix_len = String.length prefix in
  let module NfaS = Lib.Nfa.Lsb (Lib.Nfa.Str) in
  let module NfaC = Lib.NfaCollection in
  let aux raw_model =
    Map.to_alist raw_model
    |> List.filter_map (fun (key, data) ->
      match key with
      | Lib.Ir.Var key when String.starts_with ~prefix key ->
        let real_var = String.sub key prefix_len (String.length key - prefix_len) in
        let data =
          match data with
          | `Int c -> Z.to_int c
          | _ -> assert false
        in
        begin if not (Map.mem raw_model (var real_var))
        then
          if Map.mem regexes real_var
          then (
            let regexes = Map.find_exn regexes real_var in
            let nfa = regexes in
            let path =
              NfaS.path_of_len2 ~var:0 ~len:data nfa
              |> Option.value ~default:(List.init data (fun _ -> '0'))
            in
            Some (var real_var, `Str (List.to_seq path |> String.of_seq)))
          else Some (var real_var, `Str (String.init data (fun _ -> '0')))
        else None
        end
      | Lib.Ir.Var key ->
        let data' =
          match data with
          | `Str c -> `Str c
          | `Int d ->
            (match Map.find tys (Lib.Ir.Var key) with
             | Some `Str -> `Str (Z.to_string d)
             | Some `Int | None -> `Int d)
        in
        let result =
          match data' with
          | `Str str ->
            let len_var = String.concat "" [ prefix; key ] in
            let len =
              match Map.find raw_model (var len_var) with
              | Some (`Int len) -> Z.to_int len
              | _ -> String.length str
            in
            let str =
              if len = 0
              then ""
              else if len > String.length str
              then
                String.concat
                  ""
                  [ String.init (len - String.length str) (fun _ -> '0'); str ]
              else str
            in
            `Str str
          | `Int d -> `Int d
        in
        Some (var key, result)
      | _ -> Some (key, data))
    |> Map.of_alist_exn
  in
  let real_model = aux raw_model in
  let env = Lib.Env.enrich2 env' real_model in
  (* New code ends here *)
  let real_model =
    Map.fold
      ~f:(fun ~key ~data acc ->
        if Map.mem acc key
        then acc
        else (
          match data with
          | `Int -> Map.add_exn acc ~key ~data:(`Int Z.zero)
          | `Str -> Map.add_exn acc ~key ~data:(`Str "")))
      ~init:real_model
      tys
  in
  if Lib.Env.definite_length env' <> Lib.Env.definite_length env
  then model_from_parts_regexes_env tys model regexes env
  else real_model
;;

let calculate_model tys model regexes env =
  (* Lib.Debug.printf "Calculating the model\n%!";
  Lib.Debug.printf "NFA model:\n  %a\n%!" Lib.Ir.pp_model_smtlib2 model;
  Lib.Debug.printf "Env      :\n  %a\n%!" (Lib.Env.pp ~title:"") env;
  Lib.Debug.printf "Regexes: :\n"; *)
  let module NfaS = Lib.Nfa.Lsb (Lib.Nfa.Str) in
  Map.iteri
    ~f:(fun ~key ~data ->
      trace_log "%s -> " key;
      Lib.Debug.dump_nfa ~msg:"%s" NfaS.format_nfa data)
    regexes;
  let real_model =
    try model_from_parts_regexes_env tys model regexes env with
    | _ -> failwith "Too long model?"
  in
  let real_model =
    Map.filteri
      ~f:(fun ~key ~data:_ ->
        match key with
        | Var v when String.starts_with ~prefix:"%" v -> false
        | _ -> true)
      real_model
  in
  real_model
;;

let print_model model = Format.printf "%s\n%!" (Lib.Ir.model_to_str model)

let check_sat ?(verbose = false) _ ast : rez =
  if _config.logic = `Eia && Lib.Ast.is_str ast
  then _config.logic <- (if Lib.Config.config.no_str_bv then `Str else `StrBv);
  let report_result2 rez =
    let check_answer () =
      Format.printf "%!";
      Format.eprintf "%!";
      match rez, !answer_guess with
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
    let () = if Lib.Debug.is_traced "chro" then () else check_answer () in
    if verbose
    then (
      match rez with
      | `Sat s ->
        if _config.with_info
        then Format.printf "sat (%s)\n%!" s
        else Format.printf "sat\n%!"
      | `Unsat s ->
        if _config.with_info
        then Format.printf "unsat (%s)\n%!" s
        else Format.printf "unsat\n%!"
      | `Unknown s ->
        Format.printf "unknown %s\n%!" (if s <> "" then "(" ^ s ^ ")" else ""))
    else ()
  in
  let check_nfa_sat ?(light = false) ast e =
    match Lib.Me.ir_of_ast e ast with
    | Ok ir ->
      let ir = ir |> Lib.Ir.simpl |> Lib.Ir.simpl_ineq in
      let ir = if _config.simpl_mono then Lib.Ir.simpl_monotonicty ir else ir in
      (match ir with
       | True -> sat "simpl" ast e (fun _ -> Result.Ok Map.empty) Map.empty
       | Lnot True -> Unsat "simpl"
       | _ ->
         if light
         then (
           trace_log "Unknown in Lightweight solving ...";
           Unknown (ast, e))
         else (
           if _config.dump_simpl then Format.printf "%a\n%!" Lib.Ir.pp_smtlib2 ir;
           if _config.stop_after = `Simpl then exit 0;
           trace_log "Starting NFA Solver ...";
           match Lib.Solver.check_sat ir with
           | `Sat get_model -> sat "nfa" ast e get_model Map.empty
           | `Unsat -> Unsat "nfa"
           | `Unknown _ir -> Unknown (ast, e)))
    | Error _ -> failwith "Unexpected error"
  in
  let check_eia_sat ?(light = false) ast e =
    let can_be_unk = ref false in
    let apporx_rez =
      unknown ast e
      <+> (fun ast e ->
      if not _config.pre_simpl
      then unknown ast e
      else lift ~unsat_info:"presimpl int" ast (Lib.SimplII.run_basic_simplify ~env:e ast))
      <+> (fun ast e ->
      let light_str = if light then "Lightweight run:\n" else "" in
      if _config.dump_pre_simpl
      then Format.printf "@[%s%a@]\n%!" light_str Lib.Ast.pp_smtlib2 ast;
      unknown ast e)
      <+> fun ast e -> if _config.stop_after = `Pre_simplify then exit 0 else unknown ast e
    in
    match apporx_rez with
    | Unknown (ast, e) ->
      if _config.mode = `Msb
      then check_nfa_sat ~light ast e
      else (
        let asts_nat = Lib.Ast.to_nat ast in
        trace_log "To IN gives %d asts..." (List.length asts_nat);
        let check ast =
          trace_log "Over IN: %a" Lib.Ast.pp_smtlib2 ast;
          match check_nfa_sat ~light ast e with
          | Sat (s, ast, env, get_model, regexes) -> Some (s, ast, env, get_model, regexes)
          | Unknown _ ->
            can_be_unk := true;
            None
          | Unsat _ -> None
        in
        match List.find_map check asts_nat with
        | Some (s, ast, env, get_model, regexes) -> Sat (s, ast, env, get_model, regexes)
        | None -> if !can_be_unk then unknown ast Lib.Env.empty else Unsat "nfa")
    | _ -> apporx_rez
  in
  let handle =
    fun result f ->
    match result with
    | Sat (s, _, _, _, _) as rez ->
      report_result2 (`Sat s);
      rez
    | Unsat s as rez ->
      report_result2 (`Unsat s);
      rez
    | Unknown _ -> f ()
  in
  try
    handle (check_eia_sat ast Lib.Env.empty) (fun () ->
      report_result2 (`Unknown "nfa");
      unknown ast Lib.Env.empty)
  with
  | Lib.Nfa.Too_big_nfa ->
    report_result2 (`Unknown "too big nfa during the computations");
    unknown ast Lib.Env.empty
  | s ->
    if _config.quiet == true
    then (
      report_result2 (`Unknown "");
      unknown ast Lib.Env.empty)
    else raise s
;;

let check_model
      tys
      (ast : Lib.Ast.t)
      (model : (Lib.Ir.atom, [ `Int of Z.t | `Str of string ]) Map.t)
  =
  trace_log "check_model starts...";
  let ast =
    Map.fold
      ~init:ast
      ~f:(fun ~key ~data ast ->
        let key =
          match key with
          | Lib.Ir.Var s -> s
          | _ -> assert false
        in
        let open Lib.Ast in
        let ast' =
          match data with
          | `Int c -> eia (Eia.eq (Eia.atom (var key I)) (Lib.Ast.Eia.const c) I)
          | `Str c -> eia (Eia.eq (Eia.atom (var key S)) (Lib.Ast.Eia.str_const c) S)
        in
        Lib.Ast.land_ [ ast'; ast ])
      model
  in
  let _ = set_guess `Unknown in
  trace_log "Checking model correctness;\n  ast=%a" Lib.Ast.pp_smtlib2 ast;
  try
    match check_sat tys ast with
    | Sat _ -> ()
    | Unsat _ -> Printf.eprintf "(error: model check has failed, incorrect model)\n%!"
    | Unknown _ -> Printf.eprintf "(warning: the correctness of model is unknown)\n%!"
  with
  | _ -> Printf.eprintf "(warning: the correctness of model is unknown)\n%!"
;;

type state =
  { asserts : Lib.Ast.t list
  ; prev : state option
  ; last_result : rez option
  ; tys : (Lib.Ir.atom, [ `Str | `Int ]) Map.t
  }

let () =
  Smtml.Expr.use_eval := false;
  let smt_f =
    match Fpath.of_string _config.input_file with
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
      | Sat (_, _, env, get_model, regexes) ->
        sat_found := true;
        let tys = merge_tys state in
        let () =
          match
            get_model tys
            |> Result.map (fun model ->
              let model = calculate_model tys model regexes env in
              print_model model;
              if Lib.Config.config.check_model then check_model tys ast model else ())
          with
          | Result.Ok () -> ()
          | Result.Error `No_model -> Format.printf "no model mode\n%!"
          | _ -> failwith "Unexpected error"
        in
        ()
    in
    function
    | Smtml.Ast.Declare_const { id; sort; _ }
    | Smtml.Ast.Declare_fun { id; sort; args = [] } ->
      let id = Lib.Ir.var (Smtml.Symbol.to_string id) in
      let sort = Smtml.Symbol.to_string sort in
      let tys =
        match sort with
        | "Int" -> Map.set ~key:id ~data:`Int state.tys
        | "String" -> Map.set ~key:id ~data:`Str state.tys
        | _ -> state.tys
      in
      { state with tys }
    | Smtml.Ast.Set_logic (Smtml.Logic.QF_S | Smtml.Logic.QF_SLIA) ->
      _config.logic
      <- (if Lib.Config.config.logic = `Par
          then `Par
          else if Lib.Config.config.no_str_bv
          then `Str
          else `StrBv);
      (* _config.under_approx <- 0; *)
      _config.over_approx <- false;
      _config.simpl_alpha <- false;
      _config.simpl_mono <- true;
      (* _config.pre_simpl <- false; *)
      state
    | Smtml.Ast.Push _ ->
      { asserts = []; prev = Some state; last_result = None; tys = Map.empty }
    | Smtml.Ast.Pop _ ->
      begin match prev with
      | Some state -> state
      | None -> failwith "Nothing to pop"
      end
    | Smtml.Ast.Check_sat exprs ->
      _config.with_check_sat <- true;
      let expr_irs = List.map (Lib.Fe._to_ir state.tys) exprs in
      let rec get_ast { asserts; prev; _ } =
        match prev with
        | Some state -> asserts @ get_ast state
        | None -> asserts
      in
      let all_asserts = expr_irs @ get_ast state in
      let ast =
        Lib.Ast.land_
          (if List.is_empty all_asserts then [ Lib.Ast.True ] else all_asserts)
      in
      let rez = check_sat ~verbose:true state.tys ast in
      if Lib.Config.config.check_model then get_model ~noprint:true ast rez;
      { state with last_result = Some rez }
    | Smtml.Ast.Get_model ->
      if _config.no_model = true
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
        let rez =
          match state.last_result with
          | Some r -> r
          | None -> check_sat state.tys ast
        in
        get_model ast rez;
        state)
    | Smtml.Ast.Assert expr -> begin
      let ast = expr |> Lib.Fe._to_ir state.tys in
      { state with asserts = ast :: state.asserts }
      end
    | Smtml.Ast.Set_info e ->
      let open Smtml in
      (match Expr.view e with
       | Smtml.Expr.App ({ Smtml.Symbol.name = Smtml.Symbol.Simple ":status"; _ }, [ r ])
         ->
         (match Smtml.Expr.view r with
          | Expr.Symbol { name = Smtml.Symbol.Simple "sat"; _ } -> set_guess `Sat
          | Expr.Symbol { name = Smtml.Symbol.Simple "unsat"; _ } -> set_guess `Unsat
          | Expr.Symbol { name = Smtml.Symbol.Simple "unknown"; _ } -> set_guess `Unknown
          | Expr.Symbol { name = Smtml.Symbol.Simple "timeout"; _ } -> set_guess `Unknown
          | _ -> Format.eprintf "(warning: invalid ':status' attribute)\n%!")
       | _ -> ());
      state
    | _ast ->
      (* Format.eprintf "skipped: @[%a@]\n%!" Smtml.Ast.pp ast; *)
      state
  in
  let _ =
    try
      List.fold_left
        exec
        { asserts = []; prev = None; last_result = None; tys = Map.empty }
        smt_f
    with
    | Lib.Fe.UnsupportedException _ ->
      Format.eprintf "\027[31mFronted error\027[0m\n%!";
      exit 1
  in
  ()
;;
