(* Lowering of length abstractions (linear integer arithmetic over lengths and
   exponents) into a solver's term language, abstracted over the term
   representation: [Overapprox.Symantics] instantiates it for Smtml,
   [Z3core]'s native build for the Z3 bindings. *)

module type Core_symantics = sig
  type repr

  val true_ : repr
  val false_ : repr
  val not : repr -> repr
  val land_ : repr list -> repr
  val lor_ : repr list -> repr
  val exists : string list -> repr -> repr
  val constz : Z.t -> repr
  val var : string -> repr
  val add : repr list -> repr
  val mul : repr list -> repr
  val pow : repr -> repr -> repr
  val mod_ : repr -> Z.t -> repr
  val ( <= ) : repr -> repr -> repr
  val ( < ) : repr -> repr -> repr
  val ( = ) : repr -> repr -> repr
  val ( <> ) : repr -> repr -> repr
  val prj : repr -> repr
end

let cache : (string, string, _) Base.Map.t ref = ref (Base.Map.empty (module Base.String))
let extend vk vv = cache := Base.Map.add_exn !cache ~key:vk ~data:vv
let reset_cache () = cache := Base.Map.empty (module Base.String)

(* MS: Config.base () must be replaced with a base taken from the phormula *)
let formulas_of_cache (type a) (module S : Core_symantics with type repr = a) : a list =
  Base.Map.to_sequence !cache
  |> Base.Sequence.map ~f:(fun (x, fv) ->
    S.(mul [ constz Z.(of_int !Config.base - one); var x ] < var fv))
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

let apply_symnatics (type a) (module S : Core_symantics with type repr = a) =
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
    | Pow (Const base, Atom (Ast.Var (x, _k))) -> S.var (gensym base x)
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
