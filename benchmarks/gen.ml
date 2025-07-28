type config =
  { mutable outdir : string
  ; mutable path : string
  ; mutable dot_dot_count : int
  }

let config = { outdir = "."; path = "."; dot_dot_count = 5 }

let () =
  Arg.parse
    [ "-o", Arg.String (fun s -> config.outdir <- s), ""
    ; "-ddc", Arg.Int (fun s -> config.dot_dot_count <- s), ""
    ]
    (fun s -> config.path <- s)
    "help"
;;

let is_good_smt2_file filename =
  let strs = In_channel.with_open_text filename In_channel.input_lines in
  let has_bad_expo str =
    Str.string_match (Str.regexp "exp i") str 0
    || Str.string_match (Str.regexp "exp 5") str 0
  in
  try
    let _ =
      List.find
        (fun s ->
           (String.starts_with ~prefix:"(declare-fun " s
            && String.ends_with ~suffix:" Bool)" s)
           || has_bad_expo s)
        strs
    in
    false
  with
  | Not_found -> true
;;

let max_tests_count = 4444

let for_file path ~f =
  let dir = Unix.opendir path in
  let c = ref 0 in
  try
    while true do
      let s = Unix.readdir dir in
      let suffix = ".smt2" in
      if
        String.ends_with ~suffix s
        && is_good_smt2_file (path ^ "/" ^ s)
        && !c < max_tests_count
      then (
        let () = incr c in
        Printf.printf "Processing: %s...\n" s;
        f (String.sub s 0 (String.length s - String.length suffix)))
    done
  with
  | End_of_file ->
    Unix.closedir dir;
    ()
;;

let () =
  Out_channel.with_open_text (config.outdir ^ "/dune") (fun dunech ->
    let dfmt = Format.formatter_of_out_channel dunech in
    let dprintf ppf = Format.kasprintf (Format.fprintf dfmt "%s\n") ppf in
    for_file config.path ~f:(fun file ->
      let tfilename = file ^ ".t" in
      let smt2_file =
        Printf.sprintf
          "%s/%s/%s.smt2"
          (String.concat "/" (List.init config.dot_dot_count (fun _ -> "..")))
          config.path
          file
      in
      dprintf "(cram";
      dprintf "  (applies_to %s)" file;
      dprintf "  (deps %s))\n" smt2_file;
      Out_channel.with_open_text
        (config.outdir ^ "/" ^ tfilename)
        (fun tch ->
           let tfmt = Format.formatter_of_out_channel tch in
           Format.fprintf tfmt "%s\n%!" file;
           Format.fprintf tfmt "  $ export OCAMLRUNPARAM='b=0'\n";
           Format.fprintf tfmt "  $ Chro %s" smt2_file;
           Format.pp_print_flush tfmt ()));
    Format.pp_print_flush dfmt ())
;;
