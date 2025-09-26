type config =
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
  ; mutable minimize_in_semenov : bool
  ; mutable under_approx : int
  ; mutable under_mode : [ `First | `Second ]
  ; mutable input_file : string
  ; mutable logic : [ `Eia | `Str ]
  ; mutable with_check_sat : bool
  }

let config =
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
  ; minimize_in_semenov = true
  ; under_approx = 2
  ; under_mode = `First
  ; input_file = ""
  ; logic = `Eia
  ; with_check_sat = false
  }
;;

let is_under2_enabled () = config.under_mode = `Second

let parse_args () =
  (* Printf.printf "%s %d\n%!" __FILE__ __LINE__; *)
  Arg.parse
    [ ( "-stop-after"
      , Arg.String
          (function
            | "simpl" -> config.stop_after <- `Simpl
            | "presimpl" | "pre_simpl" | "pre-simpl" | "simpl2" ->
              config.stop_after <- `Pre_simplify
            | s -> failwith ("Bad argument: " ^ s))
      , " Stop after step" )
    ; "-error-check", Arg.Unit (fun () -> config.error_check <- true), " "
    ; "-no-error-check", Arg.Unit (fun () -> config.error_check <- false), " "
    ; "-pre-simpl", Arg.Unit (fun () -> config.pre_simpl <- true), " "
    ; "-no-pre-simpl", Arg.Unit (fun () -> config.pre_simpl <- false), " "
    ; ( "--no-simpl-alpha"
      , Arg.Unit (fun () -> config.simpl_alpha <- false)
      , " Don't try simplifications based on alpha-equivalence" )
    ; "--no-simpl-mono", Arg.Unit (fun () -> config.simpl_mono <- false), " "
    ; "-dsimpl", Arg.Unit (fun () -> config.dump_simpl <- true), " Dump simplifications"
    ; "-dir", Arg.Unit (fun () -> config.dump_ir <- true), " Dump IR"
    ; "-under2", Arg.Unit (fun () -> config.under_mode <- `Second), " ..."
    ; ( "-dpresimpl"
      , Arg.Unit (fun () -> config.dump_pre_simpl <- true)
      , " Dump AST simplifications" )
    ; ( "-bound"
      , Arg.Int (fun n -> config.under_approx <- n)
      , " Set underapprox. bound (negative disables)" )
    ; ( "-over-approx"
      , Arg.Unit (fun () -> config.over_approx <- true)
      , " Simple overapproximation (issue #75)" )
    ; ( "-no-over-approx"
      , Arg.Unit (fun () -> config.over_approx <- false)
      , " Disable simple overapproximation (issue #75)" )
    ; ( "-lsb"
      , Arg.Unit (fun () -> config.mode <- `Lsb)
      , " Use least-significant-bit first representation (only supports nats)" )
    ; "-flat", Arg.Int SimplII.set_flat, " "
    ; "-amin", Arg.Int SimplII.set_a_min, " "
    ; "-amax", Arg.Int SimplII.set_a_max, " "
    ; ( "-mini-in-semenov"
      , Arg.Unit (fun () -> config.minimize_in_semenov <- true)
      , " Minimize in Semenov (default)" )
    ; "-no-mini-in-semenov", Arg.Unit (fun () -> config.minimize_in_semenov <- false), " "
    ]
    (fun s ->
       if Sys.file_exists s
       then config.input_file <- s
       else Printf.eprintf "File %S doesn't exist\n" s)
    {|Chrobak normal form-based Exponential Linear Integer Arithmetic Solver.
Usage: chro [options] <file.smt2>

List options using -help or --help.
|}
;;
