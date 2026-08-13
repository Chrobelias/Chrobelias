type config =
  { mutable antiprenex_mode : [ `All | `Push_re | `Disable ]
  ; mutable bound_res : int
  ; mutable bound_states : int
  ; mutable base : int option
  ; mutable dump_simpl : bool
  ; mutable dump_pre_simpl : bool
  ; mutable dump_ir : bool
  ; mutable error_check : bool
  ; mutable good_for_minimize : int
  ; mutable good_for_shrinking : int
  ; mutable input_file : string
  ; mutable logic : [ `Eia | `Str | `StrBv ]
  ; mutable mode : [ `Msb | `Lsb ]
    (* Decide [t = c (mod m)] with the dedicated congruence automaton. Turning
       this off lowers every [mod] to a quotient and a remainder instead, which
       is what the solver did before the automaton existed -- the point of the
       switch is to be able to compare the two. *)
  ; mutable mod_eq : bool
  ; mutable no_model : bool
  ; mutable no_str_bv : bool
  ; mutable over_approx : bool
  ; mutable over_approx_early : bool
  ; mutable over_nfa : bool
  ; mutable pre_simpl : bool
  ; mutable quiet : bool
  ; mutable simpl_alpha : bool
  ; mutable simpl_mono : bool
  ; mutable stop_after : [ `Pre_dpll | `Pre_simplify | `Simpl | `Solving ]
  ; mutable under_approx : int
  ; mutable under_str_all : bool
    (* Run the string-under-approximation strategy and the normal one at the same
       time, in separate processes, and take the first definitive answer. *)
  ; mutable parallel : bool
  ; mutable under_str_budget : float
  ; mutable with_check_sat : bool
  ; mutable with_info : bool
  ; mutable check_model : bool
  ; mutable light_dpll : bool
  }

let config =
  { antiprenex_mode = `All
  ; bound_res = -1
  ; bound_states = -1
  ; base = None
  ; stop_after = `Solving
  ; dump_pre_simpl = false
  ; dump_simpl = false
  ; dump_ir = false
  ; error_check = true
  ; good_for_minimize = 15
  ; good_for_shrinking = 20
  ; pre_simpl = true
  ; over_approx = true
  ; over_approx_early = false
  ; over_nfa = false
  ; input_file = ""
  ; logic = `Eia
  ; mode = `Msb
  ; mod_eq = true
  ; no_model = false
  ; no_str_bv = false
  ; quiet = false
  ; simpl_alpha = false
  ; simpl_mono = true
  ; with_check_sat = false
  ; with_info = true
  ; under_approx = 2
  ; under_str_all = false
  ; parallel = true
  ; under_str_budget = 1.0
  ; check_model = false
  ; light_dpll = false
  }
;;

(* The cram tests set this (tests/dune): with two strategies racing, stage
   labels, models and debug traces depend on which child answers first, which
   under load makes the expected outputs flap. Same idea as CHRO_OMIT_Z3_MODEL. *)
let () = if Sys.getenv_opt "CHRO_NO_PARALLEL" <> None then config.parallel <- false
let is_quiet () = config.quiet

type under2_config =
  { mutable amin : int
  ; mutable amax : int
  ; mutable flat : int [@warning "-69"]
  }

type under_str_config =
  { mutable max_len : int
  ; mutable max_cnt : int
  }

type huge_const_config =
  { mutable const : int
  ; mutable const_model : int
  ; mutable path : int
  }

type string_config =
  { zero : char
  ; one : char
  ; null : char
  ; eos : char
  }

let huge_const_config = { const = 20; const_model = 120; path = 10000 }
let huge_const () = huge_const_config.const
let huge_path () = huge_const_config.path
let huge_const_for_model () = huge_const_config.const_model
let under2_config = { amin = 5; amax = 11; flat = -1 }
let under_str_config = { max_len = 32; max_cnt = 32 }
let get_flat () = under2_config.flat
let is_under2_enabled () = get_flat () >= 0
let bounded_unsat = ref false
let string_config = { zero = '0'; one = '1'; null = Char.chr 0; eos = Char.chr 3 }
let base = ref 10

