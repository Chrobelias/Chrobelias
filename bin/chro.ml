(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

module Map = Base.Map.Poly

let () = Lib.Solver.parse_args ()

type state =
  { asserts : Lib.Ast.t list
  ; prev : state option
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
    | Smtml.Ast.Push _ -> { asserts = []; prev = Some state }
    | Smtml.Ast.Pop _ -> begin
      match prev with
      | Some state -> state
      | None -> failwith "Nothing to pop"
    end
    | Smtml.Ast.Check_sat exprs ->
      let expr_irs =
        List.map
          begin
            fun expr -> expr |> Lib.Fe._to_ir
          end
          exprs
      in
      let rec get_ast { asserts; prev; _ } =
        match prev with
        | Some state -> asserts @ get_ast state
        | None -> asserts
      in
      let ast = Lib.Ast.land_ (expr_irs @ get_ast state) in
      begin
        let ( <+> ) rez f =
          match rez with
          | `Unknown -> f ()
          | `Sat | `Unsat -> rez
        in
        let rez =
          `Unknown
          <+> (fun () ->
          if Lib.Solver.config.over_approx then Lib.Overapprox.check ast else `Unknown)
          <+> fun () -> Lib.Solver.proof (Lib.Me.ir_of_ast ast)
        in
        match rez with
        | `Sat -> Format.printf "sat\n%!"
        | `Unsat -> Format.printf "unsat\n%!"
        | `Unknown -> Format.printf "unknown\n%!"
      end;
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
            ~f:(fun ~key:k ~data:v -> Format.printf "%a = %d; " Lib.Ir.pp_atom k v)
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
