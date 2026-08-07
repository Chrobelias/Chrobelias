module Expr = Smtml.Expr
module Symbol = Smtml.Symbol
module Ty = Smtml.Ty
module Binder = Smtml.Binder

exception UnsupportedException of string * Smtml.Expr.t

(* let failf fmt = failwith (Format.asprintf fmt) *)

type r =
  | Str of string Ast.Eia.term
  | Int of Z.t Ast.Eia.term
[@@deriving variants]

let return a b = a, b
let ( let* ) a f = f a
let ( @ ) a b = Ast.land_ [ a; b ]
let empty = Ast.true_
let internalc = ref 0

let internal_name () =
  let r = String.concat "" [ "%"; !internalc |> Int.to_string ] in
  internalc := !internalc + 1;
  r
;;

let internal kind = Ast.var (internal_name ()) kind
let extras = ref []
let extend ast = extras := ast :: !extras

let rec to_string orig_expr : string Ast.Eia.term * Ast.t =
  let failf fmt = raise (UnsupportedException (fmt, orig_expr)) in
  let expr = Expr.view orig_expr in
  match expr with
  | Expr.Symbol symbol ->
    let var = Symbol.to_string symbol in
    return (Ast.Eia.Atom (Ast.str_var var)) empty
  | Expr.Val v ->
    begin match v with
    | Str s -> return Ast.Eia.(Str_const s) empty
    | _ -> failf (Format.asprintf "unable to handle %a as string" Expr.pp orig_expr)
    end
  | Expr.Naryop (_, Ty.Naryop.Concat, ls) ->
    (* VERIFY ME ?? *)
    let ls = List.map to_string ls in
    let ls, phs = List.split ls in
    return (Ast.Eia.concat ls) (Ast.land_ phs)
  | Expr.App ({ name = Symbol.Simple "str.from_int"; _ }, [ expr ])
  | Expr.App ({ name = Symbol.Simple "str.from.int"; _ }, [ expr ])
  | Expr.Cvtop (_, Ty.Cvtop.String_from_int, expr) ->
    let* str, phs = to_eia_term expr in
    begin match str with
    | Ast.Eia.Const n -> return (Ast.Eia.Str_const (Z.to_string n)) phs
    | _ -> return (Ast.Eia.Sofi str) phs
    end
  | Expr.Triop (_, Ty.Triop.String_extract, str, from, to') ->
    let* str, phs = to_string str in
    let* from, phs' = to_eia_term from in
    let* to', phs'' = to_eia_term to' in
    return (Ast.Eia.substr str from to') (phs @ phs' @ phs'')
  | Expr.Binop (_, Ty.Binop.At, str, sym) ->
    let* str, phs = to_string str in
    let* sym, phs' = to_eia_term sym in
    return (Ast.Eia.at str sym) (phs @ phs')
  | Expr.Triop (_, Ty.Triop.Ite, c, t, e) ->
    let v = Ast.Eia.atom (internal Ast.S) in
    (* Fixme *)
    let* c = to_ast Base.Map.Poly.empty c in
    let* t, phs' = to_string t in
    let* e, phs'' = to_string e in
    let phs = phs' @ phs'' in
    let phs_1 = Ast.land_ [ Ast.eia (Ast.Eia.eq v t Ast.S); c ] @ phs in
    let phs_2 = Ast.land_ [ Ast.eia (Ast.Eia.eq v e Ast.S); Ast.lnot c ] @ phs in
    return v (Ast.lor_ [ phs_1; phs_2 ])
  | _ -> failf (Format.asprintf "unable to handle %a as string" Expr.pp orig_expr)

and to_regex orig_expr =
  let failf fmt = raise (UnsupportedException (fmt, orig_expr)) in
  let expr = Expr.view orig_expr in
  match expr with
  | Expr.Symbol s when Symbol.to_string s = "re.none" -> Regex.empty
  | Expr.Symbol s when Symbol.to_string s = "re.nostr" -> Regex.empty
  | Expr.Symbol s when Symbol.to_string s = "re.allchar" -> Regex.allchar
  | Expr.App ({ name = Symbol.Simple "str.to.re"; _ }, [ expr ])
  | Expr.Cvtop (_, Ty.Cvtop.String_to_re, expr) ->
    let str =
      match to_string expr with
      | Ast.Eia.Str_const s, ast when ast = empty -> s
      | _ ->
        failf (Format.asprintf "unable to create regex dynamically in %a" Expr.pp expr)
    in
    str
    |> String.to_seq
    |> Seq.map (fun c -> Regex.symbol [ c ])
    |> Seq.fold_left
         (fun acc a ->
            (* String constraints use LSB representation, we intentionally reverse the concat. *)
            Regex.concat a acc)
         Regex.epsilon
  | Expr.Binop (_ty, Ty.Binop.Regexp_range, lhs, rhs) ->
    let ( -- ) i j =
      let rec aux n acc = if n < i then acc else aux (n - 1) (n :: acc) in
      aux j []
    in
    let lhs =
      match to_string lhs with
      | Ast.Eia.(Str_const s), ast -> s
      | _ ->
        failf
          (Format.asprintf "unable to create regex dynamically in %a" Expr.pp orig_expr)
    in
    let rhs =
      match to_string rhs with
      | Ast.Eia.(Str_const s), ast when ast = empty -> s
      | _ ->
        failf
          (Format.asprintf "unable to create regex dynamically in %a" Expr.pp orig_expr)
    in
    if String.length lhs <> 1 || String.length rhs <> 1
    then Regex.empty
    else (
      let lhs = String.get lhs 0 in
      let rhs = String.get rhs 0 in
      Char.code lhs -- Char.code rhs
      |> List.fold_left
           (fun acc c -> Regex.mor acc (Regex.symbol [ Char.chr c ]))
           Regex.empty)
  | Expr.Naryop (_ty, Ty.Naryop.Concat, exprs) ->
    (* String constraints use LSB representation, we intentionally reverse the concat. *)
    List.map to_regex exprs |> List.rev |> List.fold_left Regex.concat Regex.epsilon
  | Expr.Naryop (_ty, Ty.Naryop.Regexp_union, exprs) ->
    List.map to_regex exprs |> List.fold_left Regex.mor Regex.empty
  | Expr.Binop (_ty, Ty.Binop.Regexp_inter, lhs, rhs) ->
    let lhs = to_regex lhs in
    let rhs = to_regex rhs in
    Regex.mand lhs rhs
  | Expr.Unop (_ty, Ty.Unop.Regexp_loop (l, r), stmt) ->
    let stmt = to_regex stmt in
    let lhs = List.init l (fun _ -> stmt) |> List.fold_left Regex.concat Regex.epsilon in
    let rhs = List.init r (fun _ -> Regex.opt stmt) |> List.fold_left Regex.concat lhs in
    rhs
  | Expr.Unop (_ty, Ty.Unop.Regexp_opt, expr) -> to_regex expr |> Regex.opt
  | Expr.Unop (_ty, Ty.Unop.Regexp_plus, expr) -> to_regex expr |> Regex.plus
  | Expr.Unop (_ty, Ty.Unop.Regexp_star, expr) -> to_regex expr |> Regex.kleene
  | Expr.Unop (_ty, Ty.Unop.Regexp_comp, expr) ->
    failwith "complements are not implemented yet since they would explode NFAs"
  | _ -> failf (Format.asprintf "unable to handle %a as regex" Expr.pp orig_expr)

and to_eia_term orig_expr : Z.t Ast.Eia.term * Ast.t =
  let failf fmt = raise (UnsupportedException (fmt, orig_expr)) in
  let neg eia_term = Ast.Eia.mul [ Ast.Eia.const Z.minus_one; eia_term ] in
  let expr = Expr.view orig_expr in
  match expr with
  | Expr.Val v ->
    begin match v with
    | Int d -> return (Ast.Eia.const (Z.of_int d)) empty
    | _ -> failf (Format.asprintf "unable to handle %a as integer term" Expr.pp orig_expr)
    end
  | Expr.App ({ name = Symbol.Simple "str.to.int"; _ }, [ expr ])
  | Expr.Cvtop (_, Ty.Cvtop.String_to_int, expr) ->
    let* str, phs = to_string expr in
    return (Ast.Eia.iofs str) phs
  | Expr.Symbol symbol ->
    let var = Symbol.to_string symbol in
    return (Ast.Eia.atom (Ast.int_var var)) empty
  (* Semenov arithmetic, i.e. 2**x operators. *)
  | Expr.App ({ name = Symbol.Simple "pow2"; _ }, [ expr ]) ->
    let* expr, phs = to_eia_term expr in
    return (Ast.Eia.pow (Ast.Eia.const (Z.of_int 2)) expr) phs
  | Expr.App ({ name = Symbol.Simple "pow10"; _ }, [ expr ]) ->
    let* expr, phs = to_eia_term expr in
    return (Ast.Eia.pow Ast.Eia.(const (Z.of_int 10)) expr) phs
  | Expr.App ({ name = Symbol.Simple "exp"; _ }, [ base; exp ]) ->
    let* base, phs = to_eia_term base in
    let* exp, phs' = to_eia_term exp in
    return (Ast.Eia.pow base exp) (phs @ phs')
  (* Bit-wise operations *)
  | Expr.App ({ name = Symbol.Simple "bwand"; _ }, hd :: tl) ->
    List.fold_left
      (fun acc el ->
         let* acc, phs = acc in
         let* el, phs' = to_eia_term el in
         return (Ast.Eia.bwand acc el) (phs @ phs'))
      (to_eia_term hd)
      tl
  | Expr.App ({ name = Symbol.Simple "bwor"; _ }, hd :: tl) ->
    List.fold_left
      (fun acc el ->
         let* acc, phs = acc in
         let* el, phs' = to_eia_term el in
         return (Ast.Eia.bwor acc el) (phs @ phs'))
      (to_eia_term hd)
      tl
  | Expr.App ({ name = Symbol.Simple "bwxor"; _ }, hd :: tl) ->
    List.fold_left
      (fun acc el ->
         let* acc, phs = acc in
         let* el, phs' = to_eia_term el in
         return (Ast.Eia.bwxor acc el) (phs @ phs'))
      (to_eia_term hd)
      tl
  | Expr.Unop (_ty, Ty.Unop.Neg, expr) ->
    let* expr, phs = to_eia_term expr in
    return (neg expr) phs
  (* Arithmetic operations. *)
  | Expr.Binop (_ty, Ty.Binop.Add, lhs, rhs) ->
    let* lhs, phs = to_eia_term lhs in
    let* rhs, phs' = to_eia_term rhs in
    return (Ast.Eia.add [ lhs; rhs ]) (phs @ phs')
  | Expr.Binop (_ty, Ty.Binop.Sub, lhs, rhs) ->
    let* lhs, phs = to_eia_term lhs in
    let* rhs, phs' = to_eia_term rhs in
    return (Ast.Eia.add [ lhs; neg rhs ]) (phs @ phs')
  | Expr.Binop (_ty, Ty.Binop.Mul, lhs, rhs) ->
    let* lhs, phs = to_eia_term lhs in
    let* rhs, phs' = to_eia_term rhs in
    return (Ast.Eia.mul [ lhs; rhs ]) (phs @ phs')
  | Expr.App ({ name = Symbol.Simple "*"; _ }, hd :: tl) ->
    let* hd, phs = to_eia_term hd in
    let* exprs, phs =
      List.fold_left
        (fun acc expr ->
           let* acc, phs = acc in
           let* expr, phs' = to_eia_term expr in
           return (expr :: acc) (phs @ phs'))
        (return [ hd ] phs)
        tl
    in
    return (Ast.Eia.mul exprs) phs
  | Expr.Unop (_ty, Ty.Unop.Length, expr) ->
    let* str, phs = to_string expr in
    return (Ast.Eia.len str) phs
  (* mod *)
  | Expr.Binop (_, Ty.Binop.Rem, lhs, rhs) ->
    (match Expr.view rhs with
     | Expr.Val (Int d) ->
       let* lhs, phs = to_eia_term lhs in
       return (Ast.Eia.Mod (lhs, Z.of_int d)) phs
     | _ -> failf (Format.asprintf "expected term, in %a" Expr.pp orig_expr))
    (* Remainder is needed for example for this test
    dune b @benchmarks/tests/EXP-solver/flatten/head/test24 --profile=benchmark *)
  | Expr.Triop (_, Ty.Triop.Ite, c, t, e) ->
    let v = Ast.Eia.atom (internal Ast.I) in
    (* Fixme *)
    let* c = to_ast Base.Map.Poly.empty c in
    let* t, phs' = to_eia_term t in
    let* e, phs'' = to_eia_term e in
    let phs = phs' @ phs'' in
    let phs_1 = Ast.land_ [ Ast.eia (Ast.Eia.eq v t Ast.I); c ] @ phs in
    let phs_2 = Ast.land_ [ Ast.eia (Ast.Eia.eq v e Ast.I); Ast.lnot c ] @ phs in
    return v (Ast.lor_ [ phs_1; phs_2 ])
  | _ -> failf (Format.asprintf "expected term, in %a" Expr.pp orig_expr)

and to_ast tys orig_expr : Ast.t =
  let failf fmt = raise (UnsupportedException (fmt, orig_expr)) in
  (* Smtml Ty classification is kind of strange: it neither classifies the theory *)
  (* nor the return type. Let's introduce our own method for checking if the return *)
  (* type of the expr is string. *)
  let rec is_str tys expr =
    match Expr.view expr with
    | Expr.Triop (_, Ty.Triop.Ite, _, t, e) -> is_str tys t || is_str tys e
    | _ ->
      (Expr.ty expr = Ty.Ty_str
       &&
         match Expr.view expr with
         | Expr.Unop (_, Ty.Unop.Length, _)
         | Expr.App ({ name = Symbol.Simple "str.to.int"; _ }, [ _ ])
         | Expr.Cvtop (_, Ty.Cvtop.String_to_int, _) -> false
         | _ -> true)
      ||
        (match Expr.view expr with
        | Expr.Symbol symbol ->
          Option.bind
            (Base.Map.Poly.find tys (Symbol.to_string symbol))
            (function
              | `Str -> Option.some true
              | _ -> Option.none)
          |> Option.is_some
        | Expr.App ({ name = Symbol.Simple "str.from_int"; _ }, [ _ ])
        | Expr.App ({ name = Symbol.Simple "str.from.int"; _ }, [ _ ])
        | Expr.Cvtop (_, Ty.Cvtop.ToString, _) -> true
        | _ -> false)
  in
  let to_regex_helper term re =
    let term =
      match to_string term with
      | term, ast when ast = Ast.true_ -> term
      | _ ->
        failf (Format.asprintf "unable to create regex dynamically in %a" Expr.pp term)
    in
    let is_empty re =
      match Expr.view re with
      | Expr.App ({ name = Symbol.Simple "str.to.re"; _ }, [ expr ])
      | Expr.Cvtop (_, Ty.Cvtop.String_to_re, expr) ->
        (match to_string expr with
         | Ast.Eia.Str_const "", ast when ast = Ast.true_ -> true
         | _ -> false)
      | _ -> false
    in
    let expr = Expr.view re in
    match expr with
    | Expr.App ({ name = Symbol.Simple "str.to.re"; _ }, [ expr ])
    | Expr.Cvtop (_, Ty.Cvtop.String_to_re, expr) ->
      let str =
        match to_string expr with
        | Ast.Eia.Str_const s, ast when ast = Ast.true_ -> s
        | _ ->
          failf (Format.asprintf "unable to create regex dynamically in %a" Expr.pp expr)
      in
      Ast.Eia (Ast.Eia.eq term (Ast.Eia.Str_const str) Ast.S)
    | Expr.Unop (_ty, Ty.Unop.Regexp_plus, re') when is_empty re' ->
      Ast.Eia (Ast.Eia.eq term (Ast.Eia.Str_const "") Ast.S)
    | Expr.Unop (_ty, Ty.Unop.Regexp_star, re') when is_empty re' ->
      Ast.Eia (Ast.Eia.eq term (Ast.Eia.Str_const "") Ast.S)
    | _ ->
      let re = to_regex re in
      let re = Regex.concat re (Regex.kleene (Regex.symbol [ Nfa.Str10.u_eos ])) in
      Ast.Eia (Ast.Eia.inre term Ast.S re)
  in
  let expr = Expr.view orig_expr in
  try
    match expr with
    (* Constants. *)
    | Expr.Val v ->
      begin match v with
      | True -> Ast.True
      | False -> Ast.lnot Ast.true_
      | _ ->
        failf (Format.asprintf "unable to handle %a as boolean term" Expr.pp orig_expr)
      end
    (* Variables. *)
    | Expr.Symbol symbol -> Ast.pred (Symbol.to_string symbol)
    (* Yes, probably this stuff is kinda over-engineered. *)
    (* Logical operations. *)
    (* Not. *)
    | Expr.Unop (_ty, Ty.Unop.Not, expr) ->
      let expr = to_ast tys expr in
      Ast.lnot expr
    | Expr.Binop (_ty, Ty.Binop.And, lhs, rhs) ->
      let lhs = to_ast tys lhs in
      let rhs = to_ast tys rhs in
      Ast.land_ [ lhs; rhs ]
    | Expr.Naryop (_ty, Ty.Naryop.Logand, exprs) ->
      let a : Ast.t list =
        List.fold_left
          (fun acc (expr : Expr.t) ->
             let acc = acc in
             let (ir : Ast.t) = to_ast tys expr in
             ir :: acc)
          []
          exprs
      in
      Ast.land_ a
    (* Binary and arbitrary or *)
    | Expr.Binop (_ty, Ty.Binop.Or, lhs, rhs) -> begin
      Ast.lor_ [ to_ast tys lhs; to_ast tys rhs ]
      end
    | Expr.Naryop (_ty, Ty.Naryop.Logor, exprs) -> Ast.lor_ (List.map (to_ast tys) exprs)
    (* Implication *)
    | Expr.Binop (_ty, Ty.Binop.Implies, lhs, rhs) ->
      let lhs = to_ast tys lhs in
      let rhs = to_ast tys rhs in
      Ast.lor_ [ Ast.lnot lhs; rhs ]
    (* Integer comparisons. *)
    | Expr.Relop (_ty, Ty.Relop.Eq, lhs, rhs) when is_str tys lhs || is_str tys rhs ->
      let build t c = Ast.eia (Ast.Eia.eq t c S) in
      let lhs, (phs : Ast.t) = to_string lhs in
      let rhs, (phs' : Ast.t) = to_string rhs in
      extend phs;
      extend phs';
      build lhs rhs
    | Expr.Relop (_ty, rel, lhs, rhs) ->
      let build =
        match rel with
        | Ty.Relop.Eq -> fun t c -> Ast.eia (Ast.Eia.eq t c I)
        | Ty.Relop.Ne -> fun t c -> Ast.lnot (Ast.eia (Ast.Eia.eq t c I))
        | Ty.Relop.Le -> fun t c -> Ast.eia (Ast.Eia.leq t c)
        | Ty.Relop.Lt -> fun t c -> Ast.eia (Ast.Eia.lt t c)
        | _ -> failwith "Unsupported relational operator in EIA"
      in
      let* lhs, phs = to_eia_term lhs in
      let* rhs, phs' = to_eia_term rhs in
      extend phs;
      extend phs';
      build lhs rhs
    (* Strings. *)
    | Expr.App ({ name = Symbol.Simple "str.in.re"; _ }, [ str; re ])
    | Expr.Binop (_, Ty.Binop.String_in_re, str, re) -> to_regex_helper str re
    | Expr.Binop
        ( _
        , ((Ty.Binop.String_prefix | Ty.Binop.String_suffix | Ty.Binop.String_contains) as
           op)
        , str
        , str' ) ->
      let build t c =
        match op with
        | Ty.Binop.String_prefix -> Ast.eia (Ast.Eia.prefixof t c)
        | Ty.Binop.String_suffix -> Ast.eia (Ast.Eia.suffixof t c)
        | Ty.Binop.String_contains -> Ast.eia (Ast.Eia.contains t c)
        | _ -> assert false
      in
      let* str, phs = to_string str in
      let* str', phs' = to_string str' in
      extend phs;
      extend phs';
      build str str'
    (* Quantifiers and binders. *)
    | Expr.Triop (_, Ty.Triop.Ite, c, t, e) ->
      let* c = to_ast tys c in
      let* t = to_ast tys t in
      let* e = to_ast tys e in
      Ast.lor_ [ Ast.land_ [ c; t ]; Ast.land_ [ Ast.lnot c; e ] ]
    | Expr.Binder (((Binder.Forall | Binder.Exists) as q), atoms, formula) ->
      let binder =
        match q with
        | Binder.Forall -> Ast.any
        | Binder.Exists -> Ast.exists
        | _ -> failwith "Unreachable"
      in
      let atoms =
        List.map
          begin fun expr ->
            match Expr.view expr with
            | Expr.App (symbol, [ expr ])
              when match Expr.view expr with
                   | Symbol { name = Symbol.Simple "Int"; _ } -> true
                   | _ -> false ->
              let var = Symbol.to_string symbol in
              Ast.Any_atom (Ast.int_var var)
            | _ -> failwith "Unexpected value in quantifier"
          end
          atoms
      in
      let* formula = to_ast tys formula in
      binder atoms formula
    | Expr.Binder (Binder.Let_in, bindings, expr) -> begin
      let ast = to_ast tys expr in
      List.fold_left
        (fun acc binding ->
           match Expr.view binding with
           | Expr.App (symbol, [ expr ]) ->
             let symbol = Symbol.to_string symbol in
             (match expr |> to_ast tys with
              | (exception _) | Unsupp _ ->
                begin match to_eia_term expr with
                | eia', asts ->
                  let ast =
                    Ast.map
                      (function
                        | Ast.Eia eia ->
                          Ast.eia
                            (Ast.Eia.map2
                               Fun.id
                               (function
                                 | Ast.Eia.Atom (Ast.Var (v, _)) when v = symbol -> eia'
                                 | term -> term)
                               Fun.id
                               eia)
                        | ast -> ast)
                      acc
                  in
                  Ast.land_ [ ast; asts ]
                | exception _ -> failwith "Unexpected construction in let-in binding"
                end
              | ast' ->
                Ast.map
                  (function
                    | Ast.Pred symbol' when symbol = symbol' -> ast'
                    | ast -> ast)
                  acc)
           | _ -> failf "Unexpected construction in let-in binding")
        ast
        bindings
      end
    | _ -> failf (Format.asprintf "Expression %a can't be handled" Expr.pp orig_expr)
  with
  | UnsupportedException (m, e) -> Ast.Unsupp (`Msg (m, e))
;;

let to_ast a b =
  extras := [];
  let ast = to_ast a b in
  Ast.land_ (ast :: !extras)
;;

let pred_to_sym s = Expr.symbol (Symbol.make Ty.Ty_bool s)

let sym_to_pred (s : Symbol.t) =
  match s with
  | { ty = Ty.Ty_bool; name = Simple s; _ } -> s
  | _ -> assert false
;;

let rec of_ast = function
  | Ast.True -> Smtml.Expr.Bool.true_
  | Land [] -> Smtml.Expr.Bool.true_
  | Land (h :: tl) ->
    let h = of_ast h in
    let tl = List.map of_ast tl in
    List.fold_left Smtml.Expr.Bool.and_ h tl
  | Lor [] -> Smtml.Expr.Bool.false_
  | Lor (h :: tl) ->
    let h = of_ast h in
    let tl = List.map of_ast tl in
    List.fold_left Smtml.Expr.Bool.or_ h tl
  | Lnot el -> Smtml.Expr.Bool.not (of_ast el)
  | Exists (atoms, body) ->
    Smtml.Expr.exists
      (List.map
         (function
           | Ast.Any_atom (Ast.Var (s, S)) ->
             Expr.symbol (Smtml.Symbol.make Smtml.Ty.Ty_str s)
           | Ast.Any_atom (Ast.Var (s, I)) ->
             Expr.symbol (Smtml.Symbol.make Smtml.Ty.Ty_int s))
         atoms)
      (of_ast body)
  | Pred s -> pred_to_sym s
  | (Unsupp _ | Eia _) as ast ->
    failwith (Format.asprintf "cannot convert %a back to smtml" Ast.pp ast)
;;
