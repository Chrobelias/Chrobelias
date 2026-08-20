let nfa_cnt = ref 0
let enforce_debug = ref false
let flag () = Sys.getenv_opt "CHRO_DEBUG" |> Option.is_some || !enforce_debug

let tracers =
  lazy
    (Sys.getenv_opt "CHRO_DEBUG"
     |> Option.map (String.split_on_char ':')
     |> Option.value ~default:[])
;;

let is_traced s =
  let l = Lazy.force tracers in
  List.mem "ANY" l || List.mem s l
;;

(* Traces go to stderr: stdout is the machine-readable answer stream, and the
   portfolio children capture the two separately -- a trace on stdout would be
   replayed into the winner's answer and confuse every downstream parser. *)
let trace tracer_option (ppf : _ format) =
  if is_traced tracer_option
  then Format.kasprintf (fun s -> Format.eprintf "[+%s]\n  %s\n%!" tracer_option s) ppf
  else Format.ifprintf Format.err_formatter ppf
;;

let dump_nfa ?msg ?pp_vars ?vars format_nfa nfa =
  if is_traced "nfa"
  then (
    let ( !< ) a = Format.sprintf a in
    let name =
      nfa_cnt := !nfa_cnt + 1;
      Format.sprintf "%d" !nfa_cnt
    in
    let subdir = string_of_int (Unix.getpid ()) in
    let supdir = "debugs" in
    Sys.command (!<{|mkdir -p "%s"/"%s"|} supdir subdir) |> ignore;
    let dir = !<"%s/%s" supdir subdir in
    let dot_file = !<"%s/%s.dot" dir name in
    let svg_file = !<"%s/%s.svg" dir name in
    let oc = open_out dot_file in
    let command = Format.sprintf {|dot -Tsvg "%s" > "%s"|} dot_file svg_file in
    Format.asprintf "%a" format_nfa nfa |> Printf.fprintf oc "%s";
    close_out oc;
    let __ () = Sys.command command |> ignore in
    (match msg with
     | Some msg -> Format.kasprintf (Format.eprintf "%s\n%!") msg svg_file
     | None -> ());
    match pp_vars, vars with
    | Some pp, Some vars -> Format.eprintf "@[%a@]\n%!" pp vars
    | _ -> ())
;;
