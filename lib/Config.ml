type config =
  { mutable enc_base : int
  ; mutable check_sat_range : bool
  ; mutable base_min : int
  ; mutable base_max : int
  ; mutable base_to : int option
  ; mutable search_depth : int
  ; mutable antiprenex_mode : [ `All | `Push_re | `Disable ]
  ; mutable bool_comb_sat : bool
  ; mutable dump_simpl : bool
  ; mutable dump_pre_simpl : bool
  ; mutable dump_ir : bool
  ; mutable error_check : bool
  ; mutable good_for_minimize : int
  ; mutable huge_for_inter : int
  ; mutable input_file : string
  ; mutable logic : [ `Eia | `Str | `StrBv | `Par | `Sym ]
  ; mutable mode : [ `Msb | `Lsb ]
  ; mutable over_approx : bool
  ; mutable path_search : [ `Dfs | `Bfs ]
  ; mutable pre_simpl : bool
  ; mutable problem : [ `Uni | `Exi ]
  ; mutable quiet : bool
  ; mutable stop_after : [ `Simpl | `Pre_simplify | `Solving ]
  ; mutable under_approx : int
  ; mutable check_model : bool
  ; mutable seed : int
  ; mutable seed_attempts : int
  ; mutable with_check_sat : bool
  ; mutable with_info : bool
  }
[@@deriving show]

let config =
  { enc_base = 10
  ; check_sat_range = false
  ; base_min = 10
  ; base_max = 10
  ; base_to = None
  ; search_depth = 5
  ; antiprenex_mode = `All
  ; bool_comb_sat = false
  ; stop_after = `Solving
  ; dump_pre_simpl = false
  ; dump_simpl = false
  ; dump_ir = false
  ; error_check = true
  ; good_for_minimize = 15
  ; huge_for_inter = 500000
  ; input_file = ""
  ; logic = `Sym
  ; mode = `Msb
  ; over_approx = false
  ; path_search = `Dfs
  ; problem = `Exi
  ; pre_simpl = true
  ; quiet = false
  ; under_approx = -1
  ; check_model = false
  ; seed = 42
  ; seed_attempts = 10
  ; with_check_sat = false
  ; with_info = false
  }
;;

type string_config =
  { zero : char
  ; one : char
  ; null : char
  ; eos : char
  }

let string_config = { zero = '0'; one = '1'; null = Char.chr 0; eos = Char.chr 3 }
let base = "base"

let max_nfa_size =
  match Sys.getenv_opt "CHRO_NFA_SIZE" with
  | None -> 1500000
  | Some s ->
    (match int_of_string_opt s with
     | Some n -> n
     | None -> exit 1)
;;

let parse_args () =
  (* Printf.printf "%s %d\n%!" __FILE__ __LINE__; *)
  let usage_msg =
    {|Solver for parametric symbolic quantifier-free Büchi arithmetic with unay regular constraints in defferent bases.

Usage: parsym [options] <file.smt2>

Basic options:
|}
  in
  let rec spec_list =
    [ ( "-base"
      , Arg.Int
          (fun n ->
            config.enc_base <- n;
            config.base_min <- n;
            config.base_max <- n)
      , "<n>\tSet the encoding base for integer representation (DEFAULT VALUE: 10)" )
    ; ( "-bmin"
      , Arg.Int (fun n -> config.base_min <- n)
      , "<n>\tSet the minimal encoding base for check-sat (DEFAULT VALUE: 10)" )
    ; ( "-bmax"
      , Arg.Int (fun n -> config.base_max <- n)
      , "<n>\tSet the maximal encoding base for check-sat (DEFAULT VALUE: 10)" )
    ; ( "-bTO"
      , Arg.Int (fun n -> config.base_to <- Some n)
      , "<n>\tSet the timeout value for check-sat per Z3 random seed" )
    ; ( "-lazy"
      , Arg.Unit (fun () -> config.bool_comb_sat <- true)
      , "\tCheck satisfiability without performing Boolean operations over automata, \
         whenever possible" )
    ; ( "-par"
      , Arg.Unit (fun n -> config.logic <- `Par)
      , "\t\tCheck satisfiability for all bases in [bmin; bmax] using parametric \
         symbolic automata" )
    ; ( "-problem"
      , Arg.String
          (function
            | "e" | "existence" -> config.problem <- `Exi
            | "u" | "universality" -> config.problem <- `Uni
            | s -> raise (Arg.Help (Arg.usage_string spec_list usage_msg)))
      , "\tProblem for the range of bases [e; u] (DEFAULT VALUE: existence)" )
    ; ( "-help"
      , Arg.Unit (fun () -> raise (Arg.Help (Arg.usage_string spec_list usage_msg)))
      , "\tDisplay this list of options\n\nMiscellaneous:\n" )
      (* ; ( "--bfs"
      , Arg.Unit (fun () -> config.path_search <- `Bfs)
      , "\tSwitch to bfs in parametric check_sat\t" ) *)
    ; ( "--active"
      , Arg.Int (fun n -> config.huge_for_inter <- n)
      , "<n>\tSet the maximal (approximate) number of states for the 'active' mode \
         (DEFAULT VALUE: 200000)" )
    ; ( "--check-model"
      , Arg.Unit (fun () -> config.check_model <- true)
      , "Сalculate a model and check its correctness (BASE 10)" )
    ; ( "--info"
      , Arg.Unit (fun () -> config.with_info <- true)
      , "\tPrint results for each base" )
    ; ( "--depth"
      , Arg.Int (fun n -> config.search_depth <- n)
      , "<n>\tSet the maximal neighbours depth in DFS search" )
    ; "--seed", Arg.Int (fun v -> config.seed <- v), "<n>\tSpecify a seed for Z3"
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

let () = parse_args ()
