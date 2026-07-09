module Expr = Smtml.Expr
module Symbol = Smtml.Symbol
module Ty = Smtml.Ty
module Binder = Smtml.Binder

exception UnsupportedException of string

let failf fmt = raise (UnsupportedException fmt)

type r =
  | Str of string Ast.RLia.term
  | Int of Z.t Ast.RLia.term
[@@deriving variants]

let rec to_string orig_expr =
  let expr = Expr.view orig_expr in
  match expr with
  | Expr.Symbol symbol ->
    let var = Symbol.to_string symbol in
    Ast.RLia.Atom (Ast.str_var var)
  | Expr.Val v ->
    begin match v with
    | Str s -> Ast.RLia.(Str_const s)
    | _ -> failf (Format.asprintf "unable to handle %a as string" Expr.pp orig_expr)
    end
  | _ -> failf (Format.asprintf "unable to handle %a as string" Expr.pp orig_expr)

and to_regex orig_expr =
  let expr = Expr.view orig_expr in
  match expr with
  | Expr.Symbol s when Symbol.to_string s = "re.none" -> Regex.empty
  | Expr.Symbol s when Symbol.to_string s = "re.nostr" -> Regex.empty
  | Expr.Symbol s when Symbol.to_string s = "re.allchar" -> Regex.allchar
  | Expr.App ({ name = Symbol.Simple "str.to.re"; _ }, [ expr ])
  | Expr.Cvtop (_, Ty.Cvtop.String_to_re, expr) ->
    let str =
      match to_string expr with
      | Ast.RLia.Str_const s -> s
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
      | Ast.RLia.(Str_const s) -> s
      | _ ->
        failf
          (Format.asprintf "unable to create regex dynamically in %a" Expr.pp orig_expr)
    in
    let rhs =
      match to_string rhs with
      | Ast.RLia.(Str_const s) -> s
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

and to_rlia_term orig_expr : Z.t Ast.RLia.term =
  let neg rlia_term = Ast.RLia.mul [ Ast.RLia.const Z.minus_one; rlia_term ] in
  let expr = Expr.view orig_expr in
  match expr with
  | Expr.Val v ->
    begin match v with
    | Int d -> Ast.RLia.const (Z.of_int d)
    | _ -> failf (Format.asprintf "unable to handle %a as integer term" Expr.pp orig_expr)
    end
  | Expr.App ({ name = Symbol.Simple "str.to.int"; _ }, [ expr ])
  | Expr.Cvtop (_, Ty.Cvtop.String_to_int, expr) ->
    let str = to_string expr in
    Ast.RLia.iofs str
  | Expr.Symbol symbol ->
    let var = Symbol.to_string symbol in
    Ast.RLia.atom (Ast.int_var var)
  (* Bit-wise operations *)
  | Expr.App ({ name = Symbol.Simple "bwand"; _ }, hd :: tl) ->
    List.fold_left
      (fun acc el -> Ast.RLia.bwand acc (to_rlia_term el))
      (to_rlia_term hd)
      tl
  | Expr.App ({ name = Symbol.Simple "bwor"; _ }, hd :: tl) ->
    List.fold_left
      (fun acc el -> Ast.RLia.bwor acc (to_rlia_term el))
      (to_rlia_term hd)
      tl
  | Expr.App ({ name = Symbol.Simple "bwxor"; _ }, hd :: tl) ->
    List.fold_left
      (fun acc el -> Ast.RLia.bwxor acc (to_rlia_term el))
      (to_rlia_term hd)
      tl
  | Expr.Unop (_ty, Ty.Unop.Neg, expr) -> neg (to_rlia_term expr)
  (* Arithmetic operations. *)
  | Expr.Binop (_ty, Ty.Binop.Add, lhs, rhs) ->
    Ast.RLia.Add [ to_rlia_term lhs; to_rlia_term rhs ]
  | Expr.Binop (_ty, Ty.Binop.Sub, lhs, rhs) ->
    Ast.RLia.Add [ to_rlia_term lhs; neg (to_rlia_term rhs) ]
  | Expr.Binop (_ty, Ty.Binop.Mul, lhs, rhs) ->
    Ast.RLia.mul [ to_rlia_term lhs; to_rlia_term rhs ]
  | Expr.App ({ name = Symbol.Simple "*"; _ }, exprs) ->
    Ast.RLia.mul (List.map to_rlia_term exprs)
  (* mod *)
  | Expr.Binop (_, Ty.Binop.Rem, lhs, rhs) ->
    (match Expr.view rhs with
     | Expr.Val (Int d) -> Ast.RLia.Mod (to_rlia_term lhs, Z.of_int d)
     | _ -> failf (Format.asprintf "expected term, in %a" Expr.pp orig_expr))
  | _ -> failf (Format.asprintf "expected term, in %a" Expr.pp orig_expr)

