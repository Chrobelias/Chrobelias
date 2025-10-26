(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

(* let () = Memtrace.trace_if_requested ~context:"my program" () *)

module Map = Base.Map.Poly

let () = Lib.Config.parse_args ()
let log = Lib.Debug.printfln
let answer_guess = ref None
let set_guess v = answer_guess := Some v

let () =
  Sys.set_signal
    Sys.sigterm
    (Sys.Signal_handle
       (fun _ ->
         print_endline "timeout";
         exit 1))
;;

type rez =
  | Sat of
      string
      * Lib.Ast.t
      * Lib.Env.t
      * ((Lib.Ir.atom, [ `Str | `Int ]) Map.t -> (Lib.Ir.model, [ `Too_long ]) Result.t)
  | Unknown of Lib.Ast.t * Lib.Env.t
  | Unsat of string
[@@deriving show]

let unknown ast e = Unknown (ast, e)
let sat desc ast e get_model = Sat (desc, ast, e, get_model)

let ( <+> ) =
  fun rez f ->
  match rez with
  | Unknown (ast, e) -> f ast e
  | Sat _ | Unsat _ -> rez
;;

let lift ?(unsat_info = "") ast = function
  | `Unknown (ast, e) -> Unknown (ast, e)
  | `Unsat -> Unsat unsat_info
  | `Sat (s, e) -> Sat (s, ast, e, fun _ -> Result.Ok Map.empty)
;;

let check_sat ?(verbose = false) ast : rez =
  let __ () =
    if Lib.Config.config.stop_after = `Pre_simplify
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
  let report_result2 rez =
    let check_answer () =
      Format.printf "%!";
      Format.eprintf "%!";
      match rez, !answer_guess with
      | _, None | _, Some `Unknown | `Unsat _, Some `Unsat | `Sat _, Some `Sat -> ()
      | `Unknown _, Some `Sat ->
        Printf.eprintf "; Need to improve --- sat is expected\n%!"
      | `Unknown _, Some `Unsat ->
        Printf.eprintf "; Need to improve --- unsat is expected\n%!"
      | `Unsat _, Some `Sat ->
        Printf.eprintf "; Une mauvaise réponse est possible ('sat' est attendu)!\n%!"
      | `Sat _, Some `Unsat ->
        Printf.eprintf "; Une mauvaise réponse est possible ('unsat' est attendu)!\n%!"
    in
    let () = if Lib.Debug.flag () then () else check_answer () in
    if verbose
    then (
      match rez with
      | `Sat s -> Format.printf "sat (%s)\n%!" s
      | `Unsat s -> Format.printf "unsat (%s)\n%!" s
      | `Unknown s ->
        Format.printf "unknown (%s)\n%!" s (*(if s <> "" then "\n " ^ s else ""))*))
    else ()
  in
  begin
    let rez =
      unknown ast Lib.Env.empty
      <+> (fun ast e ->
      if Lib.Config.config.logic = `Str
      then (
        let ast = Lib.SimplII.arithmetize ast in
        unknown ast e)
      else unknown ast e)
      <+> (fun ast e ->
      if not Lib.Config.config.pre_simpl
      then unknown ast e
      else lift ~unsat_info:"presimpl" ast (Lib.SimplII.run_basic_simplify ast))
      <+> (fun ast e ->
      if Lib.Config.config.under_approx >= 0
      then (
        match Lib.Underapprox.check Lib.Config.config.under_approx ast with
        | `Sat (s, e0) -> Sat (s, ast, Lib.Env.merge e0 e, fun _ -> Result.Ok Map.empty)
        | `Unknown _ -> unknown ast e)
      else unknown ast e)
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
      if Lib.Config.is_under2_enabled ()
      then (
        match Lib.SimplII.run_under2 ast with
        | `Sat -> sat "under II" ast e (fun _ -> Result.Ok Map.empty)
        | `Underapprox asts ->
          if Lib.Config.config.dump_pre_simpl
          then Format.printf "@[%a@]\n%!" Lib.Ast.pp_smtlib2 ast;
          if Lib.Config.config.stop_after = `Pre_simplify then exit 0;
          log "Looking for SAT in %d asts..." (List.length asts);
          let exception Sat_found in
          (try
             let f ast =
               let ir = Lib.Me.ir_of_ast ast in
               match ir with
               | Ok ir -> begin
                 match Lib.Solver.check_sat ir with
                 | `Sat _ -> raise Sat_found
                 | _ -> ()
               end
               | Error _ -> ()
             in
             List.iter f asts;
             report_result2 (`Unknown "under II");
             (* TODO(Kakadu): actually, exiting after check-sat is not OK *)
             unknown ast e
           with
           | Sat_found ->
             report_result2 (`Sat "under II");
             exit 0))
      else unknown ast e)
      <+> (fun ast e ->
      if Lib.Config.config.dump_pre_simpl
      then Format.printf "@[%a@]\n%!" Lib.Ast.pp_smtlib2 ast;
      unknown ast e)
      <+> (fun ast e ->
      if Lib.Config.config.stop_after = `Pre_simplify then exit 0 else unknown ast e)
      <+> fun ast e ->
      if Lib.Config.config.over_approx
      then (
        match Lib.Overapprox.check ast with
        | `Unknown ast -> unknown ast e
        | `Sat _ -> unknown ast e
        | `Unsat ->
          Unsat "over" (*| `Sat r -> sat "over" r e (fun _ -> Result.Ok Map.empty)*))
      else unknown ast e
    in
    let rez =
      match rez with
      | Sat (s, _, _, _) ->
        report_result2 (`Sat s);
        rez
      | Unsat s ->
        report_result2 (`Unsat s);
        rez
      | Unknown (ast, e) -> begin
        match Lib.Me.ir_of_ast ast with
        | Ok ir ->
          (match Lib.Solver.check_sat ir with
           | `Sat get_model ->
             report_result2 (`Sat "nfa");
             sat "nfa" ast e get_model
           | `Unsat ->
             report_result2 (`Unsat "nfa");
             rez
           | `Unknown _ir ->
             report_result2 (`Unknown "nfa");
             rez)
        | Error s ->
          report_result2 (`Unknown (Format.sprintf "nfa; %s" s));
          rez
      end
    in
    rez
  end
;;

let logBaseZ n =
  let base = Lib.Config.base () in
  let rec helper acc n = if n = Z.zero then acc else helper Z.(acc + one) Z.(n / base) in
  helper Z.minus_one n
;;

let join_int_model prefix m =
  let open Lib in
  let _ : Ir.model = m in
  (* Format.printf
    "prefix.length = %d, n.length = %d\n%!"
    (Env.length prefix)
    (Base.Map.Poly.length m); *)
  let prefix =
    let shrink_ir_model =
      Base.Map.Poly.map_keys_exn m ~f:(function
        | Ir.Var s -> Ast.Var s
        | Ir.Pow2 _ -> assert false)
    in
    Env.enrich prefix shrink_ir_model
  in
  (* log "prefix.length = %d" (Env.length prefix); *)
  let rec seek key =
    match Map.find_exn prefix key with
    | `Eia eia -> begin
      match SimplII.subst_term prefix eia with
      | Ast.Eia.Atom (Ast.Const c) -> Option.some (`Int c)
      | Ast.Eia.Atom (Ast.Var v) -> seek v
      | _ -> failwith "tbd"
    end
    | `Str (Ast.Str.Atom (Var z)) -> Some (`Str z)
    | `Str term -> failwith (Format.asprintf "not implemented: %a" Ast.Str.pp_term term)
    | exception Base.Not_found_s _ when Solver.is_internal key -> None
    | exception Base.Not_found_s _ -> None
  in
  Env.fold prefix ~init:m ~f:(fun ~key ~data:_ acc ->
    match seek key with
    | Some value -> Map.set acc ~key:(Var key) ~data:value
    | None ->
      Format.eprintf "; Can't join models. Something may be missing\n%!";
      acc
    (*failwith
        (Format.asprintf
           "not implemented in %s. What to do with key '%s'?"
           __FUNCTION__
           key)*))
;;

type state =
  { asserts : Lib.Ast.t list
  ; prev : state option (* TODO: where is the stack? *)
  ; last_result : rez option
  ; tys : (Lib.Ir.atom, [ `Str | `Int ]) Map.t
  }

let () =
  let f =
    match Fpath.of_string Lib.Config.config.input_file with
    | Result.Error (`Msg msg) ->
      Format.eprintf "%s\n%!" msg;
      exit 1
    | Ok file -> Smtml.Parse.from_file file
  in
  let exec ({ prev; _ } as state) = function
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
    | Smtml.Ast.Set_logic Smtml.Logic.QF_S ->
      Lib.Config.config.logic <- `Str;
      Lib.Config.config.mode <- `Lsb;
      Lib.Config.config.under_approx <- 0;
      Lib.Config.config.over_approx <- false;
      Lib.Config.config.simpl_alpha <- false;
      Lib.Config.config.simpl_mono <- false;
      (* Lib.Config.config.pre_simpl <- false; *)
      state
    | Smtml.Ast.Push _ ->
      { asserts = []; prev = Some state; last_result = None; tys = Map.empty }
    | Smtml.Ast.Pop _ -> begin
      match prev with
      | Some state -> state
      | None -> failwith "Nothing to pop"
    end
    | Smtml.Ast.Check_sat exprs ->
      Lib.Config.config.with_check_sat <- true;
      let expr_irs = List.map (Lib.Fe._to_ir state.tys) exprs in
      let rec get_ast { asserts; prev; _ } =
        match prev with
        | Some state -> asserts @ get_ast state
        | None -> asserts
      in
      let ast = Lib.Ast.land_ (expr_irs @ get_ast state) in
      let rez = check_sat ~verbose:true ast in
      { state with last_result = Some rez }
    | Smtml.Ast.Get_model ->
      if Lib.Config.config.no_model = true
      then (
        Format.printf "no-model mode\n%!";
        state)
      else (
        let rec get_ast { asserts; prev; _ } =
          match prev with
          | Some state -> asserts @ get_ast state
          | None -> asserts
        in
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
        let ast = Lib.Ast.land_ (get_ast state) in
        let rez =
          match state.last_result with
          | Some r -> r
          | None -> check_sat ast
        in
        let () =
          match rez with
          | Unknown _ | Unsat _ -> print_endline "no model"
          | Sat (_, _, env, get_model) ->
            let tys = merge_tys state in
            (match get_model tys with
             | Result.Ok model ->
               let model =
                 model
                 |> Map.mapi ~f:(fun ~key ~data ->
                   match data with
                   | `Str str -> `Str str
                   | `Int eia -> begin
                     match key with
                     | Lib.Ir.Var _ -> data
                     | Pow2 _ -> `Int (logBaseZ eia)
                   end)
                 |> Map.map_keys_exn ~f:(function
                   | Lib.Ir.Var _ as v -> v
                   | Lib.Ir.Pow2 v -> Lib.Ir.Var v)
               in
               let model = join_int_model env model in
               Format.printf "%s\n%!" (Lib.Ir.model_to_str model)
             | Result.Error `Too_long ->
               log "; model is TOO big on 1st attempt\n%!";
               let shrinked_ast =
                 Map.fold ~init:[ ast ] state.tys ~f:(fun ~key ~data acc ->
                   match key, data with
                   | Lib.Ir.Var v, `Str ->
                     Lib.Ast.(
                       eia (Eia.leq (Len (Atom (Var v))) (Atom (Const (Z.of_int 100000)))))
                     :: acc
                   | _ -> acc)
                 |> Lib.Ast.land_
               in
               log "Shrinked AST: @[%a@]\n%!" Lib.Ast.pp_smtlib2 shrinked_ast;
               (match check_sat shrinked_ast with
                | Unknown _ | Unsat _ -> Format.printf "no short model\n%!"
                | Sat (_, _, env, get_model) ->
                  (* let tys = merge_tys state in *)
                    (match get_model tys with
                     | Result.Ok model ->
                       let model = join_int_model env model in
                       Format.printf "%s\n%!" (Lib.Ir.model_to_str model)
                     | Result.Error `Too_long -> Format.printf "no short model\n%!")))
        in
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
          | _ -> Format.eprintf "%d\n%!" __LINE__)
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
        f
    with
    | Lib.Fe.Frontend_error _ when Lib.Config.is_quiet () ->
      Format.eprintf "\027[31mFronted error\027[0m\n%!";
      exit 1
  in
  ()
;;
