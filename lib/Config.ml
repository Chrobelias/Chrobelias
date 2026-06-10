type config =
  { mutable enc_base : int
  ; mutable antiprenex_mode : [ `All | `Push_re | `Disable ]
  ; mutable bool_comb_sat : bool
  ; mutable bound_res : int
  ; mutable bound_states : int
  ; mutable dump_simpl : bool
  ; mutable dump_pre_simpl : bool
  ; mutable dump_ir : bool
  ; mutable dump_lics : bool
  ; mutable error_check : bool
  ; mutable good_for_minimize : int
  ; mutable good_for_shrinking : int
  ; mutable input_file : string
  ; mutable logic : [ `Eia | `Str | `StrBv | `Par ]
  ; mutable mode : [ `Msb | `Lsb ]
  ; mutable no_model : bool
  ; mutable no_str_bv : bool
  ; mutable over_approx : bool
  ; mutable over_approx_early : bool
  ; mutable over_nfa : bool
  ; mutable path_search : [ `Dfs | `Bfs ]
  ; mutable pre_simpl : bool
  ; mutable quiet : bool
  ; mutable simpl_alpha : bool
  ; mutable simpl_mono : bool
  ; mutable stop_after : [ `Simpl | `Pre_simplify | `Solving ]
  ; mutable under_approx : int
  ; mutable under_str_all : bool
  ; mutable with_check_sat : bool
  ; mutable with_info : bool
  ; mutable check_model : bool
  ; mutable seed : int
  }
[@@deriving show]

let config =
  { enc_base = 10
  ; antiprenex_mode = `All
  ; bool_comb_sat = false
  ; bound_res = -1
  ; bound_states = -1
  ; stop_after = `Solving
  ; dump_lics = false
  ; dump_pre_simpl = false
  ; dump_simpl = false
  ; dump_ir = false
  ; error_check = true
  ; good_for_minimize = 15
  ; good_for_shrinking = 20
  ; input_file = ""
  ; logic = `Par
  ; mode = `Msb
  ; no_model = false
  ; no_str_bv = false
  ; over_approx = false
  ; over_approx_early = false
  ; over_nfa = false
  ; path_search = `Dfs
  ; pre_simpl = true
  ; quiet = false
  ; simpl_alpha = false
  ; simpl_mono = true
  ; under_approx = -1
  ; under_str_all = false
  ; with_check_sat = false
  ; with_info = true
  ; check_model = false
  ; seed = Sys.time () |> Int.of_float
  }
;;

type string_config =
  { zero : char
  ; one : char
  ; null : char
  ; eos : char
  }

let string_config = { zero = '0'; one = '1'; null = Char.chr 0; eos = Char.chr 3 }

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
    {|Parametric Linear Integer Arithmetic Solver.
Usage: par [options] <file.smt2>

Basic options:
|}
  in
  let rec spec_list =
    [ ( "--base" 
      , Arg.Int (fun n -> config.enc_base <- n)
      , "\tSet the encoding base for integer representation" )
    ; ( "--help"
      , Arg.Unit (fun () -> raise (Arg.Help (Arg.usage_string spec_list usage_msg)))
      , "\tDisplay this list of options\n\nMiscellaneous:\n" )
    ; ( "--bfs"
      , Arg.Unit (fun () -> config.path_search <- `Bfs)
      , "\tSwitch to bfs in parametric check_sat\t" )
    ; ( "--check-model"
      , Arg.Unit (fun () -> config.check_model <- true)
      , "Сalculate a model and check its correctness" )
    ; ( "--lazy-operations"
      , Arg.Unit (fun () -> config.bool_comb_sat <- true)
      , "\tCheck satisfiability without performing Boolean operations over automata, whenever possible" )
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
