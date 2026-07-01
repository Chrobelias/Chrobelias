(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)
let trace_log fmt = Lib.Debug.trace "parsym" fmt

(* let () = Memtrace.trace_if_requested ~context:"my program" () *)

module Map = Base.Map.Poly

let () =
  trace_log "Starting Chrobelias with config: %a" Lib.Config.pp_config Lib.Config.config
;;

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
      * ((Lib.Ir.atom, [ `Str | `Int ]) Map.t -> (Lib.Ir.model, [ `No_model ]) Result.t)
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

let join_int_model prefix m =
  let open Lib in
  let prefix =
    let shrink_ir_model =
      Base.Map.Poly.map_keys_exn m ~f:(fun s -> Ast.Any_atom (Ast.var s Ast.I))
    in
    Env.enrich prefix shrink_ir_model
  in
  let rec seek prefix key =
    match Env.lookup_int key prefix with
    | Some eia ->
      begin match SimplII.subst_term prefix eia with
      | Ast.RLia.Const c -> Option.some (`Int c)
      | Ast.RLia.Str_const s -> Option.some (`Str s)
      | Ast.RLia.Atom (Var (v, _)) -> seek prefix v
      | _ -> None
      end
    | None ->
      begin match Env.lookup_string key prefix with
      | Some str ->
        begin match SimplII.subst_term prefix str with
        | Ast.RLia.Const c -> Option.some (`Int c)
        | Ast.RLia.Str_const s -> Option.some (`Str s)
        | Ast.RLia.Atom (Var (v, _)) -> seek prefix v
        | _ -> None
        end
      | None -> None
      end
  in
  let module Set = Base.Set.Poly in
  let unknown_vars =
    let open Ast in
    let open Ast.RLia in
    Env.fold
      ~init:Set.empty
      ~f:(fun ~key:_ ~data:tt acc ->
        match tt with
        | TT (I, eia) -> Set.union acc (get_vars (RLia (eq (const Z.zero) eia I)))
        | TT (S, _) -> acc)
      prefix
  in
  let prefix =
    Set.fold unknown_vars ~init:prefix ~f:(fun acc var ->
      if Env.is_absent_key var acc
      then Env.extend_int_exn acc var (Ast.RLia.const Z.zero)
      else acc)
  in
  Env.fold prefix ~init:m ~f:(fun ~key ~data:_ acc ->
    match seek prefix key with
    | Some value -> Map.set acc ~key ~data:value
    | None -> acc)
  |> Map.filter_keys ~f:(fun key -> not (String.starts_with ~prefix:"%" key))
  |> Map.map_keys_exn ~f:(fun name -> Ir.var name)
;;

let print_model model = Format.printf "%s\n%!" (Lib.Ir.model_to_str model)

let check_sat _ ast : rez list =
  let check_nfa_sat ast e =
    trace_log "Env      :\n  %a\n%!" (Lib.Env.pp ~title:"") e;
    match Lib.Me.ir_of_ast e ast with
    | Ok ir ->
      let ir = ir |> Lib.Ir.simpl in
      (match ir with
       | True -> [ sat "simpl" ast e (fun _ -> Result.Ok Map.empty) Map.empty ]
       | Lnot True -> [ Unsat "simpl" ]
       | _ ->
         if _config.dump_simpl then Format.printf "%a\n%!" Lib.Ir.pp_smtlib2 ir;
         if _config.stop_after = `Simpl then exit 0;
         trace_log "Starting NFA Solver ...";
         ir
         |> Lib.Solver.check_sat
         |> List.map (function
           | `Sat get_model -> sat "nfa" ast e get_model Map.empty
           | `Unsat -> Unsat "nfa"
           | `Unknown _ir -> Unknown (ast, e)))
    | Error _ -> failwith "Unexpected error"
  in
  let apporx_rez =
    unknown ast Lib.Env.empty
    <+> (fun ast e ->
    if not _config.pre_simpl
    then unknown ast e
    else lift ~unsat_info:"presimpl int" ast (Lib.SimplII.run_basic_simplify ~env:e ast))
    <+> fun ast e -> if _config.stop_after = `Pre_simplify then exit 0 else unknown ast e
  in
  let results =
    match apporx_rez with
    | Unknown (ast, e) ->
      if _config.mode = `Msb
      then check_nfa_sat ast e
      else failwith "Only msb mode supported"
    | _ -> [ apporx_rez ]
  in
  let answers =
    List.fold_left
      (fun (s, u, n) ->
         (function
           | Sat _ -> s || true, u, n
           | Unsat _ -> s, u || true, n
           | Unknown _ -> s, u, n || true))
      (false, false, false)
      results
  in
  (match _config.problem, answers with
   | `Uni, (true, false, false) | `Exi, (true, _, _) -> Format.printf "sat\n%!"
   | `Uni, (_, false, true) | `Exi, (_, _, true) -> Format.printf "unknown\n%!"
   | _ -> Format.printf "unsat\n%!");
  results
;;

let check_model
      tys
      (ast : Lib.Ast.t)
      (model : (Lib.Ir.atom, [ `Int of Z.t | `Str of string ]) Map.t)
  =
  trace_log "check_model starts...";
  if Lib.Config.config.base_min <> Lib.Config.config.base_min
  then Format.printf "Specify a base to check, not a range"
  else (
    let ast =
      Map.fold
        ~init:ast
        ~f:(fun ~key ~data ast ->
          let key =
            match key with
            | Lib.Ir.Var s -> s
          in
          let open Lib.Ast in
          let ast' =
            match data with
            | `Int c -> RLia (RLia.eq (RLia.atom (var key I)) (Lib.Ast.RLia.const c) I)
            | `Str c ->
              RLia (RLia.eq (RLia.atom (var key S)) (Lib.Ast.RLia.str_const c) S)
          in
          Lib.Ast.land_ [ ast'; ast ])
        model
    in
    let _ = set_guess `Unknown in
    trace_log "Checking model correctness;\n  ast=%a" Lib.Ast.pp_smtlib2 ast;
    try
      match check_sat tys ast |> List.hd with
      | Sat _ -> ()
      | Unsat _ -> Printf.eprintf "(error: model check has failed, incorrect model)\n%!"
      | Unknown _ -> Printf.eprintf "(warning: the correctness of model is unknown)\n%!"
    with
    | _ -> Printf.eprintf "(warning: the correctness of model is unknown)\n%!")
;;

type state =
  { asserts : Lib.Ast.t list
  ; prev : state option
  ; last_result : rez list option
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
      (* let printf = if not noprint then Format.printf else fun _ -> () in *)
      let print_model = if not noprint then print_model else fun _ -> () in
      match rez with
      | Unknown _ | Unsat _ -> Format.printf "no model\n%!"
      | Sat (_, _, env, get_model, _) ->
        sat_found := true;
        let tys = merge_tys state in
        let () =
          match
            get_model tys
            |> Result.map (fun model ->
              let model =
                model
                |> Map.map_keys_exn ~f:(fun var -> Lib.Ir.name var)
                |> join_int_model env
              in
              print_model model;
              if Lib.Config.config.check_model then check_model tys ast model else ())
          with
          | Result.Ok () -> ()
          | Result.Error `No_model -> ()
          (* | Result.Error `No_model -> Format.printf "no model mode\n%!" *)
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
      (* _config.under_approx <- 0; *)
      _config.over_approx <- false;
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
      let rezs = check_sat state.tys ast in
      { state with last_result = Some rezs }
    | Smtml.Ast.Get_model ->
      let rec get_ast { asserts; prev; _ } =
        match prev with
        | Some state -> asserts @ get_ast state
        | None -> asserts
      in
      let ast = Lib.Ast.land_ (get_ast state) in
      let rezs =
        match state.last_result with
        | Some r -> r
        | None -> check_sat state.tys ast
      in
      if List.length rezs > 1
      then (
        Format.printf "\nmodels for each base:\n%!";
        List.iteri
          (fun i rez ->
             Format.printf "base %d: \n%!" (_config.base_min + i);
             get_model ast rez)
          rezs)
      else get_model ast (List.hd rezs);
      state
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
