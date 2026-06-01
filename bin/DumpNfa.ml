let () =
  Smtml.Expr.use_eval := false;
  let f =
    match Fpath.of_string Sys.argv.(1) with
    | Result.Error (`Msg msg) ->
      Format.eprintf "%s\n%!" msg;
      exit 1
    | Ok file -> Smtml.Parse.from_file file
  in
  List.fold_left
    (fun () -> function
       | Smtml.Ast.Assert expr ->
         let module Nfa = Lib.Nfa.Lsb (Lib.Nfa.Bv) in
         let f = Lib.Fe._to_ir Base.Map.Poly.empty expr in
         let f = Lib.Me.ir_of_ast () f |> Result.get_ok in
         let nfa = Lib.Solver.calc_lsb_nfa_for_ir f in
         Nfa.format_nfa_mm Sys.argv.(2) nfa
       | _ -> ())
    ()
    f
;;
