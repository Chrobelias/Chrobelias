type mode =
  | Default
  | Script of string

type opponent =
  | Without [@ocaml.warnerror "-37"]
  | Swine

type config =
  { mutable outdir : string
  ; mutable path : string
  ; mutable timeout : int
  ; mutable dot_dot_count : int
    (** This is needed to insert right number of ../ to access benchmarks.
        Probably it could be calculated from two paths, but it is postponed for later. *)
  ; mutable suffix : string
  ; mutable mode : mode
  ; mutable opponent : opponent
  }

let config =
  { outdir = "."
  ; path = "."
  ; timeout = 2
  ; dot_dot_count = 5
  ; suffix = ".smt2"
  ; mode = Default
  ; opponent = Swine
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
    ; ( "-opp"
      , Arg.String
          (function
            | "swine" -> config.opponent <- Swine
            | "no" -> config.opponent <- Without
            | _ -> failwith "bad argument")
      , " " )
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
  let data = [ "java_Duplicate.c.t2.smt2_32.smt2", "-bound 0 -flat 0 -amin 1 -amax 1" ] in
  let conflicts_simpl_alpha =
    [ "Norn/HammingDistance/norn-benchmark-5"
    ; "Norn/ab/norn-benchmark-69"
    ; "Norn/ChunkSplit/norn-benchmark-7"
    ; "stringfuzz" (* ; "EXP-solver/Benchmark/HashFunction/all" *)
    ]
  in
  let list_contains (cond : _ -> bool) xs =
    try
      let _ = List.find cond xs in
      true
    with
    | Not_found -> false
  in
  fun s ->
    let file = Filename.basename s in
    (* Printf.printf "file = %s\n%!" file; *)
      try List.assoc file data with
      | Not_found ->
        if
          list_contains
            (fun substring -> Base.String.is_substring ~substring s)
            conflicts_simpl_alpha
        then " --no-alpha "
        else ""
;;

let dune_str = "dune build --no-print-directory --profile=benchmark"

let t_file ~file smt2_file =
  let tfilename = file ^ ".t" in
  Out_channel.with_open_text
    (config.outdir ^ "/" ^ tfilename)
    (fun tch ->
       let tfmt = Format.formatter_of_out_channel tch in
       let printf fmt = Format.fprintf tfmt fmt in
       let extra_flags =
         let s = get_extra_flags smt2_file in
         if s <> "" then " " ^ String.trim s else ""
       in
       printf "%s\n%!" file;
       printf "  $ export OCAMLRUNPARAM='b=0'\n";
       let smt2_file =
         if Base.String.is_substring smt2_file ~substring:"EXP-solver"
         then (
           let custom_in = Filename.basename smt2_file ^ ".smt2" in
           printf "  $ printf '(set-logic QF_SLIA)\\n' > %s\n" custom_in;
           printf "  $ grep -v set-logic %s >> %s\n" smt2_file custom_in;
           printf "$ cat %s\n" custom_in;
           custom_in)
         else smt2_file
       in
       if config.timeout > 0
       then
         printf
           "  $ timeout %d Chro %s%s || echo TIMEOUT\n"
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
      let () =
        dprintf "; This file was autogenerated by";
        let args =
          let cwd = Sys.getcwd () ^ Filename.dir_sep in
          let args = Array.copy Sys.argv in
          args.(0) <- Base.String.chop_prefix_if_exists ~prefix:cwd args.(0);
          args
        in
        dprintf ";%s\n" (Array.fold_left (fun acc x -> acc ^ " " ^ x) "" args)
      in
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

let prepare_script ?(opp = Swine) ~script () =
  let on_file ppf ~total curi file =
    let printfn fmt = Format.kasprintf (Format.fprintf ppf "%s\n") fmt in
    let smt2file = Printf.sprintf "%s/%s%s" config.path file config.suffix in
    let pretty_file =
      smt2file
      |> Base.String.chop_prefix_if_exists ~prefix:"benchmarks/QF_LIA/LoAT/"
      |> Base.String.chop_prefix_if_exists ~prefix:"benchmarks/QF_LIA/"
      |> Base.String.chop_prefix_if_exists ~prefix:"benchmarks/QF_LIA/LoAT/"
    in
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
    printfn "export TIMEOUT=%d" config.timeout;
    (* printfn "SECONDS=0"; *)
    printfn "printf '\n%s (%d/%d)...\n'" smt2file curi total;
    printfn "APPROX='-bound 10 -over-early'";
    printfn "FLAT='-flat 0 -amin 0 -amax 100000'";
    printfn
      "if timeout $TIMEOUT /usr/bin/time -f 'THETIME %%U' dune exec Chro \
       --profile=release -- $APPROX $FLAT %s --q %s > .log 2> .errlog"
      smt2file
      extra_flags;
    printfn "then";
    printfn "  TIME=$(grep THETIME .errlog | awk '{print $2}')";
    printfn "  echo time is \"$TIME\"";
    printfn "  if grep -q '^unsat' .log; then";
    printfn "    echo \" \\%sUNSAT{$TIME}{%s}\"" "CHRO" pretty_file;
    printfn "    grep '^unsat' -A 1 .log || true";
    printfn "  fi";
    printfn "  if grep -q '^sat' .log; then";
    printfn "    echo \"\\%sSAT{$TIME}{%s}\"" "CHRO" pretty_file;
    printfn "    grep '^sat' -A 1 .log || true";
    printfn "  fi";
    printfn "  if grep -q '^unknown' .log; then";
    printfn "    echo \"\\%sUNK{$TIME}{%s}\"" "CHRO" pretty_file;
    printfn "  fi";
    printfn "else";
    printfn "    echo \"\\%sTIMEOUT{$TIMEOUT}{%s}\"" "CHRO" pretty_file;
    printfn "fi";
    match opp with
    | Without -> ()
    | Swine ->
      printfn "echo '\nExecuting Swine on %s'" smt2file;
      printfn "echo '' > .log";
      printfn
        "if timeout $TIMEOUT /usr/bin/time -f 'THETIME %%U' dune exec bin/swine \
         --profile=release -- %s > .log 2> .errlog"
        smt2file;
      printfn "then";
      printfn "  #pr -T -o 11 .log";
      printfn "  TIME=$(grep THETIME .errlog | awk '{print $2}')";
      printfn "  echo time is \"$TIME\"";
      printfn "  if grep -q '^unsat' .log; then";
      printfn "    echo \"\\%sUNSAT{$TIME}{%s}\"" "SWINE" pretty_file;
      printfn "  elif grep -q '^sat' .log; then";
      printfn "    echo \"\\%sSAT{$TIME}{%s}\"" "SWINE" pretty_file;
      printfn "  elif grep -q '^unknown' .log; then";
      printfn "    echo \"\\%sUNK{$TIME}{%s}\"" "SWINE" pretty_file;
      printfn "  else";
      printfn "    echo 'BAD'";
      printfn "  fi";
      printfn "else";
      printfn "    echo \"\\%sTIMEOUT{$TIMEOUT}{%s}\"" "SWINE" pretty_file;
      printfn "fi"
  in
  Out_channel.with_open_text script (fun ch ->
    let ppf = Format.formatter_of_out_channel ch in
    Format.fprintf ppf "#!/usr/bin/env bash\n\n%!";
    Format.fprintf ppf "export OCAMLRUNPARAM='b=0'\n%!";
    Format.fprintf ppf "dune b bin/chro.exe --profile=release || exit 1\n";
    let total = List.length files in
    List.iteri (on_file ppf ~total) files;
    Format.pp_print_flush ppf ();
    flush ch)
;;

let () =
  match config.mode with
  | Default -> prepare_default ()
  | Script script -> prepare_script ~opp:config.opponent ~script ()
;;
