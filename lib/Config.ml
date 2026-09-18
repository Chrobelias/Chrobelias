type config =
  { mutable antiprenex_mode : [ `All | `Push_re | `Disable ]
  ; mutable dyn_bounds : bool
  ; mutable base : int option
  ; mutable dump_simpl : bool
  ; mutable dump_pre_simpl : bool
  ; mutable dump_ir : bool
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
  ; mutable nielsen : bool
  ; mutable no_model : bool
  ; mutable no_str_bv : bool
  ; mutable over_approx : bool
  ; mutable over_nfa : bool
  ; mutable pre_simpl : bool
  ; mutable quiet : bool
  ; mutable simpl_alpha : bool
  ; mutable simpl_mono : bool
  ; mutable stop_after : [ `Pre_dpll | `Pre_simplify | `Simpl | `Solving ]
  ; mutable under_approx : int
  ; mutable under_str_all : bool
    (* Run the string-under-approx strategy and the normal one at the same
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
  ; dyn_bounds = true
  ; base = None
  ; stop_after = `Solving
  ; dump_pre_simpl = false
  ; dump_simpl = false
  ; dump_ir = false
  ; good_for_minimize = 15
  ; good_for_shrinking = 20
  ; pre_simpl = true
  ; over_approx = true
  ; over_nfa = false
  ; input_file = ""
  ; logic = `Eia
  ; mode = `Msb
  ; mod_eq = true
  ; nielsen = false
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

type under_str_config =
  { mutable max_len : int
  ; mutable max_cnt : int
    (* Total environments (candidate-string tuples) allowed per enumeration
       round. The per-variable candidate count is [max_envs ** (1/m)] for [m]
       variables, so a single unconstrained variable gets thousands of
       candidates while three variables get a handful each -- balanced
       against the size of the product instead of a flat per-variable bound. *)
  ; mutable max_envs : int
  }

type huge_const_config =
  { mutable const_model : int
  ; mutable path : int
  }

type string_config =
  { zero : char
  ; one : char
  ; null : char
  ; eos : char
  }

let huge_const_config = { const_model = 120; path = 10000 }

(* Digits, in the solver's base, allowed for an integer in the constraints the
   model shrinking adds before re-solving. Not a flag: it is a number the
   re-solve has to stay small enough to answer, not a preference. Raising it to
   [path] sends [z = 2 ** (2 ** x), x >= 100] back to exhausting memory. *)
let huge_const () = 20

(* The same question for the simplifier's rewrite [v <= c ==> base ** v <=
   base ** c] is a different one: there the only requirement is that [base ** c]
   can be built at all, which is why it does not share the number above. *)
let huge_rewrite_const () = 100
let huge_path () = huge_const_config.path
let huge_const_for_model () = huge_const_config.const_model

(* Bits allowed in a constant power that the simplifier evaluates. *)
let huge_pow_bits () = 1_000_000
let under_str_config = { max_len = 32; max_cnt = 32; max_envs = 8192 }
let bounded_unsat = ref false
let string_config = { zero = '0'; one = '1'; null = Char.chr 0; eos = Char.chr 3 }
let base = ref 10

let set_base ?ast_base () =
  base
  := Option.value
       ~default:(Option.value ~default:(if config.logic = `Eia then 2 else 10) ast_base)
       config.base
;;

let env_int name default =
  match Sys.getenv_opt name with
  | None -> default
  | Some s ->
    (match int_of_string_opt s with
     | Some n -> n
     | None -> exit 1)
;;

(* Residues the exponent elimination may spend in total ([residue_bound]
   draws from this one), and the state-scan budget [effective_bound_states]
   takes the square root of for its per-automaton state bound. Precedence:
   the -bres / -bstates flags, then the env var, then the default. Same names
   as the flags removed in b40aed21, different meaning: those were static
   bounds that switched the retry ladder off. *)
let dyn_leaf_budget = ref (env_int "CHRO_DYN_LEAVES" 16)
let dyn_scan_budget = ref (env_int "CHRO_DYN_SCAN" 144)

(* Retries the elimination may make before giving up. Unlimited by default;
   bounding it pins one truncation level, which is how the gate that turns a
   truncated refutation into [unknown] is tested. *)
let dyn_max_attempts = env_int "CHRO_DYN_ATTEMPTS" max_int
let dyn_scale = ref 1
let dyn_budget = ref 0
let dyn_reset_budget () = dyn_budget := !dyn_leaf_budget * !dyn_scale

(* Truncation is sound only where the caller wants an under-approx.
   The elimination does; [Overapprox.in_re] wants the opposite and trusts its
   own Unsat. So the bounds apply inside the elimination stage only, set by
   [Solver.check_sat]; every other ChrobakNF stays exact. *)
let dyn_stage = ref false

(* State bound for the regex length folding in [Overapprox.in_re] and
   [SimplII.arithmetize_in_re]. Sound only because [Nfa.chrobak] reports
   [exhaustive_upto] and both callers add a "len > that" disjunct, keeping the
   abstraction an over-approx. *)
let regex_bound =
  match Sys.getenv_opt "CHRO_REGEX_BOUND" with
  | None -> 20
  | Some s ->
    (match int_of_string_opt s with
     | Some n -> n
     | None -> exit 1)
;;

let dyn_enabled () = config.dyn_bounds && !dyn_stage

let in_dyn_stage f =
  let saved = !dyn_stage in
  dyn_stage := true;
  Fun.protect ~finally:(fun () -> dyn_stage := saved) f
;;

let residue_bound c =
  if not (dyn_enabled ())
  then -1
  else (
    let rem = !dyn_budget in
    let r = if rem <= 0 then 2 else min c (max 2 rem) in
    dyn_budget := rem - min c r;
    if r >= c then -1 else r)
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
  let usage_msg =
    {|Chrobak normal form in Exponential Linear Integer Arithmetic and Strings.
Usage: chro [options] <file.smt2>

Basic options:
|}
  in
  (* [Arg] renders an entry as "  <key> <doc>", so the description starts at
     column [3 + length key], plus a leading "<n>" where the option takes an
     argument. Padding every doc out to one column here keeps the table
     aligned whatever the keys are; the per-entry tabs it replaces drifted
     silently as soon as a longer key was added. *)
  let align col specs =
    let split doc =
      let n = String.length doc in
      let after_ph =
        if n > 0 && doc.[0] = '<'
        then (
          match String.index_opt doc '>' with
          | Some i -> i + 1
          | None -> 0)
        else 0
      in
      let rec skip i = if i < n && doc.[i] = ' ' then skip (i + 1) else i in
      after_ph, skip after_ph
    in
    List.map
      (fun (key, spec, doc) ->
         if doc = ""
         then key, spec, doc
         else (
           let ph_end, text = split doc in
           let pad = max 1 (col - (3 + String.length key + ph_end)) in
           ( key
           , spec
           , String.sub doc 0 ph_end
             ^ String.make pad ' '
             ^ String.sub doc text (String.length doc - text) )))
      specs
  in
  let specs = ref [] in
  let help () = raise (Arg.Help (Arg.usage_string !specs usage_msg)) in
  specs
  := align
       18
       [ ( "-bound"
         , Arg.Int (fun n -> config.under_approx <- n)
         , Printf.sprintf
             "<n> Bound for integer underapproximation (DEFAULT %d; <0 disables)"
             config.under_approx )
       ; ( "-lsb"
         , Arg.Unit (fun () -> config.mode <- `Lsb)
         , "Least-significant-bit-first representation" )
       ; ( "-nielsen"
         , Arg.Unit (fun () -> config.nielsen <- true)
         , "Nielsen transformations for word equations in the simplifier" )
       ; ( "-no-mod-eq"
         , Arg.Unit (fun () -> config.mod_eq <- false)
         , "Lower 'mod' to a quotient and remainder, not a congruence NFA" )
       ; "-no-model", Arg.Unit (fun () -> config.no_model <- true), "Do not build models"
       ; ( "-no-over"
         , Arg.Unit (fun () -> config.over_approx <- false)
         , "Do not run the Z3 overapproximation" )
       ; ( "-no-str-under"
         , Arg.Unit
             (fun () ->
               under_str_config.max_cnt <- -1;
               under_str_config.max_len <- -1)
         , "Do not underapproximate strings in concats" )
       ; ( "-under-all"
         , Arg.Unit (fun () -> config.under_str_all <- true)
         , "Underapproximate every string variable" )
       ; ( "-q"
         , Arg.Unit (fun () -> config.quiet <- true)
         , "Print 'unknown' instead of an exception" )
       ; ( "-no-info"
         , Arg.Unit (fun () -> config.with_info <- false)
         , "Do not print the stage that decided (un)sat" )
       ; "-help", Arg.Unit help, "Display this list of options\n\nTuning:\n"
       ; ( "-apren"
         , Arg.String
             (function
               | "push-reg" | "push_reg" -> config.antiprenex_mode <- `Push_re
               | "all" -> config.antiprenex_mode <- `All
               | "no" | "disable" -> config.antiprenex_mode <- `Disable
               | _ -> help ())
         , "Antiprenex mode [all; push-reg; disable]" )
       ; ( "-bres"
         , Arg.Int (fun n -> dyn_leaf_budget := n)
         , Printf.sprintf
             "<n> Total residues the exponent elimination may spend (DEFAULT %d)"
             !dyn_leaf_budget )
       ; ( "-bstates"
         , Arg.Int (fun n -> dyn_scan_budget := n)
         , Printf.sprintf
             "<n> Exact if states^2 <= <n>, else sqrt <n> states (DEFAULT %d)"
             !dyn_scan_budget )
       ; ( "-no-dyn"
         , Arg.Unit (fun () -> config.dyn_bounds <- false)
         , "Run the exponent elimination unbounded" )
       ; ( "-huge"
         , Arg.Int (fun n -> huge_const_config.path <- n)
         , Printf.sprintf
             "<n> Search a model of at most <n> symbols (DEFAULT %d)"
             (huge_path ()) )
       ; ( "-sbcnt"
         , Arg.Int (fun n -> under_str_config.max_cnt <- n)
         , Printf.sprintf
             "<n> Bound on word count in string underapproximation (DEFAULT %d)"
             under_str_config.max_cnt )
       ; ( "-sblen"
         , Arg.Int (fun n -> under_str_config.max_len <- n)
         , Printf.sprintf
             "<n> Bound on word length in string underapproximation (DEFAULT %d)"
             under_str_config.max_len )
       ; ( "-sbenvs"
         , Arg.Int (fun n -> under_str_config.max_envs <- n)
         , Printf.sprintf
             "<n> Bound on candidate environments per round (DEFAULT %d)"
             under_str_config.max_envs )
       ; ( "-budget"
         , Arg.Float (fun x -> config.under_str_budget <- x)
         , Printf.sprintf
             "<s> Seconds of string underapproximation, <0 no limit (DEFAULT %g)"
             config.under_str_budget )
       ; ( "-no-parallel"
         , Arg.Unit (fun () -> config.parallel <- false)
         , "Do not race string underapproximation against the normal run" )
       ; ( "-over-nfa"
         , Arg.Unit (fun () -> config.over_nfa <- true)
         , "Overapproximate orderings inside the NFA solver\n\nDebugging:\n" )
       ; ( "--check-model"
         , Arg.Unit (fun () -> config.check_model <- true)
         , "Calculate a model and check its correctness" )
       ; ( "--dsimpl"
         , Arg.Unit (fun () -> config.dump_simpl <- true)
         , "Dump the simplified IR" )
       ; ( "--dir"
         , Arg.Unit (fun () -> config.dump_ir <- true)
         , "Dump the IR at each solver step" )
       ; ( "--dpresimpl"
         , Arg.Unit (fun () -> config.dump_pre_simpl <- true)
         , "Dump the pre-simplified AST" )
       ; ( "--stop-after"
         , Arg.String
             (function
               | "predpll" | "pre_dpll" | "pre-dpll" -> config.stop_after <- `Pre_dpll
               | "simpl" -> config.stop_after <- `Simpl
               | "presimpl" | "pre_simpl" | "pre-simpl" | "simpl2" ->
                 config.stop_after <- `Pre_simplify
               | _ -> help ())
         , "Stop after step [presimpl; pre-dpll; simpl]\n\n\
            Tracing: CHRO_DEBUG=<tracer>[:<tracer>...] or CHRO_DEBUG=ANY, to stderr.\n" )
         (* Accepted, not listed. [--no-str-bv] picks the [Str] string encoding
            over [StrBv] and [--inner-dpll] enables the nested DPLL over string
            states; both are internal switches with no reading for a user, and
            [-help] already prints the table [--help] would. *)
       ; "--no-str-bv", Arg.Unit (fun () -> config.no_str_bv <- true), ""
       ; "--inner-dpll", Arg.Unit (fun () -> config.light_dpll <- true), ""
       ; "--help", Arg.Unit help, ""
       ];
  Arg.parse
    !specs
    (fun s ->
       if Sys.file_exists s
       then config.input_file <- s
       else Printf.eprintf "File %S doesn't exist\n" s)
    usage_msg
;;
