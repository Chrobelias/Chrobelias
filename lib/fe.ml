module Expr = Smtml.Expr
module Symbol = Smtml.Symbol
module Ty = Smtml.Ty
module Binder = Smtml.Binder

let failf fmt = Format.kasprintf failwith fmt

let rec to_string orig_expr =
  let expr = Expr.view orig_expr in
  match expr with
  | Expr.Symbol symbol ->
    let var = Symbol.to_string symbol in
    Ast.Str.Atom (Ast.var var)
  | Expr.Val v -> begin
    match v with
    | Str s -> Ast.Str.Const s
    | _ -> failf "unable to handle %a as string" Expr.pp orig_expr
  end
  | _ -> failf "unable to handle %a as string" Expr.pp orig_expr

and to_regex orig_expr =
  let expr = Expr.view orig_expr in
  match expr with
  | Expr.Symbol s when Symbol.to_string s = "re.allchar" ->
    Regex.kleene (Regex.symbol [ Nfa.Str.u_null ])
  | Expr.App ({ name = Symbol.Simple "str.to.re"; _ }, [ expr ])
  | Expr.Cvtop (_, Ty.Cvtop.String_to_re, expr) ->
    let str =
      match to_string expr with
      | Ast.Str.Const s -> s
      | _ -> failf "unable to create regex dynamically in %a" Expr.pp expr
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
      | Ast.Str.Const s -> s
      | _ -> failf "unable to create regex dynamically in %a" Expr.pp orig_expr
    in
    let rhs =
      match to_string rhs with
      | Ast.Str.Const s -> s
      | _ -> failf "unable to create regex dynamically in %a" Expr.pp orig_expr
    in
    let () =
      if String.length lhs <> 1 || String.length rhs <> 1
      then failf "expected range strings %s %s to be of length 1" lhs rhs
      else ()
    in
    let lhs = String.get lhs 0 in
    let rhs = String.get rhs 0 in
    Char.code lhs -- Char.code rhs
    |> List.fold_left
         (fun acc c -> Regex.mor acc (Regex.symbol [ Char.chr c ]))
         Regex.empty
  | Expr.Naryop (_ty, Ty.Naryop.Concat, exprs) ->
    (* String constraints use LSB representation, we intentionally reverse the concat. *)
    List.map to_regex exprs |> List.rev |> List.fold_left Regex.concat Regex.epsilon
  | Expr.Naryop (_ty, Ty.Naryop.Regexp_union, exprs) ->
    List.map to_regex exprs |> List.fold_left Regex.mor Regex.empty
  | Expr.Binop (_ty, Ty.Binop.Regexp_inter, lhs, rhs) ->
    let lhs = to_regex lhs in
    let rhs = to_regex rhs in
    Regex.mand lhs rhs
  | Expr.Unop (_ty, Ty.Unop.Regexp_opt, expr) -> to_regex expr |> Regex.opt
  | Expr.Unop (_ty, Ty.Unop.Regexp_plus, expr) -> to_regex expr |> Regex.plus
  | Expr.Unop (_ty, Ty.Unop.Regexp_star, expr) -> to_regex expr |> Regex.kleene
  | Expr.Unop (_ty, Ty.Unop.Regexp_comp, expr) ->
    failwith "complements are not implemented yet since they would explode NFAs"
  | _ -> failf "unable to handle %a as regex" Expr.pp orig_expr

