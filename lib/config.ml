type t =
  { mutable stop_after : [ `Simpl | `Pre_simplify | `Solving ]
  ; mutable mode : [ `Msb | `Lsb ]
  ; mutable dump_simpl : bool
  ; mutable dump_pre_simpl : bool
  ; mutable dump_ir : bool
  ; mutable pre_simpl : bool
  ; mutable error_check : bool
  ; mutable simpl_alpha : bool
  ; mutable simpl_mono : bool
  ; mutable over_approx : bool
  ; mutable under_approx : int
  ; mutable input_file : string
  ; mutable logic : [ `Eia | `Str ]
  ; mutable verbosity : int
  }

let v =
  { stop_after = `Solving
  ; mode = `Msb
  ; dump_simpl = false
  ; dump_pre_simpl = false
  ; dump_ir = false
  ; pre_simpl = true
  ; error_check = true
  ; simpl_alpha = true
  ; simpl_mono = true
  ; over_approx = true
  ; under_approx = 3
  ; input_file = ""
  ; logic = `Eia
  ; verbosity = 0
  }
;;

let parse_args () =
  (* Printf.printf "%s %d\n%!" __FILE__ __LINE__; *)
  Arg.parse
    [ ( "-stop-after"
      , Arg.String
          (function
            | "simpl" -> v.stop_after <- `Simpl
            | "pre_simpl" | "pre-simpl" | "simpl2" -> v.stop_after <- `Pre_simplify
            | _ -> failwith "Bad argument")
      , " Stop after step" )
    ; "-error-check", Arg.Unit (fun () -> v.error_check <- true), " "
    ; "-v", Arg.Unit (fun () -> v.verbosity <- 1), " "
    ; "-vv", Arg.Unit (fun () -> v.verbosity <- 2), " "
    ; "-vvv", Arg.Unit (fun () -> v.verbosity <- 3), " "
    ; "-no-error-check", Arg.Unit (fun () -> v.error_check <- false), " "
    ; "-pre-simpl", Arg.Unit (fun () -> v.pre_simpl <- true), " "
    ; "-no-pre-simpl", Arg.Unit (fun () -> v.pre_simpl <- false), " "
    ; ( "--no-simpl-alpha"
      , Arg.Unit (fun () -> v.simpl_alpha <- false)
      , " Don't try simplifications based on alpha-equivalence" )
    ; "--no-simpl-mono", Arg.Unit (fun () -> v.simpl_mono <- false), " "
    ; "-dsimpl", Arg.Unit (fun () -> v.dump_simpl <- true), " Dump simplifications"
    ; "-dir", Arg.Unit (fun () -> v.dump_ir <- true), " Dump IR"
    ; ( "-dpresimpl"
      , Arg.Unit (fun () -> v.dump_pre_simpl <- true)
      , " Dump AST simplifications" )
    ; ( "-bound"
      , Arg.Int
          (fun n ->
            assert (n >= 0);
            v.under_approx <- n)
      , " Set underapprox. bound (zero disables)" )
    ; ( "-over-approx"
      , Arg.Unit (fun () -> v.over_approx <- true)
      , " Simple overapproximation (issue #75)" )
    ; ( "-no-over-approx"
      , Arg.Unit (fun () -> v.over_approx <- false)
      , " Disable simple overapproximation (issue #75)" )
    ; ( "-lsb"
      , Arg.Unit (fun () -> v.mode <- `Lsb)
      , " Use least-significant-bit first representation (only supports nats)" )
    ]
    (fun s ->
       if Sys.file_exists s
       then v.input_file <- s
       else Printf.eprintf "File %S doesn't exist\n" s)
    {|Chrobak normal form-based Exponential Linear Integer Arithmetic Solver.
Usage: chro [options] <file.smt2>

List options using -help or --help.
|}
;;
