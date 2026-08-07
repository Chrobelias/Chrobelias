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

let cache : (string, string, _) Base.Map.t ref = ref (Base.Map.empty (module Base.String))
let extend vk vv = cache := Base.Map.add_exn !cache ~key:vk ~data:vv

(* MS: Config.base () must be replaced with a base taken from the phormula *)
let formulas_of_cache () =
  Base.Map.to_sequence !cache
  |> Base.Sequence.map ~f:(fun (x, fv) ->
    Symantics.(mul [ constz Z.(of_int !Config.base - one); var x ] < var fv))
  |> Base.Sequence.to_list
;;

let gensym base =
  let n = ref 0 in
  let prefix = Format.asprintf "exp_%a_" Z.pp_print base in
  fun name ->
    match Base.Map.find_exn !cache name with
    | exception Base.Not_found_s _ ->
      incr n;
      let ans = Printf.sprintf "%s%s" prefix name in
      extend name ans;
      ans
    | x -> x
;;

exception Bitwise_op
exception String_op
exception Difficult_Exp_op

let apply_symnatics (module S : Smtml_symantics) =
  (* Polarity-aware: an atom the translation cannot express is relaxed to
     [true], but only in positive positions -- under an odd number of
     negations the sound relaxation is [false], so the enclosing [not]s come
     out [true]. Relaxing to [true] unconditionally used to turn
     [(or (and U (not U)) (not U))], [U] unsupported, into [false] and the
     whole over-approximation into a bogus [`Unsat]. *)
  let rec helper pos = function
    | Ast.True -> S.true_
    | Lnot (Eia (InRe _))
    | Lnot (Eia (InReRaw _))
    | Lnot (Eia (SuffixOf _))
    | Lnot (Eia (PrefixOf _))
    | Lnot (Eia (Contains _)) -> if pos then S.true_ else S.false_
    | Lnot x -> S.not (helper (Stdlib.not pos) x)
    | Land xs -> S.land_ (List.map (helper pos) xs)
    | Lor xs -> S.lor_ (List.map (helper pos) xs)
    | Eia e -> helper_eia pos e
    | Pred s -> assert false
    | Exists (vs, ph) ->
      let vs =
        List.filter_map
          (function
            | Ast.Any_atom (Ast.Var (s, _)) -> Some s)
          vs
      in
      S.exists vs (helper pos ph)
    | Unsupp _ -> if pos then S.true_ else S.false_
  and helperT = function
    | Ast.Eia.Const n -> S.constz n
    | Atom (Ast.Var (s, _)) -> S.var s
    | Add terms -> S.add (List.map helperT terms)
    | Mul terms -> S.mul (List.map helperT terms)
    | Pow (Const base, Atom (Ast.Var (x, _k))) -> Symantics.var (gensym base x)
    | Pow (base, Const p) -> S.pow (helperT base) (helperT (Const p))
    | Pow (_, _) -> raise Difficult_Exp_op
    | Mod (t, z) -> S.mod_ (helperT t) z
    | Bwand _ | Bwor _ | Bwxor _ -> raise Bitwise_op
    | Concat _ | At _ | Substr _ | Ast.Eia.Str_const _ | Len _ | Sofi _ | Iofs _ | Len2 _
      -> raise String_op
  and helper_eia pos ph =
    try
      let open Ast in
      let open Ast.Eia in
      match ph with
      | Leq (l, r) -> S.(helperT l <= helperT r)
      (*| Eq (Atom (Var (name, I)), r, I) -> S.(helperT (Atom (Var (name, I))) = helperT r)
      | Eq (Atom (Var (_, S)), _, S) -> raise String_op*)
      | Eq (l, r, I) -> S.(helperT l = helperT r)
      | Neq (l, r, I) -> S.(helperT l <> helperT r)
      | Eq (l, r, S) -> raise String_op
      | Neq (l, r, S) -> raise String_op
      | InRe _ | InReRaw _ | SuffixOf _ | PrefixOf _ | Contains _ | RLen _ ->
        raise String_op
    with
    | String_op | Bitwise_op | Difficult_Exp_op -> if pos then S.true_ else S.false_
  in
  fun x -> S.prj (helper true x)
;;

let check ast =
  let tracing_on =
    match Sys.getenv "CHRO_TRACE_OPT" with
    | exception Not_found -> false
    | "1" -> true
    | _ -> false
  in
  cache := Base.Map.empty (module Base.String);
  let _repr = apply_symnatics (module Symantics) ast in
  let whole = _repr :: formulas_of_cache () in
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

(* Like [check_length], but on [`Unsat] also reports which conjuncts of [ast] are
   responsible, as a formula over [ast]'s own atoms.

   Smtml's solver interface exposes no [get_unsat_core], so the core is found by
   deletion: drop an assumption and keep it only if what remains is still
   unsatisfiable. Every probe is a small linear-integer query over the length
   abstraction, so this stays cheap -- unlike minimising against the full string
   theory. *)
let check_length_core_exn ast =
  let parts, facts, _whole = length_abstraction ast in
  cache := Base.Map.empty (module Base.String);
  let to_smtml = apply_symnatics (module Symantics) in
  (* Translate everything before reading the cache: [apply_symnatics] populates it
     while lowering [Pow], and the bounds it records belong with the facts. *)
  let assumptions = List.map (fun (ph, abstraction) -> ph, to_smtml abstraction) parts in
  let fact_exprs = List.map to_smtml facts in
  let fact_exprs = fact_exprs @ formulas_of_cache () in
  let module Z3 = Smtml.Z3_mappings.Solver in
  let solver =
    Z3.make ~params:Smtml.Params.(default () $ (Timeout, 200000) $ (Random_seed, 42)) ()
  in
  Z3.reset solver;
  Z3.add solver fact_exprs;
  let unsat_with kept =
    match Z3.check solver ~assumptions:(List.map snd kept) with
    | `Unsat -> true
    | `Sat | `Unknown -> false
  in
  if not (unsat_with assumptions)
  then `Unknown
  else (
    let rec go kept = function
      | [] -> List.rev kept
      | p :: rest ->
        if unsat_with (List.rev_append kept rest)
        then go kept rest
        else go (p :: kept) rest
    in
    match go [] assumptions with
    (* The facts alone are contradictory, so no conjunct is to blame. *)
    | [] -> `Unknown
    | survivors ->
      trace_log
        "length core: %d -> %d conjunct(s)"
        (List.length assumptions)
        (List.length survivors);
      `Unsat (Ast.land_ (List.map fst survivors)))
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
