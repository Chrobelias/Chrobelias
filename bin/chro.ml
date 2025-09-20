(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

(* let () = Memtrace.trace_if_requested ~context:"my program" () *)

module Map = Base.Map.Poly

let () = Lib.Solver.parse_args ()
let log = Lib.Debug.printfln

let () =
  Sys.set_signal
    Sys.sigterm
    (Sys.Signal_handle
       (fun _ ->
         print_endline "timeout";
         exit 1))
;;

type rez =
  | Sat of string * Lib.Ast.t * Lib.SimplII.Env.t
  | Unknown of Lib.Ast.t * Lib.SimplII.Env.t
  | Unsat
[@@deriving show]

let unknown ast e = Unknown (ast, e)
let sat desc ast e = Sat (desc, ast, e)

let ( <+> ) =
  fun rez f ->
  match rez with
  | Unknown (ast, e) -> f ast e
  | Sat _ | Unsat -> rez
;;

let lift ast = function
  | `Unknown (ast, e) -> Unknown (ast, e)
  | `Unsat -> Unsat
  | `Sat (s, e) -> Sat (s, ast, e)
;;

let check_sat ast : rez =
  let __ () =
    if Lib.Solver.config.stop_after = `Pre_simplify
    then (
      match Lib.SimplII.simpl 0 ast with
      | `Error _ -> failwith "not implemented"
      | `Unsat ->
        Format.eprintf "Unsat\n%!";
        exit 0
      | `Sat _ ->
        Format.eprintf "Sat\n%!";
        exit 0
      | `Unknown ast ->
        Format.printf "%a\n%!" Lib.Ast.pp_smtlib2 ast;
        exit 0
      | _ -> assert false)
  in
  let report_result2 = function
    | `Sat s -> Format.printf "sat (%s)\n%!" s
    | `Unsat -> Format.printf "unsat\n%!"
    | `Unknown s -> Format.printf "unknown%s\n%!" (if s <> "" then " (" ^ s ^ ")" else "")
  in
  begin
    let rez =
      unknown ast Lib.SimplII.Env.empty
      <+> (fun ast e ->
      if not Lib.Solver.config.pre_simpl
      then unknown ast e
      else lift ast (Lib.SimplII.run_basic_simplify ast))
      <+> (fun ast e ->
      match Lib.SimplII.has_unsupported_nonlinearity ast with
      | Result.Ok () -> unknown ast e
      | Error terms ->
        (* TODO(Kakadu): Print leftover AST too *)
        Format.printf "@[<v 2>";
        Format.printf "@[Non linear arithmetic between@]@,";
        List.iteri (fun i -> Format.printf "@[%d) %a@]@," i Lib.Ast.pp_term_smtlib2) terms;
        Format.printf "@]@,";
        let () = report_result2 (`Unknown "non-linear") in
        exit 0)
      <+> (fun ast e ->
      if Lib.Solver.config.under_approx >= 0
      then (
        match Lib.Underapprox.check Lib.Solver.config.under_approx ast with
        | `Sat s -> Sat (s, ast, e)
        | `Unknown _ -> unknown ast e)
      else unknown ast e)
      <+> (fun ast e ->
      if Lib.Solver.is_under2_enabled ()
      then (
        match Lib.SimplII.run_under2 ast with
        | `Sat -> sat "under2" ast e
        | `Underapprox asts ->
          if Lib.Solver.config.dump_pre_simpl
          then Format.printf "@[%a@]\n%!" Lib.Ast.pp_smtlib2 ast;
          if Lib.Solver.config.stop_after = `Pre_simplify then exit 0;
          log "Looking for SAT in %d asts..." (List.length asts);
          let exception Sat_found in
          (try
             let f ast =
               match Lib.Solver.proof (Lib.Me.ir_of_ast ast) with
               | `Sat -> raise Sat_found
               | _ -> ()
             in
             List.iter f asts;
             report_result2 (`Unknown "TODO");
             exit 0
           with
           | Sat_found ->
             Format.printf "sat (under II)\n%!";
             exit 0))
      else unknown ast e)
      <+> (fun ast e ->
      if Lib.Solver.config.dump_pre_simpl
      then Format.printf "@[%a@]\n%!" Lib.Ast.pp_smtlib2 ast;
      unknown ast e)
      <+> (fun ast e ->
      if Lib.Solver.config.stop_after = `Pre_simplify then exit 0 else unknown ast e)
      <+> fun ast e ->
      if Lib.Solver.config.over_approx
      then (
        match Lib.Overapprox.check ast with
        | `Unknown ast -> unknown ast e
        | `Unsat -> Unsat
        | `Sat r -> sat "over" r e)
      else unknown ast e
    in
    let rez =
      match rez with
      | Sat (s, _, _) ->
        report_result2 (`Sat s);
        rez
      | Unsat ->
        report_result2 `Unsat;
        rez
      | Unknown (ast, e) ->
        (match Lib.Solver.proof (Lib.Me.ir_of_ast ast) with
         | `Sat ->
           report_result2 (`Sat "nfa");
           sat "nfa" ast e
         | `Unsat ->
           report_result2 `Unsat;
           rez
         | `Unknown _ir ->
           report_result2 (`Unknown "nfa");
           rez)
    in
    rez
  end
;;

type state =
  { asserts : Lib.Ast.t list
  ; prev : state option (* TODO: where is the stack? *)
  ; last_result : rez option
  }

let () =
  let f =
    match Fpath.of_string Lib.Solver.config.input_file with
    | Result.Error (`Msg msg) ->
      Format.eprintf "%s\n%!" msg;
      exit 1
    | Ok file -> Smtml.Parse.from_file file
  in
  let exec ({ prev; _ } as state) = function
    | Smtml.Ast.Set_logic Smtml.Logic.QF_S ->
      Lib.Solver.config.logic <- `Str;
      Lib.Solver.config.mode <- `Lsb;
      Lib.Solver.config.under_approx <- 0;
      Lib.Solver.config.over_approx <- false;
      Lib.Solver.config.simpl_alpha <- false;
      Lib.Solver.config.simpl_mono <- false;
      (* Lib.Solver.config.pre_simpl <- false; *)
      state
    | Smtml.Ast.Push _ -> { asserts = []; prev = Some state; last_result = None }
    | Smtml.Ast.Pop _ -> begin
      match prev with
      | Some state -> state
      | None -> failwith "Nothing to pop"
    end
    | Smtml.Ast.Check_sat exprs ->
      Lib.Solver.config.with_check_sat <- true;
      let expr_irs = List.map Lib.Fe._to_ir exprs in
      let rec get_ast { asserts; prev; _ } =
        match prev with
        | Some state -> asserts @ get_ast state
        | None -> asserts
      in
      let ast = Lib.Ast.land_ (expr_irs @ get_ast state) in
      let rez = check_sat ast in
      { state with last_result = Some rez }
    | Smtml.Ast.Get_model ->
      let rec get_ast { asserts; prev; _ } =
        match prev with
        | Some state -> asserts @ get_ast state
        | None -> asserts
      in
      let ast = Lib.Ast.land_ (get_ast state) in
      let rez =
        match state.last_result with
        | Some r -> r
        | None -> check_sat ast
      in
      let () =
        match rez with
        | Unknown _ | Unsat -> print_endline "no model"
        | Sat (_, ast, _env) ->
          (match Lib.Solver.get_model (Lib.Me.ir_of_ast ast) with
           | Some model -> Format.printf "%s\n%!" (Lib.Ir.model_to_str model)
           | _ -> ())
      in
      state
    | Smtml.Ast.Assert expr -> begin
      let ast = expr |> Lib.Fe._to_ir in
      { state with asserts = ast :: state.asserts }
    end
    | _ -> state
  in
  let _ = List.fold_left exec { asserts = []; prev = None; last_result = None } f in
  ()
;;