and to_eia_term orig_expr =
  let neg eia_term = Ast.Eia.mul [ Ast.Eia.atom (Ast.const Z.minus_one); eia_term ] in
  let expr = Expr.view orig_expr in
  match expr with
  | Expr.Val v -> begin
    match v with
    | Int d -> Ast.Eia.atom (Ast.const (Z.of_int d))
    | _ -> failf "unable to handle %a as integer term" Expr.pp orig_expr
  end
  | Expr.App ({ name = Symbol.Simple "str.to.int"; _ }, [ expr ])
  | Expr.Cvtop (_, Ty.Cvtop.String_to_int, expr) ->
    let str = to_string expr in
    Ast.Eia.stoi str
  | Expr.Symbol symbol ->
    let var = Symbol.to_string symbol in
    Ast.Eia.atom (Ast.var var)
  (* Semenov arithmetic, i.e. 2**x operators. *)
  | Expr.App ({ name = Symbol.Simple "pow2"; _ }, [ expr ]) ->
    Ast.Eia.pow (Ast.Eia.atom (Ast.const (Z.of_int 2))) (to_eia_term expr)
  | Expr.App ({ name = Symbol.Simple "pow10"; _ }, [ expr ]) ->
    Ast.Eia.pow (Ast.Eia.atom (Ast.const (Z.of_int 10))) (to_eia_term expr)
  | Expr.App ({ name = Symbol.Simple "exp"; _ }, [ base; exp ]) ->
    Ast.Eia.pow (to_eia_term base) (to_eia_term exp)
  (* Bit-wise operations *)
  | Expr.App ({ name = Symbol.Simple "bwand"; _ }, hd :: tl) ->
    List.fold_left (fun acc el -> Ast.Eia.bwand acc (to_eia_term el)) (to_eia_term hd) tl
  | Expr.App ({ name = Symbol.Simple "bwor"; _ }, hd :: tl) ->
    List.fold_left (fun acc el -> Ast.Eia.bwor acc (to_eia_term el)) (to_eia_term hd) tl
  | Expr.App ({ name = Symbol.Simple "bwxor"; _ }, hd :: tl) ->
    List.fold_left (fun acc el -> Ast.Eia.bwxor acc (to_eia_term el)) (to_eia_term hd) tl
  | Expr.Unop (_ty, Ty.Unop.Neg, expr) -> neg (to_eia_term expr)
  (* Arithmetic operations. *)
  | Expr.Binop (_ty, Ty.Binop.Add, lhs, rhs) ->
    Ast.Eia.Add [ to_eia_term lhs; to_eia_term rhs ]
  | Expr.Binop (_ty, Ty.Binop.Sub, lhs, rhs) ->
    Ast.Eia.Add [ to_eia_term lhs; neg (to_eia_term rhs) ]
  | Expr.Binop (_ty, Ty.Binop.Mul, lhs, rhs) ->
    Ast.Eia.mul [ to_eia_term lhs; to_eia_term rhs ]
  | Expr.App ({ name = Symbol.Simple "*"; _ }, exprs) ->
    Ast.Eia.mul (List.map to_eia_term exprs)
  | Expr.Unop (_ty, Ty.Unop.Length, expr) ->
    let str = to_string expr in
    Ast.Eia.len str
  | _ -> failf "expected term, in %a" Expr.pp orig_expr

