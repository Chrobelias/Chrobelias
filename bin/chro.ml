(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

module Map = Base.Map.Poly

type state =
  { asserts : Lib.Ast.t list
  ; prev : state option
  }

let () =
  let f = Sys.argv.(1) |> Fpath.of_string |> Result.get_ok |> Smtml.Parse.from_file in
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
      let rec get_irs { asserts; prev; _ } =
        match prev with
        | Some state -> asserts @ get_irs state
        | None -> asserts
      in
      let ir = Lib.Ast.land_ (expr_irs @ get_irs state) in
      begin
        match Lib.Solver.proof (Lib.Me.ir_of_ast ir) with
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
