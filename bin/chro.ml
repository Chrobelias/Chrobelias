(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

(* let () = Memtrace.trace_if_requested ~context:"my program" () *)

module Map = Base.Map.Poly

let () = Lib.Config.parse_args ()
let log = Lib.Debug.printfln
let answer_guess = ref None
let set_guess v = answer_guess := Some v
let config = Lib.Config.config

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

let check_sat ?(verbose = false) ast : rez =
  let __ () =
    if config.stop_after = `Pre_simplify
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
        Printf.eprintf "(warning: check annotation that says 'sat')\n%!"
      | `Unknown _, Some `Unsat ->
        Printf.eprintf "(warning:  check annotation that says 'unsat')\n%!"
      | `Unsat _, Some `Sat ->
        Printf.eprintf "(error: check annotation that says 'sat')\n%!"
      | `Sat _, Some `Unsat ->
        Printf.eprintf "(error: check annotation that says 'unsat')\n%!"
    in
    let () = if Lib.Debug.flag () then () else check_answer () in
    if verbose
    then (
      match rez with
      | `Sat s ->
        if config.with_info
        then Format.printf "sat (%s)\n%!" s
        else Format.printf "sat\n%!"
      | `Unsat s ->
        if config.with_info
        then Format.printf "unsat (%s)\n%!" s
        else Format.printf "unsat\n%!"
      | `Unknown s ->
        Format.printf "unknown %s\n%!" (if s <> "" then "(" ^ s ^ ")" else ""))
    else ()
  in
  let used_under2 = ref false in
  let check_nfa_sat ast e =
    log "Starting NFA Solver ...\n%!";
    match Lib.Me.ir_of_ast e ast with
    | Ok ir ->
      let ir = ir |> Lib.Ir.simpl |> Lib.Ir.simpl_ineq in
      let ir = if config.simpl_mono then Lib.Ir.simpl_monotonicty ir else ir in
      let ir = if config.simpl_alpha then Lib.Simpl_alpha.simplify ir else ir in
      (match ir with
       | True -> sat "simpl" ast e (fun _ -> Result.Ok Map.empty) Map.empty
       | Lnot True -> Unsat "simpl"
       | _ ->
         (match Lib.Solver.check_sat ir with
          | `Sat get_model -> sat "nfa" ast e get_model Map.empty
          | `Unsat -> Unsat "nfa"
          | `Unknown _ir -> Unknown (ast, e)))
    | Error s ->
      if !used_under2 |> not then report_result2 (`Unknown (Format.sprintf "(nfa) %s" s));
      (* Unknown (ast, e) *) exit 0
  in
  let check_eia_sat ast =
    let can_be_unk = ref false in
    let apporx_rez =
      unknown ast Lib.Env.empty
      <+> (fun ast e ->
      if not config.pre_simpl
      then unknown ast e
      else lift ~unsat_info:"presimpl" ast (Lib.SimplII.run_basic_simplify ast))
      <+> (fun ast e ->
      if config.under_approx >= 0
      then (
        let merge =
          Lib.Env.merge
            ~sf:(fun ~key:_ ~data1 ~data2:_ -> data1)
            ~zf:(fun ~key:_ ~data1 ~data2:_ -> data1)
        in
        match Lib.Underapprox.check config.under_approx ast with
        | `Sat (s, e0) ->
          Sat (s, ast, merge e0 e, (fun _ -> Result.Ok Map.empty), Map.empty)
        | `Unsat s -> Unsat s
        | `Unknown _ -> unknown ast e)
      else unknown ast e)
      <+> (fun ast e ->
      if config.over_approx_early
      then (
        match Lib.Overapprox.check ast with
        | `Unknown ast -> unknown ast e
        | `Sat _ -> unknown ast e
        | `Unsat ->
          Unsat "over early" (*| `Sat r -> sat "over" r e (fun _ -> Result.Ok Map.empty)*))
      else unknown ast e)
      <+> (fun ast e ->
      match Lib.SimplII.has_unsupported_nonlinearity ast with
      | Result.Ok () -> unknown ast e
      | Error terms ->
        (* TODO(Kakadu): Print leftover AST too *)
        log "@[<v 2>";
        log "@[Non linear arithmetic between@]@,";
        List.iteri (fun i -> log "@[%d) %a@]@," i Lib.Ast.pp_term_smtlib2) terms;
        log "@]@,";
        if config.logic = `Eia
        then (
          match Lib.SimplII.check_nia ast with
          | `Sat -> sat "nia" ast e (fun _ -> Result.Ok Map.empty) Map.empty
          | `Unsat -> Unsat "nia"
          | `Unknown ->
            report_result2 (`Unknown "nia");
            exit 0)
        else unknown ast e)
      <+> (fun ast e ->
      if Lib.Config.is_under2_enabled ()
      then (
        used_under2 := true;
        match Lib.SimplII.run_under2 e ast with
        | `Sat -> sat "under II" ast e (fun _ -> Result.Ok Map.empty) Map.empty
        | `Underapprox asts ->
          if config.dump_pre_simpl then Format.printf "@[%a@]\n%!" Lib.Ast.pp_smtlib2 ast;
          if config.stop_after = `Pre_simplify then exit 0;
          log "Looking for SAT in %d asts..." (List.length asts);
          let exception
            Sat_found of
              ((Lib.Ir.atom, [ `Str | `Int ]) Map.t
               -> (Lib.Ir.model, [ `Too_long | `No_model ]) Result.t)
          in
          (try
             let f ast =
               let ir = Lib.Me.ir_of_ast e ast in
               match ir with
               | Ok ir -> begin
                 match Lib.Solver.check_sat ir with
                 | `Sat e -> raise (Sat_found e)
                 | _ -> Result.ok ()
               end
               | Error s -> Result.error s
             in
             let _results = List.map f asts in
             unknown ast e
           with
           | Sat_found model -> sat "under II" ast e model Map.empty))
      else unknown ast e)
      <+> (fun ast e ->
      if config.dump_pre_simpl then Format.printf "@[%a@]\n%!" Lib.Ast.pp_smtlib2 ast;
      unknown ast e)
      <+> (fun ast e ->
      if config.stop_after = `Pre_simplify then exit 0 else unknown ast e)
      <+> fun ast e ->
      if config.stop_after = `Pre_simplify
      then exit 0
      else
        unknown ast e
        <+> fun ast e ->
        if config.over_approx
        then (
          match Lib.Overapprox.check ast with
          | `Unknown ast -> unknown ast e
          | `Sat _ -> unknown ast e
          | `Unsat ->
            Unsat "over" (*| `Sat r -> sat "over" r e (fun _ -> Result.Ok Map.empty)*))
        else unknown ast e
    in
    match apporx_rez with
    | Unknown (ast, e) ->
      if config.mode = `Msb
      then check_nfa_sat ast e
      else (
        let asts_nat = Lib.Ast.to_nat ast in
        log "To IN gives %d asts..." (List.length asts_nat);
        let check ast =
          log "Over IN: %a\n" Lib.Ast.pp_smtlib2 ast;
          match check_nfa_sat ast e with
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
  let can_be_unk = ref false in
  let unsat_reason = ref "" in
  let reason lhs rhs =
    let ord = [ "nfa"; "nia"; "over"; "simpl"; "presimpl"; "?" ] in
    let lhs' =
      List.find_index (( = ) lhs) ord |> Option.value ~default:(List.length ord)
    in
    let rhs' =
      List.find_index (( = ) rhs) ord |> Option.value ~default:(List.length ord)
    in
    if lhs' <= rhs' then lhs else rhs
  in
  try
    if config.logic = `Str || config.logic = `StrBv
    then (
      match Lib.SimplII.arithmetize ast with
      | `Sat (s, e) ->
        report_result2 (`Sat s);
        Sat (s, ast, e, (fun _ -> Result.Ok Map.empty), Map.empty)
      | `Unsat ->
        report_result2 (`Unsat "presimpl");
        Unsat "presimpl"
      | `Unknown asts_n_regexes ->
        log "Arithmetization gives %d asts..." (List.length asts_n_regexes);
        let f ast_n_regex =
          let ast, regex = ast_n_regex in
          log "Arithmetized: %a\n" Lib.Ast.pp_smtlib2 ast;
          match check_eia_sat ast with
          | Sat (s, ast, env, get_model, _) -> Some (s, ast, env, get_model, regex)
          | Unknown _ ->
            can_be_unk := true;
            None
          | Unsat s ->
            unsat_reason := reason s !unsat_reason;
            None
        in
        (match List.find_map f asts_n_regexes with
         | Some (s, ast, env, get_model, regexes) ->
           report_result2 (`Sat s);
           Sat (s, ast, env, get_model, regexes)
         | None ->
           if !can_be_unk
           then (
             report_result2 (`Unknown "");
             unknown ast Lib.Env.empty)
           else (
             report_result2 (`Unsat !unsat_reason);
             Unsat !unsat_reason)))
    else (
      match check_eia_sat ast with
      | Sat (s, ast, env, get_model, _) ->
        report_result2 (`Sat s);
        Sat (s, ast, env, get_model, Map.empty)
      | Unknown _ ->
        report_result2 (`Unknown "nfa");
        unknown ast Lib.Env.empty
      | Unsat s ->
        report_result2 (`Unsat s);
        Unsat s)
  with
  | s ->
    if config.quiet == true
    then (
      report_result2 (`Unknown "");
      unknown ast Lib.Env.empty)
    else raise s
;;

let logBaseZ n =
  let base = Lib.Config.base () in
  let rec helper acc n = if n = Z.zero then acc else helper Z.(acc + one) Z.(n / base) in
  helper Z.minus_one n
;;

let join_int_model prefix m =
  let open Lib in
  (* Format.printf
    "prefix.length = %d, n.length = %d\n%!"
    (Env.length prefix)
    (Base.Map.Poly.length m); *)
  let prefix =
    let shrink_ir_model =
      Base.Map.Poly.map_keys_exn m ~f:(function
        | Ir.Var s -> Ast.Any_atom (Ast.var s Ast.I)
        | Ir.Pow2 _ -> assert false)
    in
    Env.enrich prefix shrink_ir_model
  in
  (* log "prefix.length = %d" (Env.length prefix); *)
  let rec seek prefix key =
    match Env.lookup_int key prefix with
    | Some eia -> begin
      match SimplII.subst_term prefix eia with
      | Ast.Eia.Const c -> Option.some (`Int c)
      | Ast.Eia.Str_const s -> Option.some (`Str s)
      | Ast.Eia.Atom (Var (v, _)) -> seek prefix v
      | t -> Format.kasprintf failwith "tbd: %a" Ast.pp_term_smtlib2 t
    end
    (* | `Str (Ast.Str.Atom (Var z)) -> Some (`Str z) *)
    (* | `Str term -> failwith (Format.asprintf "not implemented: %a" Ast.Str.pp_term term) *)
    | None -> begin
      match Env.lookup_string key prefix with
      | Some str -> begin
        match SimplII.subst_term prefix str with
        | Ast.Eia.Const c -> Option.some (`Int c)
        | Ast.Eia.Str_const s -> Option.some (`Str s)
        | Ast.Eia.Atom (Var (v, _)) -> seek prefix v
        | t -> Format.kasprintf failwith "tbd: %a" Ast.pp_term_smtlib2 t
      end
      | None when Solver.is_internal key -> None
      | None -> None
    end
  in
  let rec saturate env =
    let env' : Env.t =
      Env.fold
        env
        ~f:(fun ~key ~data acc ->
          begin match data with
          | Ast.TT (Ast.I, term) ->
            Env.extend_int_exn acc key (SimplII.subst_term env term)
          | Ast.TT (Ast.S, term) ->
            Env.extend_string_exn acc key (SimplII.subst_term env term)
          end)
        ~init:Env.empty
    in
    if Env.equal env' env then env' else saturate env'
  in
  let prefix = saturate prefix in
  Env.fold prefix ~init:m ~f:(fun ~key ~data:_ acc ->
    match seek prefix key with
    | Some value -> Map.set acc ~key:(Ir.var key) ~data:value
    | None ->
      if Solver.is_internal key |> not
      then Format.eprintf "; Can't join models. Something may be missing\n%!";
      acc)
;;

exception Too_long_model

let print_model tys model regexes env =
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
  (*New code goes here *)
  let var = Lib.Ir.var in
  let raw_model = model in
  let prefix = "strlen" in
  let prefix_len = String.length prefix in
  let module NfaS = Lib.Nfa.Lsb (Lib.Nfa.Str) in
  let module NfaC = Lib.NfaCollection in
  let real_model =
    Map.to_alist raw_model
    |> List.filter_map (fun (key, data) ->
      match key with
      | Lib.Ir.Var key when String.starts_with ~prefix key ->
        let real_var = String.sub key prefix_len (String.length key - prefix_len) in
        let data =
          match data with
          | `Int c ->
            if c > Z.of_int Lib.Config.max_longest_path
            then raise Too_long_model
            else Z.to_int c
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
              String.concat
                ""
                [ String.init (len - String.length str) (fun _ -> '0'); str ]
            in
            `Str str
          | `Int d -> `Int d
        in
        Some (var key, result)
      | _ -> Some (key, data))
    |> Map.of_alist_exn
  in
  (* New code ends here *)
  let real_model =
    Map.filteri
      ~f:(fun ~key ~data:_ ->
        match key with
        | Var v when String.starts_with ~prefix:"%" v -> false
        | _ -> true)
      real_model
  in
  Format.printf "%s\n%!" (Lib.Ir.model_to_str real_model)
;;

type state =
  { asserts : Lib.Ast.t list
  ; prev : state option (* TODO: where is the stack? *)
  ; last_result : rez option
  ; tys : (Lib.Ir.atom, [ `Str | `Int ]) Map.t
  }

let () =
  Smtml.Expr.use_eval := false;
  let f =
    match Fpath.of_string config.input_file with
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
    | Smtml.Ast.Set_logic (Smtml.Logic.QF_S | Smtml.Logic.QF_SLIA) ->
      config.logic <- (if Lib.Config.config.no_str_bv then `Str else `StrBv);
      config.under_approx <- 0;
      config.over_approx <- false;
      config.simpl_alpha <- false;
      config.simpl_mono <- true;
      (* config.pre_simpl <- false; *)
      state
    | Smtml.Ast.Push _ ->
      { asserts = []; prev = Some state; last_result = None; tys = Map.empty }
    | Smtml.Ast.Pop _ -> begin
      match prev with
      | Some state -> state
      | None -> failwith "Nothing to pop"
    end
    | Smtml.Ast.Check_sat exprs ->
      config.with_check_sat <- true;
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
      let rez = check_sat ~verbose:true ast in
      { state with last_result = Some rez }
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
          | Sat (_, _, env, get_model, regexes) ->
            let tys = merge_tys state in
            let shrink_model () =
              log "model is TOO big after 1st attempt\n%!";
              let shrinked_ast =
                Map.fold ~init:[ ast ] state.tys ~f:(fun ~key ~data acc ->
                  match key, data with
                  | Lib.Ir.Var v, `Str ->
                    Lib.Ast.(
                      eia
                        (Eia.leq
                           (Len (Atom (Var (v, S))))
                           (Const (Z.of_int Lib.Config.max_longest_path))))
                    :: acc
                  | Lib.Ir.Var v, `Int ->
                    Lib.Ast.(
                      eia
                        (Eia.leq
                           (Atom (Var (v, I)))
                           (Const Z.(pow (Lib.Config.base ()) (Lib.Config.huge_const ())))))
                    :: acc
                  | _ -> acc)
                |> Lib.Ast.land_
              in
              log "Shrinked AST: @[%a@]\n%!" Lib.Ast.pp_smtlib2 shrinked_ast;
              Lib.Config.config.under_approx <- -1;
              match check_sat shrinked_ast with
              | Unknown _ | Unsat _ -> Format.printf "no short model\n%!"
              | Sat (_, _, env, get_model, _regexes) ->
                (* let tys = merge_tys state in *)
                  (match get_model tys with
                   | Result.Ok model ->
                     let model = join_int_model env model in
                     print_model tys model regexes env
                   | Result.Error `Too_long -> Format.printf "no short model\n%!"
                   | Result.Error `No_model -> assert false)
            in
            (match get_model tys with
             | Result.Ok model -> begin
               try print_model tys model regexes env with
               | Too_long_model -> shrink_model ()
             end
             | Result.Error `Too_long -> shrink_model ()
             | Result.Error `No_model -> Format.printf "no model mode\n%!")
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
    | Lib.Fe.UnsupportedException _ when Lib.Config.is_quiet () ->
      Format.eprintf "\027[31mFronted error\027[0m\n%!";
      exit 1
  in
  ()
;;
