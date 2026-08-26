module type SYM0 = sig
  type term
  type str
  type ph

  include FT_SIG.z_term with type term := term
  include FT_SIG.str_term with type term := term and type str := str
  include FT_SIG.s_ph with type ph := ph and type term := term and type str := str

  val sofi : term -> str
  val iofs : str -> term

  (*
     val str_concat : str -> str -> str
  val str_equal : str -> str -> ph
  val pow2var : string -> term
  *)
  val str_len2 : str -> term
  val str_at : str -> term -> str
  val str_substr : str -> term -> term -> str
  val str_prefixof : str -> str -> ph
  val str_contains : str -> str -> ph
  val str_suffixof : str -> str -> ph

  (* String formulas *)
  val str_concat : str list -> str

  (* All formulas  *)
  val pow2var : string -> term
  val exists : Ast.any_atom list -> ph -> ph
  val unsupp : string -> Smtml.Expr.t -> ph

  val unsupp_check
    :  (Model.t
        -> Ast.t
        -> (string, Nfa.String.t) Base.Map.Poly.t
        -> (Ast.t -> [ `Sat of unit -> Model.t | `Unknown ])
        -> [ `Sat of unit -> Model.t | `Unknown ])
    -> ph

  val pow_minus_one : term -> term
end

module type SYM = sig
  include SYM0

  type repr

  val prj : ph -> repr [@@warning "-32"]
  val pp_str : Format.formatter -> term -> unit
  val const : int -> term
  val in_rei : term -> char list Regex.t -> ph
  val in_re_raw : str -> Nfa.String.t -> ph
  val in_re_rawi : term -> Nfa.String.t -> ph
  val rlen : term -> term -> ph
end

val apply_symantics_unsugared : (module SYM with type ph = 'a) -> Ast.t -> 'a

module Id_symantics :
  SYM
  with type ph = Ast.t
   and type repr = Ast.t
   and type term = Z.t Ast.Eia.term
   and type str = string Ast.Eia.term

type relop =
  | Leq
  | Eq

exception Str_Underapprox_fired of Env.t

val has_unsupported_nonlinearity : Ast.t -> (unit, Z.t Ast.Eia.term list) Result.t
val subst : Env.t -> Ast.t -> Ast.t
val subst_term : Env.t -> 'a Ast.Eia.term -> 'a Ast.Eia.term
val split_concats : Ast.t -> Ast.t
val extract_and_filter_unsupported_atomic_formulas : Ast.t -> Ast.t * Ast.t list
val unfold_neq : Ast.t -> Ast.t

val arithmetize
  :  string list
  -> Ast.t
  -> Env.t
  -> (Ast.t * Env.t * (string, Nfa.String.u) Base.Map.Poly.t) Seq.t

val normalize : Ast.Eia.t -> Ast.Eia.t

val run_string_simplify
  :  Ast.t
  -> [ `Sat of Env.t
     | `Unsat of Ast.t
     | `Unknown of Ast.t * Env.t * (Ast.t * Env.t) list Seq.t
     ]

val run_length_simplify : Env.t -> Ast.t -> [> `Unknown of Ast.t | `Unsat of Ast.t ]

(* Default totalization of powers to the standard SMT-LIB Ints (April 2026)
   semantics: [m ** n = 0] for [n < 0, |m| > 1], base 0 collapsing to 1/0 at
   [n = 0]/elsewhere, base -1 deciding by parity, negative constant bases
   via |base| plus a parity sign split. Runs once on the whole formula
   before the EIA pipeline; exponents provably nonnegative from the
   pow-free atoms are left on the engine's exact fragment. *)
val std_exp_split : Ast.t -> Ast.t

(* True iff every power in the formula has a constant base >= 2 -- the
   fragment the automata engine can express. Guards the two-phase driver's
   attempt at the un-split formula. *)
val engine_pows_only : Ast.t -> bool

val run_basic_simplify
  :  ?env:Env.t
  -> Ast.t
  -> [ `Sat of Env.t | `Unsat of Ast.t | `Unknown of Ast.t * Env.t ]

val check_nia : Env.t -> Ast.t -> [> `Sat of Env.t | `Unknown | `Unsat ]
