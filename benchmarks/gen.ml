type mode =
  | Default
  | Script of string

type config =
  { mutable outdir : string
  ; mutable path : string
  ; mutable timeout : int
  ; mutable dot_dot_count : int
    (** This is needed to insert right number of ../ to access benchmarks.
        Probably it could be calculated from two paths, but it is postponed for later. *)
  ; mutable suffix : string
  ; mutable mode : mode
  }

let config =
  { outdir = "."
  ; path = "."
  ; timeout = 2
  ; dot_dot_count = 5
  ; suffix = ".smt2"
  ; mode = Default
  }
;;

let () =
  Arg.parse
    [ "-o", Arg.String (fun s -> config.outdir <- s), ""
    ; "-ddc", Arg.Int (fun s -> config.dot_dot_count <- s), ""
    ; ( "-t"
      , Arg.Int
          (fun n ->
            assert (n >= 0);
            config.timeout <- n)
      , "" )
    ; "-b", Arg.String (fun s -> config.mode <- Script s), " "
    ]
    (fun s -> config.path <- s)
    "help"
;;

let () =
  if Base.String.is_substring config.path ~substring:"EXP-solver"
  then config.suffix <- ""
  else ()
;;

let is_good_smt2_file ~path filename =
  (* Printf.printf "path  = %s\n" path;
  Printf.printf "fname = %s\n" filename; *)
  let suffix = ".smt2" in
  if Base.String.is_substring path ~substring:"EXP-solver"
  then if String.ends_with filename ~suffix:"-result" then None else Some filename
  else (
    let has_bad_expo str =
      Str.string_match (Str.regexp "exp i") str 0
      || Str.string_match (Str.regexp "exp 5") str 0
    in
    let c1 = String.ends_with filename ~suffix in
    let check2 () =
      let strs =
        In_channel.with_open_text
          (path ^ Filename.dir_sep ^ filename)
          In_channel.input_lines
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
    in
    if c1 && check2 ()
    then Some (Base.String.drop_suffix filename (String.length suffix))
    else None)
;;

let max_tests_count = 4444 [@@ocaml.warning "-32"]

let find_files path =
  let dir = Unix.opendir path in
  (* let c = ref 0 in *)
  let rec loop acc =
    try
      match Unix.readdir dir with
      | "paras" | ".." | "." | ".DS_Store" -> loop acc
      | s ->
        let newacc =
          match is_good_smt2_file ~path s with
          | Some s ->
            (* String.sub s 0 (String.length s - String.length suffix)  *)
            s :: acc
          | _ ->
            (* let () = Printf.eprintf "File %s is skipped\n" s in *)
            acc
        in
        loop newacc
    with
    | End_of_file ->
      Unix.closedir dir;
      acc
  in
  loop [] |> List.sort String.compare
;;

(* let files = loop [] |> List.sort String.compare in
  List.iter
    (fun basename ->
       let () = incr c in
       Printf.printf "Processing: %s...\n" basename;
       f basename)
    files *)

let get_extra_flags =
  let data =
    [ "java_Duplicate.c.t2.smt2_32.smt2", "-bound 0 -under2 -amin 1 -amax 1"
    ; "EXP-solver/Benchmark/HashFunction/", "-huge 100"
    ]
  in
  let _conflicts_simpl_alpah =
    [ "Norn/HammingDistance/norn-benchmark-5"
    ; "Norn/ab/norn-benchmark-69"
    ; "Norn/ChunkSplit/norn-benchmark-7"
    ; "stringfuzz" (* ; "EXP-solver/Benchmark/HashFunction/all" *)
    ]
  in
  (* let list_contains (cond : _ -> bool) xs =
    try
      let _ = List.find cond xs in
      true
    with
    | Not_found -> false
  in *)
  fun s ->
    (* Printf.printf "file = %s\n%!" file; *)
    let _file = Filename.basename s in
    try
      let _, opts =
        List.find (fun (substring, _) -> Base.String.is_substring ~substring s) data
      in
      opts
    with
    | Not_found -> ""
;;

(* try List.assoc file data with
      | Not_found ->
        if
          list_contains
            (fun substring -> Base.String.is_substring ~substring s)
            conflicts_simpl_alpah
        then " --no-simpl-alpha "
        else "" *)

let dune_str = "dune build --no-print-directory --profile=benchmark"