let set_base ?ast_base () =
  base
  := Option.value
       ~default:(Option.value ~default:(if config.logic = `Eia then 2 else 10) ast_base)
       config.base
;;

let max_longest_path =
  match Sys.getenv_opt "CHRO_LONGEST_PATH" with
  | None -> huge_path ()
  | Some s ->
    (match int_of_string_opt s with
     | Some n -> n
     | None -> exit 1)
;;

let max_nfa_size =
  match Sys.getenv_opt "CHRO_NFA_SIZE" with
  | None -> 1500000
  | Some s ->
    (match int_of_string_opt s with
     | Some n -> n
     | None -> exit 1)
;;

let max_under_const =
  match Sys.getenv_opt "CHRO_MAX_UNDER" with
  | None -> 5000
  | Some s ->
    (match int_of_string_opt s with
     | Some n -> n
     | None -> exit 1)
;;

let parse_args () =
  (* Printf.printf "%s %d\n%!" __FILE__ __LINE__; *)
  let usage_msg =
    {|Chrobak normal form in Exponential Linear Integer Arithmetic and Strings.
Usage: chro [options] <file.smt2>

Basic options:
|}
  in
  let rec spec_list =
    [ ( "-bound"
      , Arg.Int (fun n -> config.under_approx <- n)
      , "\tUpper bound for integer underapproximation (negative disables)" )
    ; ( "-bres"
      , Arg.Int (fun n -> config.bound_res <- n)
      , "<n>\tMaximal residue used in the NFA Solver" )
    ; ( "-bstates"
      , Arg.Int (fun n -> config.bound_states <- n)
      , "<n>\tMaximal number of states in NFAs used in ChrobakNF construction" )
    ; ( "-huge-c"
      , Arg.Int (fun n -> huge_const_config.const <- n)
      , Printf.sprintf
          "<n> \tAdmit integer constants with at most <n> digits (DEFAULT n=%d)"
          (huge_const ()) )
    ; ( "-huge"
      , Arg.Int (fun n -> huge_const_config.path <- n)
      , Printf.sprintf
          "<n> \tSearch a model with at most <n> symbols (DEFAULT n=%d)"
          (huge_path ()) )
    ; ( "-lsb"
      , Arg.Unit (fun () -> config.mode <- `Lsb)
      , "  \tUse least-significant-bit first representation" )
    ; ( "-no-mod-eq"
      , Arg.Unit (fun () -> config.mod_eq <- false)
      , "\tDisable the congruence automaton: lower every 'mod' to a quotient and a \
         remainder" )
    ; ( "-no-model"
      , Arg.Unit (fun () -> config.no_model <- true)
      , "\tDisable model generation subroutines" )
    ; ( "-no-over"
      , Arg.Unit (fun () -> config.over_approx <- false)
      , "\tDisable simple Z3 overapprox" )
    ; ( "-no-str-under"
      , Arg.Unit
          (fun () ->
            under_str_config.max_cnt <- -1;
            under_str_config.max_len <- -1)
      , "Disable string underapproximations in concats" )
    ; ( "-sbcnt"
      , Arg.Int (fun n -> under_str_config.max_cnt <- n)
      , "<n>\tUnderapproximate strings in concats via first <n> words w.r.t. regexes \
         (DEFAULT n=32)" )
    ; ( "-sblen"
      , Arg.Int (fun n -> under_str_config.max_len <- n)
      , "<n>\tUnderapproximate strings in concats via words of length at most <n> \
         (DEFAULT n=32)" )
      (*; ( "-over"
      , Arg.Unit (fun () -> config.over_approx <- true)
      , "\tSimple overapprox" )*)
      (* ; ( "-over-early"
      , Arg.Unit (fun () -> config.over_approx_early <- true)
      , "\tSimple overapprox before underapprox II" ) *)
    ; ( "-under-all"
      , Arg.Unit (fun () -> config.under_str_all <- true)
      , "  \tApply string underapproximation for each string variable" )
    ; ( "-budget"
      , Arg.Float (fun x -> config.under_str_budget <- x)
      , "<s>\tSeconds to spend on string under-approximations before falling through to \
         the full check (DEFAULT 1.0, negative for no limit)" )
    ; ( "-help"
      , Arg.Unit (fun () -> raise (Arg.Help (Arg.usage_string spec_list usage_msg)))
      , "\tDisplay this list of options\n\nMiscellaneous:\n" )
    ; ( "-q"
      , Arg.Unit (fun () -> config.quiet <- true)
      , "   \tPrint 'unknown' instead of Exceptions\t" )
    ; ( "--apren"
      , Arg.String
          (function
            | "push-reg" | "push_reg" -> config.antiprenex_mode <- `Push_re
            | "all" -> config.antiprenex_mode <- `All
            | "no" | "disable" -> config.antiprenex_mode <- `Disable
            | s -> raise (Arg.Help (Arg.usage_string spec_list usage_msg)))
      , "\tAntiprenex mode [all; push-reg; disable]" )
    ; ( "--stop-after"
      , Arg.String
          (function
            | "predpll" | "pre_dpll" | "pre-dpll" -> config.stop_after <- `Pre_dpll
            | "simpl" -> config.stop_after <- `Simpl
            | "presimpl" | "pre_simpl" | "pre-simpl" | "simpl2" ->
              config.stop_after <- `Pre_simplify
            | s -> raise (Arg.Help (Arg.usage_string spec_list usage_msg)))
      , "\tStop after step [presimpl; pre-dpll; simpl]" )
    ; ( "--check-model"
      , Arg.Unit (fun () -> config.check_model <- true)
      , "Сalculate a model and check its correctness" )
    ; ( "--info"
      , Arg.Unit (fun () -> config.with_info <- true)
      , "\tDisplay (un)sat decision step" )
    ; ( "--no-str-bv"
      , Arg.Unit (fun () -> config.no_str_bv <- true)
      , "\tSwitch labels encoding in nfa to 'char's" )
    ; ( "--no-parallel"
      , Arg.Unit (fun () -> config.parallel <- false)
      , "Disable running the string-underapproximation strategy and the normal one in \
         parallel processes to take the first definitive answer" )
      (* ; ( "--no-alpha"
      , Arg.Unit (fun () -> config.simpl_alpha <- false)
      , "\tDon't try simplifications based on alpha-equivalence" )
    ; ( "--alpha"
      , Arg.Unit (fun () -> config.simpl_alpha <- true)
      , "\tDO simplifications based on alpha-equivalence" ) *)
    ; ( "--over-nfa"
      , Arg.Unit (fun () -> config.over_nfa <- true)
      , "\tOverapproximate orderings within the NFA Solver" )
    ; ( "--inner-dpll"
      , Arg.Unit (fun () -> config.light_dpll <- true)
      , "\tEnable the nested inner DPLL procedure for enumerating \
         empty/number/not-a-number string states" )
      (* ; "--no-mono", Arg.Unit (fun () -> config.simpl_mono <- false), "\t" *)
    ; "--dsimpl", Arg.Unit (fun () -> config.dump_simpl <- true), "\tDump simplifications"
    ; "--dir", Arg.Unit (fun () -> config.dump_ir <- true), "  \tDump IR"
    ; ( "--dpresimpl"
      , Arg.Unit (fun () -> config.dump_pre_simpl <- true)
      , "\tDump AST simplifications" )
    ; ( "--help"
      , Arg.Unit (fun () -> raise (Arg.Help (Arg.usage_string spec_list usage_msg)))
      , "\tDisplay this list of options" )
      (* ; ( "--no-model-check"
      , Arg.Unit (fun () -> config.check_model <- false)
      , "\tSkip running model check after (get-model)" ) *)
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