and _to_ir tys orig_expr =
  let is_str tys expr =
    (Expr.ty expr = Ty.Ty_str
     &&
       match Expr.view expr with
       | Expr.Unop (_, Ty.Unop.Length, _)
       | Expr.App ({ name = Symbol.Simple "str.to.int"; _ }, [ _ ])
       | Expr.Cvtop (_, Ty.Cvtop.String_to_int, _) -> false
       | _ -> true)
    ||
      match Expr.view expr with
      | Expr.Symbol symbol ->
        Option.bind
          (Base.Map.Poly.find tys (Ir.var (Symbol.to_string symbol)))
          (function
            | `Str -> Option.some true
            | _ -> Option.none)
        |> Option.is_some
      | Expr.App ({ name = Symbol.Simple "str.from_int"; _ }, [ _ ])
      | Expr.App ({ name = Symbol.Simple "str.from.int"; _ }, [ _ ])
      | Expr.Cvtop (_, Ty.Cvtop.ToString, _) -> true
      | _ -> false
  in
  let to_regex_helper term re =
    let term = to_string term in
    let is_empty re =
      match Expr.view re with
      | Expr.App ({ name = Symbol.Simple "str.to.re"; _ }, [ expr ])
      | Expr.Cvtop (_, Ty.Cvtop.String_to_re, expr) ->
        (match to_string expr with
         | Ast.RLia.Str_const "" -> true
         | _ -> false)
      | _ -> false
    in
    let expr = Expr.view re in
    match expr with
    | Expr.App ({ name = Symbol.Simple "str.to.re"; _ }, [ expr ])
    | Expr.Cvtop (_, Ty.Cvtop.String_to_re, expr) ->
      let str =
        match to_string expr with
        | Ast.RLia.Str_const s -> s
        | _ ->
          failf (Format.asprintf "unable to create regex dynamically in %a" Expr.pp expr)
      in
      Ast.RLia (Ast.RLia.eq term (Ast.RLia.Str_const str) Ast.S)
    | Expr.Unop (_ty, Ty.Unop.Regexp_plus, re') when is_empty re' ->
      Ast.RLia (Ast.RLia.eq term (Ast.RLia.Str_const "") Ast.S)
    | Expr.Unop (_ty, Ty.Unop.Regexp_star, re') when is_empty re' ->
      Ast.RLia (Ast.RLia.eq term (Ast.RLia.Str_const "") Ast.S)
    | _ ->
      let re = to_regex re in
      let re = Regex.concat re (Regex.kleene (Regex.symbol [ Nfa.Str.u_eos ])) in
      Ast.RLia (Ast.RLia.inre term Ast.S re)
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
    (* Logical operations. *)
    (* Not. *)
    | Expr.Unop (_ty, Ty.Unop.Not, expr) -> Ast.lnot (_to_ir tys expr)
    | Expr.Binop (_ty, Ty.Binop.And, lhs, rhs) ->
      Ast.land_ [ _to_ir tys lhs; _to_ir tys rhs ]
    | Expr.Naryop (_ty, Ty.Naryop.Logand, exprs) ->
      Ast.land_ (List.map (_to_ir tys) exprs)
    (* Binary and arbitrary or *)
    | Expr.Binop (_ty, Ty.Binop.Or, lhs, rhs) -> begin
      Ast.lor_ [ _to_ir tys lhs; _to_ir tys rhs ]
      end
    | Expr.Naryop (_ty, Ty.Naryop.Logor, exprs) -> Ast.lor_ (List.map (_to_ir tys) exprs)
    (* Implication *)
    | Expr.Binop (_ty, Ty.Binop.Implies, lhs, rhs) ->
      Ast.limpl (_to_ir tys lhs) (_to_ir tys rhs)
    (* Integer comparisons. *)
    | Expr.Relop (_ty, Ty.Relop.Eq, lhs, rhs) when is_str tys lhs || is_str tys rhs ->
      let build t c = Ast.rlia (Ast.RLia.eq t c S) in
      let lhs = to_string lhs in
      let rhs = to_string rhs in
      build lhs rhs
    | Expr.Relop (_ty, rel, lhs, rhs) ->
      let build =
        match rel with
        | Ty.Relop.Eq -> fun t c -> Ast.rlia (Ast.RLia.eq t c I)
        | Ty.Relop.Ne -> fun t c -> Ast.lnot (Ast.rlia (Ast.RLia.eq t c I))
        | Ty.Relop.Le -> fun t c -> Ast.rlia (Ast.RLia.leq t c)
        | Ty.Relop.Lt -> fun t c -> Ast.rlia (Ast.RLia.lt t c)
        | Ty.Relop.Ge -> fun t c -> Ast.rlia (Ast.RLia.geq t c)
        | Ty.Relop.Gt -> fun t c -> Ast.rlia (Ast.RLia.gt t c)
        | _ -> failwith "Unsupported relational operator in EIA"
      in
      let lhs = to_rlia_term lhs in
      let rhs = to_rlia_term rhs in
      build lhs rhs
      (* Buchi arithmetic. *)
    | Expr.App ({ name = Symbol.Simple "int.v"; _ }, [ e; p ]) ->
      let expr = to_rlia_term e in
      let pow = to_rlia_term p in
      Ast.rlia (Ast.RLia.v expr pow)
    (* Strings. *)
    | Expr.App ({ name = Symbol.Simple "str.in.re"; _ }, [ str; re ])
    | Expr.Binop (_, Ty.Binop.String_in_re, str, re) -> to_regex_helper str re
    (* Quantifiers and binders. *)
    | Expr.Triop (_, Ty.Triop.Ite, c, t, e) ->
      let c = _to_ir tys c in
      let t = _to_ir tys t in
      let e = _to_ir tys e in
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
      binder atoms (_to_ir tys formula)
    | Expr.Binder (Binder.Let_in, bindings, expr) -> begin
      let ast = _to_ir tys expr in
      List.fold_left
        (fun acc binding ->
           match Expr.view binding with
           | Expr.App (symbol, [ expr ]) ->
             let symbol = Symbol.to_string symbol in
             (match expr |> _to_ir tys with
              | (exception _) | Unsupp _ ->
                begin match to_rlia_term expr with
                | rlia' ->
                  Ast.map
                    (function
                      | Ast.RLia rlia ->
                        Ast.rlia
                          (Ast.RLia.map2
                             Fun.id
                             (function
                               | Ast.RLia.Atom (Ast.Var (v, _)) when v = symbol -> rlia'
                               | term -> term)
                             Fun.id
                             rlia)
                      | ast -> ast)
                    acc
                | exception _ -> failwith "Unexpected construction in let-in binding"
                end
              | ast' ->
                Ast.map
                  (function
                    | Ast.Pred symbol' when symbol = symbol' -> ast'
                    | ast -> ast)
                  acc)
           | _ -> failwith "Unexpected construction in let-in binding")
        ast
        bindings
      end
    | _ -> failf (Format.asprintf "Expression %a can't be handled" Expr.pp orig_expr)
  with
  | UnsupportedException m -> Ast.Unsupp m
;;
