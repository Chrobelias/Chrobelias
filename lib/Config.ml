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
  ; mutable over_approx_early : bool
  ; mutable under_approx : int
  ; mutable input_file : string
  ; mutable no_model : bool
  ; mutable logic : [ `Eia | `Str ]
  ; mutable with_check_sat : bool
  ; mutable with_info : bool
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
  ; over_approx = false
  ; over_approx_early = false
  ; under_approx = 2
  ; input_file = ""
  ; no_model = false
  ; logic = `Eia
  ; with_check_sat = false
  ; with_info = true
  ; quiet = false
  }
;;

let is_quiet () = config.quiet

type under2_config =
  { mutable amin : int
  ; mutable amax : int
  ; mutable flat : int [@warning "-69"]
  }

type huge_const_config = { mutable const : int }

let huge_const_config = { const = 10 }
let huge_const () = huge_const_config.const
let under2_config = { amin = -1; amax = -1; flat = -1 }
let get_flat () = under2_config.flat
let is_under2_enabled () = get_flat () >= 0
let base () = if config.logic = `Str then Z.of_int 10 else Z.of_int 2

let max_longest_path =
  match Sys.getenv_opt "CHRO_LONGEST_PATH" with
  | None -> 10000
  | Some s ->
    (match int_of_string_opt s with
     | Some n -> n
     | None -> exit 1)
;;

let parse_args () =
  (* Printf.printf "%s %d\n%!" __FILE__ __LINE__; *)
  let usage_msg =
    {|Chrobak normal form-based Exponential Linear Integer Arithmetic Solver.
Usage: chro [options] <file.smt2>

Basic options:
|}
  in
  let rec spec_list =
    [ ( "-no-model"
      , Arg.Unit (fun () -> config.no_model <- true)
      , "\tDisable model generation subroutines" )
    ; ( "-bound"
      , Arg.Int (fun n -> config.under_approx <- n)
      , "\tUpper bound for underapprox I (negative disables)" )
      (*; ( "-over"
      , Arg.Unit (fun () -> config.over_approx <- true)
      , "\tSimple overapprox" )*)
    ; ( "-over-early"
      , Arg.Unit (fun () -> config.over_approx_early <- true)
      , "\tSimple overapprox before underapprox II" )
    ; ( "-no-over"
      , Arg.Unit (fun () -> config.over_approx <- false)
      , "\tDisable simple overapprox" )
    ; ( "-lsb"
      , Arg.Unit (fun () -> config.mode <- `Lsb)
      , "  \tUse least-significant-bit first representation (only supports IN)" )
    ; ( "-flat"
      , Arg.Int (fun n -> under2_config.flat <- n)
      , "<n> \tAlternation depth in underapprox II for (* x (exp 2 y)). n >= 0" )
    ; ( "-amin"
      , Arg.Int (fun n -> under2_config.amin <- n)
      , "<n> \tLower bound for the least significant bits in underapprox II. n >= 0" )
    ; ( "-amax"
      , Arg.Int (fun n -> under2_config.amax <- n)
      , "<n> \tUpper bound for the least significant bits in underapprox II. n >= 0" )
    ; ( "-huge"
      , Arg.Int (fun n -> huge_const_config.const <- n)
      , Printf.sprintf
          "<n> \tAdmit constants with at most n digits (DEFAULT n=%d)"
          (huge_const ()) )
    ; ( "-help"
      , Arg.Unit (fun () -> raise (Arg.Help (Arg.usage_string spec_list usage_msg)))
      , "\tDisplay this list of options\n\nMiscellaneous:\n" )
    ; ( "--stop-after"
      , Arg.String
          (function
            | "simpl" -> config.stop_after <- `Simpl
            | "presimpl" | "pre_simpl" | "pre-simpl" | "simpl2" ->
              config.stop_after <- `Pre_simplify
            | s -> failwith ("Bad argument: " ^ s))
      , "\tStop after step" )
    ; "--err-check", Arg.Unit (fun () -> config.error_check <- true), "\t"
    ; "--no-err-check", Arg.Unit (fun () -> config.error_check <- false), "\t"
    ; "--pre-simpl", Arg.Unit (fun () -> config.pre_simpl <- true), "\t"
    ; "--no-pre-simpl", Arg.Unit (fun () -> config.pre_simpl <- false), "\t"
    ; "--info", Arg.Unit (fun () -> config.with_info <- true), "\t"
      (* ; "-q", Arg.Unit (fun () -> config.quiet <- true), "\t" *)
    ; ( "--no-alpha"
      , Arg.Unit (fun () -> config.simpl_alpha <- false)
      , "\tDon't try simplifications based on alpha-equivalence" )
    ; ( "--alpha"
      , Arg.Unit (fun () -> config.simpl_alpha <- true)
      , "\tDO simplifications based on alpha-equivalence" )
    ; "--no-mono", Arg.Unit (fun () -> config.simpl_mono <- false), "\t"
    ; "--dsimpl", Arg.Unit (fun () -> config.dump_simpl <- true), "\tDump simplifications"
    ; "--dir", Arg.Unit (fun () -> config.dump_ir <- true), "  \tDump IR"
    ; ( "--dpresimpl"
      , Arg.Unit (fun () -> config.dump_pre_simpl <- true)
      , "\tDump AST simplifications" )
    ; ( "--help"
      , Arg.Unit (fun () -> raise (Arg.Help (Arg.usage_string spec_list usage_msg)))
      , "\tDisplay this list of options" )
    ]
  in
  Arg.parse
    spec_list
    (fun s ->
       if Sys.file_exists s
       then config.input_file <- s
       else Printf.eprintf "File %S doesn't exist\n" s)
    usage_msg
;;