and _to_ir orig_expr =
  (* Smtml Ty classification is kind of strange: it neither classifies the theory *)
  (* nor the return type. Let's introduce our own method for checking if the return *)
  (* type of the expr is string. *)
  let is_str expr =
    Expr.ty expr = Ty.Ty_str
    &&
      match Expr.view expr with
      | Expr.Unop (_, Ty.Unop.Length, _)
      | Expr.App ({ name = Symbol.Simple "str.to.int"; _ }, [ _ ])
      | Expr.Cvtop (_, Ty.Cvtop.String_to_int, _) -> false
      | _ -> true
  in
  let expr = Expr.view orig_expr in
  match expr with
  (* Constants. *)
  | Expr.Val v -> begin
    match v with
    | True -> Ast.True
    | False -> Ast.lnot Ast.true_
    | _ -> failf "unable to handle %a as boolean term" Expr.pp orig_expr
  end
  (* Variables. *)
  | Expr.Symbol symbol -> Ast.pred (Symbol.to_string symbol)
  (* Yes, probably this stuff is kinda over-engineered. *)
  (* Logical operations. *)
  (* Not. *)
  | Expr.Unop (_ty, Ty.Unop.Not, expr) -> Ast.lnot (_to_ir expr)
  | Expr.Binop (_ty, Ty.Binop.And, lhs, rhs) -> Ast.land_ [ _to_ir lhs; _to_ir rhs ]
  | Expr.Naryop (_ty, Ty.Naryop.Logand, exprs) -> Ast.land_ (List.map _to_ir exprs)
  (* Binary and arbitrary or *)
  | Expr.Binop (_ty, Ty.Binop.Or, lhs, rhs) -> begin
    Ast.lor_ [ _to_ir lhs; _to_ir rhs ]
  end
  | Expr.Naryop (_ty, Ty.Naryop.Logor, exprs) -> Ast.lor_ (List.map _to_ir exprs)
  (* Implication *)
  | Expr.Binop (_ty, Ty.Binop.Implies, lhs, rhs) -> Ast.limpl (_to_ir lhs) (_to_ir rhs)
  (* Integer comparisons. *)
  | Expr.Relop (_ty, Ty.Relop.Eq, lhs, rhs) when is_str lhs || is_str rhs ->
    let build t c = Ast.str (Ast.Str.eq t c) in
    let lhs = to_string lhs in
    let rhs = to_string rhs in
    build lhs rhs
  | Expr.Relop (_ty, rel, lhs, rhs) ->
    let build =
      match rel with
      | Ty.Relop.Eq -> fun t c -> Ast.eia (Ast.Eia.eq t c)
      | Ty.Relop.Ne -> fun t c -> Ast.lnot (Ast.eia (Ast.Eia.eq t c))
      | Ty.Relop.Le -> fun t c -> Ast.eia (Ast.Eia.leq t c)
      | Ty.Relop.Lt -> fun t c -> Ast.eia (Ast.Eia.lt t c)
      | Ty.Relop.Ge -> fun t c -> Ast.eia (Ast.Eia.geq t c)
      | Ty.Relop.Gt -> fun t c -> Ast.eia (Ast.Eia.gt t c)
      | _ -> failwith "Unsupported relational operator in EIA"
    in
    let lhs = to_eia_term lhs in
    let rhs = to_eia_term rhs in
    build lhs rhs
  (* Strings. *)
  | Expr.App ({ name = Symbol.Simple "str.in.re"; _ }, [ str; re ])
  | Expr.Binop (_, Ty.Binop.String_in_re, str, re) ->
    let str = to_string str in
    let re = to_regex re in
    let re = Regex.concat re (Regex.kleene (Regex.symbol [ Nfa.Str.u_eos ])) in
    Ast.Str (Ast.Str.inre str re)
  (* Quantifiers and binders. *)
  | Expr.Triop (_, Ty.Triop.Ite, c, t, e) ->
    let c = _to_ir c in
    let t = _to_ir t in
    let e = _to_ir e in
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
        begin
          fun expr ->
            match Expr.view expr with
            | Expr.App (symbol, [ expr ])
              when match Expr.view expr with
                   | Symbol { name = Symbol.Simple "Int"; _ } -> true
                   | _ -> false ->
              let var = Symbol.to_string symbol in
              Ast.var var
            | _ -> failwith "Unexpected value in quantifier"
        end
        atoms
    in
    binder atoms (_to_ir formula)
  | Expr.Binder (Binder.Let_in, bindings, expr) -> begin
    let ast = _to_ir expr in
    List.fold_left
      begin
        fun acc binding ->
          match Expr.view binding with
          | Expr.App (symbol, [ expr ]) ->
            let symbol = Symbol.to_string symbol in
            begin
              match expr |> _to_ir with
              | ast' ->
                Ast.map
                  (function
                    | Ast.Pred symbol' when symbol = symbol' -> ast'
                    | ast -> ast)
                  acc
              | exception _ -> begin
                match expr |> to_eia_term with
                | eia' ->
                  Ast.map
                    (function
                      | Ast.Eia eia ->
                        Ast.eia
                          (Ast.Eia.map2
                             Fun.id
                             (function
                               | Ast.Eia.Atom (Ast.Var v) when v = symbol -> eia'
                               | term -> term)
                             eia)
                      | ast -> ast)
                    acc
                | exception _ -> failwith "Unexpected construction in let-in binding"
              end
            end
          | _ -> failwith "Unexpected construction in let-in binding"
      end
      ast
      bindings
  end
  | _ -> Format.asprintf "Expression %a can't be handled" Expr.pp orig_expr |> failwith
;;