let t_file ~file smt2_file =
  let tfilename = file ^ ".t" in
  Out_channel.with_open_text
    (config.outdir ^ "/" ^ tfilename)
    (fun tch ->
       let tfmt = Format.formatter_of_out_channel tch in
       let printf fmt = Format.fprintf tfmt fmt in
       let extra_flags = get_extra_flags smt2_file in
       printf "%s\n%!" file;
       printf "  $ export OCAMLRUNPARAM='b=0'\n";
       let smt2_file =
         if Base.String.is_substring smt2_file ~substring:"EXP-solver"
         then (
           let custom_in = Filename.basename smt2_file ^ ".smt2" in
           printf "  $ printf '(set-logic QF_S)\\n' > %s\n" custom_in;
           printf "  $ grep -v set-logic %s >> %s\n" smt2_file custom_in;
           printf "$ cat %s\n" custom_in;
           custom_in)
         else smt2_file
       in
       if config.timeout > 0
       then
         printf
           "  $ timeout %d Chro %s %s || echo TIMEOUT\n"
           config.timeout
           smt2_file
           extra_flags
       else printf "  $ Chro %s\n" smt2_file;
       Format.pp_print_flush tfmt ())
;;

let files = find_files config.path

let make_smt2_file file =
  Printf.sprintf
    "%s/%s/%s%s"
    (String.concat "/" (List.init config.dot_dot_count (fun _ -> "..")))
    config.path
    file
    config.suffix
;;

let prepare_default () =
  let mk_joined_makefile ppf files =
    Format.fprintf ppf "\n.PHONY: fast\n";
    Format.fprintf ppf "fast:\n";
    let rec loop = function
      | [] -> ()
      | xs ->
        let prefix = List.take 5 xs in
        Format.fprintf
          ppf
          "\t%s --au @%s || exit 0\n"
          dune_str
          (String.concat " @" prefix);
        loop (List.drop 5 xs)
    in
    loop files;
    Format.fprintf ppf "\n\n"
  in
  Out_channel.with_open_text (config.outdir ^ "/dune") (fun dunech ->
    Out_channel.with_open_text (config.outdir ^ "/Makefile") (fun makech ->
      let dfmt = Format.formatter_of_out_channel dunech in
      let dprintf ppf = Format.kasprintf (Format.fprintf dfmt "%s\n") ppf in
      let mfmt = Format.formatter_of_out_channel makech in
      let mprintf ppf = Format.kasprintf (Format.fprintf mfmt "%s\n") ppf in
      dprintf "; This file was autogenerated by";
      dprintf "; %s\n" (Array.fold_left ( ^ ) "" Sys.argv);
      dprintf "(cram";
      dprintf " (deps %%{bin:Chro}))\n";
      mprintf "# This file was autogenerated";
      mprintf "#AU ?= ";
      mprintf "all:\n";
      let makefile_single file =
        mprintf ".PHONY: %s" file;
        mprintf "all: %s" file;
        mprintf "%s:" file;
        mprintf "\t%s @%s --au || exit 0\n" dune_str file
      in
      let dune_single ~file smt2_file =
        dprintf "(cram";
        dprintf " (applies_to %s)" file;
        dprintf " (enabled_if";
        dprintf "  (= benchmark %%{profile}))";
        dprintf " (deps %s))\n" smt2_file
      in
      ListLabels.iter files ~f:(fun file ->
        makefile_single file;
        (* Printf.printf "%d: file = %s\n%!" __LINE__ file; *)
        let smt2_file = make_smt2_file file in
        dune_single ~file smt2_file;
        t_file ~file smt2_file);
      mk_joined_makefile mfmt files;
      Format.pp_print_flush mfmt ();
      Format.pp_print_flush dfmt ()))
;;

let prepare_script ~script =
  let on_file ppf file =
    let printfn fmt = Format.kasprintf (Format.fprintf ppf "%s\n") fmt in
    let smt2file = Printf.sprintf "%s/%s%s" config.path file config.suffix in
    let extra_flags =
      String.concat
        " "
        [ (if
             Base.String.is_substring
               smt2file
               ~substring:"EXP-solver/Benchmark/HashFunction"
           then "-huge 100"
           else "")
        ]
    in
    printfn "#";
    printfn "sed 's/QF_SLIA/QF_S/g' -i %s" smt2file;
    printfn "export TIMEOUT=%d" config.timeout;
    printfn "SECONDS=0";
    printfn "printf '%s...\n'" smt2file;
    printfn
      "if timeout $TIMEOUT /usr/bin/time -f '%%U' dune exec Chro --profile=release -- %s \
       -q %s > .log"
      smt2file
      extra_flags;
    printfn "then";
    printfn "  grep '^unsat' .log || true";
    printfn "  grep '^sat' .log || true";
    printfn "  grep '^unknown' .log || true";
    printfn "  #echo \"seconds = $SECONDS\"";
    printfn "fi"
  in
  Out_channel.with_open_text script (fun ch ->
    let ppf = Format.formatter_of_out_channel ch in
    Format.fprintf ppf "#!/usr/bin/env bash\n\n%!";
    Format.fprintf ppf "export OCAMLRUNPARAM='b=0'\n%!";
    Format.fprintf ppf "dune b bin/chro.exe --profile=release\n";
    List.iter (on_file ppf) files;
    Format.pp_print_flush ppf ();
    flush ch)
;;

let () =
  match config.mode with
  | Default -> prepare_default ()
  | Script script -> prepare_script ~script
;;
