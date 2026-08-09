let trace_log fmt = Debug.trace "over" fmt

module type Smtml_symantics = sig
  include FT_SIG.z_term with type term := Smtml.Expr.t
  include FT_SIG.str_term with type term := Smtml.Expr.t and type str := Smtml.Expr.t

  include
    FT_SIG.s_ph
    with type ph := Smtml.Expr.t
     and type term = Smtml.Expr.t
     and type str = Smtml.Expr.t

  include FT_SIG.s_extra with type ph := Smtml.Expr.t and type term = Smtml.Expr.t

  val exists : string list -> Smtml.Expr.t -> Smtml.Expr.t

  type repr = Smtml.Expr.t

  val prj : Smtml.Expr.t -> Smtml.Expr.t
end

module Symantics : Smtml_symantics = struct
  include FT_SIG.To_smtml_symantics

  type repr = Smtml.Expr.t

  let prj = Fun.id

  let exists vs ph =
    Smtml.Expr.exists
      (List.map (fun s -> Smtml.Expr.symbol (Smtml.Symbol.make Ty_int s)) vs)
      ph
  ;;
end

let apply_symnatics = Lowering.apply_symnatics

let check ast =
  let tracing_on =
    match Sys.getenv "CHRO_TRACE_OPT" with
    | exception Not_found -> false
    | "1" -> true
    | _ -> false
  in
  Lowering.reset_cache ();
  let _repr = apply_symnatics (module Symantics) ast in
  let whole = _repr :: Lowering.formulas_of_cache (module Symantics) in
  Format.pp_print_flush Format.std_formatter ();
  trace_log "@[whole: @[<v>%a@]@]\n%!" (Format.pp_print_list Smtml.Expr.pp) whole;
  let module Z3 = Smtml.Z3_mappings.Solver in
  (* let module Z3 = Smtml.Cvc5_mappings.Solver in *)
  let solver =
    Z3.make ~params:Smtml.Params.(default () $ (Timeout, 200000) $ (Random_seed, 42)) ()
  in
  Z3.reset solver;
  match Z3.check solver ~assumptions:whole with
  | `Unsat ->
    if tracing_on then Format.printf "Early Unsat in %s\n%!" __FILE__;
    `Unsat
  | `Unknown ->
    trace_log "Can't decide in %s%!" __FILE__;
    if tracing_on then Format.printf "`Unknown  in %s\n%!" __FILE__;
    `Unknown ast
  | `Sat when tracing_on ->
    Format.printf "Early SAT in %s ~~> Unknown\n%!" __FILE__;
    let () =
      match Smtml.Z3_mappings.Solver.model solver with
      | Some m ->
        let m = Smtml.Z3_mappings.values_of_model m in
        Format.printf "%a\n%!" (Smtml.Model.pp ~no_values:false) m;
        ()
      | None -> ()
    in
    `Unknown ast
  | `Sat -> `Unknown ast
;;

let check ast =
  (* Skip expressions with "forall" quantifier: Z3 stucks when evaluating them. *)
  if
    Ast.forsome
      (function
        | Ast.Exists (atoms, ast) ->
          Ast.forsome
            (function
              | Ast.Lnot ast ->
                Ast.forsome
                  (function
                    | Ast.Exists _ -> true
                    | _ -> false)
                  ast
              | _ -> false)
            ast
        | _ -> false)
      ast
  then `Unknown ast
  else (
    try check ast with
    | _ -> `Unknown ast)
;;

(*Below is something useful about lengths. Will be overapproximation based on string abstractions *)
(* The length over-approximation of [ast]: one abstraction per conjunct, the side
   facts, and their conjunction. *)
let length_abstraction ast =
  let strlens s = String.concat "" [ "strlen"; s ] in
  let gensym =
    let n = ref 0 in
    fun ?(prefix = "eee") () ->
      incr n;
      Printf.sprintf "%s%d" prefix !n
  in
  let over_concat_len ast =
    let module Set = Base.Set.Poly in
    let eqs = ref Set.empty in
    let open Ast.Eia in
    let module OverStrLen = struct
      include SimplII.Id_symantics

      let in_re s re =
        let module NfaStr = Nfa.String in
        let open Ast.Eia in
        match s with
        | Atom (Var (s, S)) ->
          let nfa = NfaStr.of_regex re in
          if Bool.not (NfaStr.run nfa)
          then false_
          else (
            let csds =
              let is_eos vec =
                match Array.length vec with
                | 1 -> Char.equal (Array.get vec 0) Nfa.Str10.u_eos
                | _ -> failwith "unexpected nfa in arithmetize_in_re"
              in
              NfaStr.filter_map nfa (fun (label, q') ->
                if is_eos label then Option.none else Option.some (label, q'))
              |> NfaStr.to_nat
              |> NfaStr.chrobak
            in
            csds
            |> Seq.map (fun (c, d) ->
              let c, d = Z.of_int c, Z.of_int d in
              let n = gensym ~prefix:"@@re_len" () in
              land_
                [ Ast.eia (leq (const Z.zero) (var n))
                ; Ast.eia
                    (eq (var (strlens s)) (add [ const c; mul [ const d; var n ] ]) Ast.I)
                ])
            |> List.of_seq
            |> Ast.lor_)
        | _ -> Ast.true_
      ;;

      let rec str_len term =
        match term with
        | Str_const s -> const (String.length s)
        | Concat xs -> add (List.map str_len xs)
        | Atom (Var (s, S)) ->
          let v = var (strlens s) in
          eqs := Set.add !eqs (leq (const 0) v);
          v
        (* A fresh, unconstrained length per unhandled term. Reusing one shared
           variable would equate the lengths of unrelated terms, and this
           over-approximation's [Unsat] is trusted by the caller. *)
        | _ ->
          let v = var (gensym ~prefix:"@@strlen_other" ()) in
          eqs := Set.add !eqs (leq (const 0) v);
          v
      ;;

      let eq_str lhs rhs = eqz (str_len lhs) (str_len rhs)
    end
    in
    (* One abstraction per conjunct, rather than one for the whole conjunction.
       [apply_symantics_unsugared] maps the formula structurally, so keeping the
       conjuncts apart makes the correspondence between a conjunct and its
       abstraction positional -- which is what lets a core over the abstractions be
       reported back in terms of the caller's own atoms, with no provenance
       bookkeeping. Conjoining the parts reproduces the old whole-formula result. *)
    let conjuncts =
      match ast with
      | Ast.Land xs -> xs
      | ph -> [ ph ]
    in
    (* The abstractions of string atoms are one-directional: [s in_re L] implies
       its length progression, [s1 = s2] implies equal lengths -- but their
       negations imply nothing about lengths. Negating the abstraction anyway
       (which is what mapping the formula structurally does to a [Lnot]) turns
       the over-approximation into a wrong-way constraint and yields bogus
       [`Unsat]s. So before abstracting, every such atom in negative polarity
       is replaced by [false]: its negation then relaxes to [true]. Raw
       constructors keep the structure (and [parts]' positions) intact. *)
    let rec relax pos ph =
      match ph with
      | Ast.Lnot x -> Ast.Lnot (relax (Stdlib.not pos) x)
      | Ast.Land xs -> Ast.Land (List.map (relax pos) xs)
      | Ast.Lor xs -> Ast.Lor (List.map (relax pos) xs)
      | Ast.Exists (v, x) -> Ast.Exists (v, relax pos x)
      | Ast.Eia
          ( Ast.Eia.InRe _ | Ast.Eia.InReRaw _
          | Ast.Eia.Eq (_, _, Ast.S)
          | Ast.Eia.Neq (_, _, Ast.S)
          | Ast.Eia.PrefixOf _ | Ast.Eia.SuffixOf _ | Ast.Eia.Contains _ | Ast.Eia.RLen _
            )
        when Stdlib.not pos -> Ast.Lnot Ast.True
      | ph -> ph
    in
    let parts =
      List.map
        (fun ph ->
           ph, SimplII.apply_symantics_unsugared (module OverStrLen) (relax true ph))
        conjuncts
    in
    (* Side facts: every length is non-negative, plus Chrobak's [@@re_len] bounds.
       They are not attributable to any one conjunct, so they always hold. *)
    parts, !eqs |> Set.to_list
  in
  let parts, facts = over_concat_len ast in
  let whole = Ast.land_ (List.map snd parts @ facts) in
  trace_log "Length abstraction result:  %a %!" Ast.pp_smtlib2 whole;
  parts, facts, whole
;;

let check_length ast =
  let _parts, _facts, whole = length_abstraction ast in
  check whole
;;

(* Like [check_length], but on [`Unsat] also reports which conjuncts of [ast]
   are responsible, as a formula over [ast]'s own atoms. The core extraction
   itself lives in [Z3core]: it needs Z3's native unsat cores, and the z3
   findlib package is optional (see lib/dune). *)
let check_length_core_exn ast =
  let parts, facts, _whole = length_abstraction ast in
  match Z3core.check_length_core ~parts ~facts with
  | `Unknown -> `Unknown
  | `Unsat survivors ->
    trace_log
      "length core: %d -> %d conjunct(s)"
      (List.length parts)
      (List.length survivors);
    `Unsat (Ast.land_ survivors)
;;

(* Translating to Smtml can raise from deep inside the evaluator (an oversized
   constant, an operator it cannot fold), exactly as it can for [check] above,
   which is why that one is wrapped too. An over-approximation is free to give up. *)
let check_length_core ast =
  try check_length_core_exn ast with
  | exn ->
    trace_log "check_length_core gave up: %s" (Printexc.to_string exn);
    `Unknown
;;
