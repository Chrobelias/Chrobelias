(*
   Use as:

   find benchmarks/QF_LIA/LoAT -iname '*.smt2' | dune exec benchmarks/promote_info.exe -- -t 5 -
*)

let () = Printexc.record_backtrace true

type info =
  { mutable i_skipped : int
  ; mutable i_sat : int
  ; mutable i_unsat : int
  ; mutable i_unknown : int
  ; mutable timeout : int
  ; mutable files : string list
  ; mutable stdin : bool
  }

let info =
  { i_skipped = 0
  ; i_sat = 0
  ; i_unsat = 0
  ; i_unknown = 0
  ; timeout = 2
  ; files = []
  ; stdin = false
  }
;;

let inc_skipped () = info.i_skipped <- 1 + info.i_skipped
let inc_sat () = info.i_sat <- 1 + info.i_sat
let inc_unsat () = info.i_unsat <- 1 + info.i_unsat
let inc_unknown () = info.i_unknown <- 1 + info.i_unknown
let swine = ref "_build/default/bin/swine"

let () =
  Arg.parse
    [ "-t", Arg.Int (fun n -> info.timeout <- n), " <INT> set timeout"
    ; "-", Arg.Unit (fun () -> info.stdin <- true), " "
    ]
    (fun s -> info.files <- s :: info.files)
    "promote_info -t TIMEOUT FILE1 FILE2 ..."
;;

let prepend ~file kind contents =
  Out_channel.with_open_text file (fun ch ->
    Printf.fprintf
      ch
      (match kind with
       | `Sat -> "(set-info :status sat) ; swine result\n"
       | `Unsat -> "(set-info :status unsat) ; swine result\n");
    Printf.fprintf ch "%s" contents;
    flush ch)
;;

let on_file file =
  let contents = In_channel.with_open_text file In_channel.input_all in
  if Base.String.is_substring contents ~substring:":status"
  then
    (* Printf.eprintf "Skip %s\n%!" file; *)
    inc_skipped ()
  else (
    let cmd = Printf.sprintf "timeout %d %s %s" info.timeout !swine file in
    let on_unknown () =
      (* Format.printf "@[%s@]\n%!" swine_text; *)
      Format.printf "neither SAT nor UNSAT\n%!";
      Printf.printf "cmd = %s\n%!" cmd;
      inc_unknown ()
    in
    try
      let swine_text =
        let ch = Unix.open_process_in cmd in
        let s = In_channel.input_all ch in
        close_in ch;
        s
      in
      if Base.String.is_prefix swine_text ~prefix:"unsat\n"
      then (
        prepend ~file `Unsat contents;
        Printf.eprintf "UNSAT %s\n%!" file;
        inc_unsat ())
      else if Base.String.is_prefix swine_text ~prefix:"sat\n"
      then (
        prepend ~file `Sat contents;
        Printf.eprintf "SAT   %s\n%!" file;
        inc_sat ())
      else on_unknown ()
    with
    | Unix.Unix_error (Unix.EMFILE, "pipe", "") as exc ->
      Printf.eprintf "%s\n%s\n%!" cmd (Printexc.to_string exc);
      on_unknown ())
;;

let () =
  if info.stdin
  then (
    let files = In_channel.input_lines stdin in
    info.files <- files)
;;

let () =
  List.iter
    (fun file ->
       let () =
         if not (Sys.file_exists file)
         then (
           let () = Printf.eprintf "file '%s' not found\n%!" file in
           exit 1)
       in
       on_file file)
    info.files
;;

let print_stats () =
  Printf.printf "SAT:     %d\n" info.i_sat;
  Printf.printf "UNSAT:   %d\n" info.i_unsat;
  Printf.printf "unknown: %d\n" info.i_unknown;
  Printf.printf "skipped: %d\n" info.i_skipped
;;

let () = print_stats ()
