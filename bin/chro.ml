(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

module Map = Base.Map.Poly

let () = Lib.Config.parse_args ()

let () =
  Sys.set_signal
    Sys.sigterm
    (Sys.Signal_handle
       (fun _ ->
         print_endline "timeout";
         exit 1))
;;

let check_sat ast =
  let __ () =
    if Lib.Config.v.stop_after = `Pre_simplify
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
        exit 0)
  in
  begin
    let ( <+> ) =
      fun rez f ->
      match rez with
      | `Unknown ast -> f ast
      | `Sat _ | `Unsat -> rez
    in
    let ast =
      `Unknown ast
      <+> (fun ast ->
      if not Lib.Config.v.pre_simpl
      then `Unknown ast
      else (
        match Lib.SimplII.simpl Lib.Config.v.under_approx ast with
        | `Error (_ast, es) ->
          Format.printf "%!";
          Format.printf "Leftover formula:\n@[%a@]\n%!" Lib.Ast.pp_smtlib2 _ast;
          Format.printf "@[<v>%a@]\n%!" (Format.pp_print_list Lib.SimplII.pp_error) es;
          Format.printf "@[UNKNOWN (Errors after simplification)@]\n%!";
          exit 1
        | (`Unsat | `Sat _ | `Unknown _) as other -> other))
      <+> (fun ast ->
      if Lib.Config.v.dump_pre_simpl
      then Format.printf "@[%a@]\n%!" Lib.Ast.pp_smtlib2 ast;
      `Unknown ast)
      <+> (fun ast ->
      if Lib.Config.v.stop_after = `Pre_simplify then exit 0 else `Unknown ast)
      <+> (fun ast ->
      if Lib.Config.v.over_approx then Lib.Overapprox.check ast else `Unknown ast)
      <+> fun ast ->
      let bound = Lib.Config.v.under_approx in
      if bound > 0 then Lib.Underapprox.check bound ast else `Unknown ast
    in
    let ast =
      match ast with
      | `Sat s -> `Sat s
      | `Unsat -> `Unsat
      | `Unknown ast ->
        (match Lib.Solver.proof (Lib.Me.ir_of_ast ast) with
         | `Sat -> `Sat "nfa"
         | `Unsat -> `Unsat
         | `Unknown _ir -> `Unknown)
    in
    match ast with
    | `Sat s -> Format.printf "sat (%s)\n%!" s
    | `Unsat -> Format.printf "unsat\n%!"
    | `Unknown -> Format.printf "unknown\n%!"
  end
;;

type state =
  { asserts : Lib.Ast.t list
  ; prev : state option
  }

let () =
  let f =
    match Fpath.of_string Lib.Config.v.input_file with
    | Result.Error (`Msg msg) ->
      Format.eprintf "%s\n%!" msg;
      exit 1
    | Ok file -> Smtml.Parse.from_file file
  in
  let exec ({ prev; _ } as state) = function
    | Smtml.Ast.Set_logic Smtml.Logic.QF_S ->
      Lib.Config.v.logic <- `Str;
      Lib.Config.v.mode <- `Lsb;
      Lib.Config.v.under_approx <- 0;
      Lib.Config.v.over_approx <- false;
      Lib.Config.v.simpl_alpha <- false;
      Lib.Config.v.simpl_mono <- false;
      Lib.Config.v.pre_simpl <- false;
      state
    | Smtml.Ast.Push _ -> { asserts = []; prev = Some state }
    | Smtml.Ast.Pop _ -> begin
      match prev with
      | Some state -> state
      | None -> failwith "Nothing to pop"
    end
    | Smtml.Ast.Check_sat exprs ->
      let expr_irs = List.map Lib.Fe._to_ir exprs in
      let rec get_ast { asserts; prev; _ } =
        match prev with
        | Some state -> asserts @ get_ast state
        | None -> asserts
      in
      let ast = Lib.Ast.land_ (expr_irs @ get_ast state) in
      check_sat ast;
      state
    | Smtml.Ast.Get_model ->
      let rec get_irs { asserts; prev; _ } =
        match prev with
        | Some state -> asserts @ get_irs state
        | None -> asserts
      in
      let ir = Lib.Ast.land_ (get_irs state) in
      begin
        match Lib.Solver.get_model (Lib.Me.ir_of_ast ir) with
        | Some model ->
          Map.iteri
            ~f:(fun ~key:k ~data:v ->
              Format.printf "%a = " Lib.Ir.pp_atom k;
              (match v with
               | `Int v -> Format.printf "%a" Z.pp_print v
               | `Str v -> Format.printf "%s" v);
              Format.printf "; ")
            model;
          Format.printf "\n%!"
        | None -> Format.printf "no model\n%!"
      end;
      state
    (*| Smtml.Ast.Declare_const { id; _ } ->
      let var = Smtml.Symbol.to_string id in
      consts := var :: !consts;
      acc*)
    | Smtml.Ast.Assert expr -> begin
      let ast = expr |> Lib.Fe._to_ir in
      { state with asserts = ast :: state.asserts }
    end
    | _ -> state
  in
  let _ = List.fold_left exec { asserts = []; prev = None } f in
  ()
;;
