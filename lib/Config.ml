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
  ; mutable under_approx : int
  ; mutable input_file : string
  ; mutable no_model : bool
  ; mutable logic : [ `Eia | `Str ]
  ; mutable with_check_sat : bool
  ; mutable under_3 : bool
  ; mutable quiet : bool
  }

let config =
  { stop_after = `Solving
  ; mode = `Msb
  ; dump_simpl = false
  ; dump_pre_simpl = false
  ; dump_ir = false
  ; pre_simpl = true
  ; error_check = true
  ; simpl_alpha = false
  ; simpl_mono = true
  ; over_approx = true
  ; under_approx = 2
  ; input_file = ""
  ; no_model = false
  ; logic = `Eia
  ; with_check_sat = false
  ; under_3 = false
  ; quiet = false
  }
;;

let is_quiet () = config.quiet

type under2_config =
  { mutable amin : int
  ; mutable amax : int
  ; mutable flat : int [@warning "-69"]
  }

type issue150_config = { mutable i150const : int }

let issue150_config = { i150const = 10 }
let i150const () = issue150_config.i150const
let under2_config = { amin = 5; amax = 11; flat = -1 }
let get_flat () = under2_config.flat
let is_under2_enabled () = get_flat () >= 0
let base () = if config.logic = `Str then Z.of_int 10 else Z.of_int 2
let is_under3_enabled () = config.under_3

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
    ; "-no-model", Arg.Unit (fun () -> config.no_model <- true), " "
    ; "-no-error-check", Arg.Unit (fun () -> config.error_check <- false), " "
    ; "-pre-simpl", Arg.Unit (fun () -> config.pre_simpl <- true), " "
    ; "-no-pre-simpl", Arg.Unit (fun () -> config.pre_simpl <- false), " "
    ; "-q", Arg.Unit (fun () -> config.quiet <- true), " "
    ; ( "--no-simpl-alpha"
      , Arg.Unit (fun () -> config.simpl_alpha <- false)
      , " Don't try simplifications based on alpha-equivalence" )
    ; ( "--simpl-alpha"
      , Arg.Unit (fun () -> config.simpl_alpha <- true)
      , " DO simplifications based on alpha-equivalence" )
    ; "--no-simpl-mono", Arg.Unit (fun () -> config.simpl_mono <- false), " "
    ; "-dsimpl", Arg.Unit (fun () -> config.dump_simpl <- true), " Dump simplifications"
    ; "-dir", Arg.Unit (fun () -> config.dump_ir <- true), " Dump IR"
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
    ; ( "-flat"
      , Arg.Int (fun n -> under2_config.flat <- n)
      , " <N> Underapproximation 2 of (* x (exp 2 y)). N >=0. " )
    ; ( "-amin"
      , Arg.Int (fun n -> under2_config.amin <- n)
      , " <n> Parameter of underapprox.2. Matters when N>=2" )
    ; ( "-amax"
      , Arg.Int (fun n -> under2_config.amax <- n)
      , " <n> Parameter of underapprox.2. Matters when N>=2" )
    ; ( "-under3"
      , Arg.Unit (fun () -> config.under_3 <- true)
      , " Enable underapprox 3 for string concatenation" )
    ; ( "-i150c"
      , Arg.Int (fun n -> issue150_config.i150const <- n)
      , Printf.sprintf
          " <n> Apply reduction of variable count when constant (DEFAULT=%d) is below \
           this (issue 150)"
          (i150const ()) )
    ; ( "-huge"
      , Arg.Int (fun n -> issue150_config.i150const <- n)
      , " The same as '-i150c N'" )
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
