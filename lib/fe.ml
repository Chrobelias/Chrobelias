module Expr = Smtml.Expr
module Symbol = Smtml.Symbol
module Ty = Smtml.Ty
module Binder = Smtml.Binder

let failf fmt = Format.kasprintf failwith fmt

(* let ( >>| ) (acc, x) f = acc, f x *)
let return x = [], x

let rec list_mapk f xs k =
  match xs with
  | [] -> k []
  | h :: tl -> f h (fun h -> list_mapk f tl (fun tl -> k (h :: tl)))
;;

let rec list_foldk f acc xs k =
  match xs with
  | [] -> k acc
  | h :: tl -> f acc h (fun acc -> list_foldk f acc tl k)
;;

(*
   let rec list_map f = function
  | [] -> return []
  | h :: tl ->
    let* h = f h in
    let* tl = list_map f tl in
    return (h :: tl)
;; *)
let internalc = ref 0

let internal_name () =
  let r = String.concat "" [ "$"; !internalc |> Int.to_string ] in
  internalc := !internalc + 1;
  r
;;

let land_ = function
  | [] -> assert false
  | [ h ] -> h
  | xs -> Ast.land_ xs
;;

let rec to_string orig_expr k : Ast.t =
  let expr = Expr.view orig_expr in
  match expr with
  | Expr.Symbol symbol ->
    let var = Symbol.to_string symbol in
    k (Ast.Str.Atom (Ast.var var))
  | Expr.Val v ->
    (match v with
     | Str s -> k (Ast.Str.Const s)
     | _ -> failf "unable to handle %a as string" Expr.pp orig_expr)
  | Expr.Naryop (_, Ty.Naryop.Concat, ls) ->
    list_mapk to_string ls (fun ls ->
      match ls with
      | hd :: tl -> k (List.fold_left Ast.Str.concat hd tl)
      | _ -> failf "unable to concat 0 strings")
  | Expr.App ({ name = Symbol.Simple "str.from_int"; _ }, [ expr ])
  | Expr.App ({ name = Symbol.Simple "str.from.int"; _ }, [ expr ])
  | Expr.Cvtop (_, Ty.Cvtop.ToString, expr) ->
    assert false
    (* to_eia_term expr (fun (acc, str) ->
      match str with
      | Ast.Eia.Atom atom -> land_ (k (Ast.Str.FromEia atom) :: acc)
      | _ -> failwith "TBD: from.int now only expects vars inside") *)
  | Expr.Triop (_, Ty.Triop.Ite, c, th, el) ->
    _to_ir th (fun th ->
      _to_ir el (fun el ->
        to_string c (fun c ->
          let c = k c in
          Ast.lor_ [ land_ [ c; th ]; land_ [ Ast.lnot c; el ] ])))
  | Expr.Triop (_, Ty.Triop.String_extract, str, from, to') ->
    to_string str (fun str ->
      to_eia_term from (fun from ->
        let from' = Ast.var (internal_name ()) in
        to_eia_term to' (fun to' ->
          let to'' = Ast.var (internal_name ()) in
          Ast.land_
            [ k (Ast.Str.substr str from' to'')
            ; Ast.eia (Ast.Eia.eq (Ast.Eia.atom from') from)
            ; Ast.eia (Ast.Eia.eq (Ast.Eia.atom to'') to')
            ])))
  | Expr.Binop (_, Ty.Binop.At, str, sym) ->
    to_string str (fun str ->
      to_eia_term sym (fun sym ->
        let sym' = Ast.var (internal_name ()) in
        Ast.land_
          [ k (Ast.Str.at str sym'); Ast.eia (Ast.Eia.eq (Ast.Eia.atom sym') sym) ]))
  | _ -> failf "unable to handle %a as string" Expr.pp orig_expr

and to_regex orig_expr k =
  let expr = Expr.view orig_expr in
  let ( -- ) i j =
    let rec aux n acc = if n < i then acc else aux (n - 1) (n :: acc) in
    aux j []
  in
  match expr with
  | Expr.Symbol s when Symbol.to_string s = "re.allchar" ->
    k (Regex.kleene (Regex.symbol [ Nfa.Str.u_null ]))
  | Expr.App ({ name = Symbol.Simple "str.to.re"; _ }, [ expr ])
  | Expr.Cvtop (_, Ty.Cvtop.String_to_re, expr) ->
    to_string expr (fun str ->
      let str =
        match str with
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
      |> k)
  | Expr.Binop (_ty, Ty.Binop.Regexp_range, lhs, rhs) ->
    to_string lhs (fun lhs ->
      let lhs =
        match lhs with
        | Ast.Str.Const s -> s
        | _ -> failf "unable to create regex dynamically in %a" Expr.pp orig_expr
      in
      to_string rhs (fun rhs ->
        let rhs =
          match rhs with
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
        k
          (Char.code lhs -- Char.code rhs
           |> List.fold_left
                (fun acc c -> Regex.mor acc (Regex.symbol [ Char.chr c ]))
                Regex.empty)))
  | Expr.Naryop (_ty, Ty.Naryop.Concat, exprs) ->
    (* String constraints use LSB representation, we intentionally reverse the concat. *)
    list_mapk to_regex exprs (fun ms ->
      k (ms |> List.rev |> List.fold_left Regex.concat Regex.epsilon))
  | Expr.Naryop (_ty, Ty.Naryop.Regexp_union, exprs) ->
    list_mapk to_regex exprs (fun es -> k (List.fold_left Regex.mor Regex.empty es))
  | Expr.Binop (_ty, Ty.Binop.Regexp_inter, lhs, rhs) ->
    to_regex lhs (fun lhs -> to_regex rhs (fun rhs -> k (Regex.mand lhs rhs)))
  | Expr.Unop (_ty, Ty.Unop.Regexp_opt, expr) -> to_regex expr (fun x -> k (Regex.opt x))
  | Expr.Unop (_ty, Ty.Unop.Regexp_plus, expr) ->
    to_regex expr (fun x -> k (Regex.plus x))
  | Expr.Unop (_ty, Ty.Unop.Regexp_star, expr) ->
    to_regex expr (fun x -> k (Regex.kleene x))
  | Expr.Unop (_ty, Ty.Unop.Regexp_loop (l, r), stmt) ->
    to_regex stmt (fun stmt ->
      let lhs =
        List.init l (fun _ -> stmt) |> List.fold_left Regex.concat Regex.epsilon
      in
      let rhs =
        List.init r (fun _ -> Regex.opt stmt) |> List.fold_left Regex.concat lhs
      in
      k rhs)
  | Expr.Unop (_ty, Ty.Unop.Regexp_comp, expr) ->
    failwith "complements are not implemented yet since they would explode NFAs"
  | _ -> failf "unable to handle %a as regex" Expr.pp orig_expr

and to_eia_term : Expr.t -> (Ast.Eia.term -> Ast.t) -> Ast.t =
  let neg eia_term = Ast.Eia.mul [ Ast.Eia.atom (Ast.const Z.minus_one); eia_term ] in
  let rec fold1 op hd tl k =
    list_mapk helper (hd :: tl) (fun xs ->
      let hd = List.hd xs in
      let tl = List.tl xs in
      k (List.fold_left op hd tl))
  and helper orig_expr k =
    let ( let* ) x f = x (fun z -> k (f z)) in
    match Expr.view orig_expr with
    | Expr.Val v ->
      (match v with
       | Int d -> k (Ast.Eia.atom (Ast.const (Z.of_int d)))
       | _ -> failf "unable to handle %a as integer term" Expr.pp orig_expr)
    | Expr.App ({ name = Symbol.Simple "str.to.int"; _ }, [ e ])
    | Expr.App ({ name = Symbol.Simple "str.to_int"; _ }, [ e ])
    | Expr.Cvtop (_, Ty.Cvtop.String_to_int, e) ->
      to_string e (fun str -> k (Ast.Eia.stoi str))
    | Expr.Symbol symbol ->
      let var = Symbol.to_string symbol in
      k (Ast.Eia.atom (Ast.var var))
    (* Semenov arithmetic, i.e. 2**x operators. *)
    | Expr.App ({ name = Symbol.Simple "pow2"; _ }, [ expr ]) ->
      helper expr (fun rhs ->
        k @@ Ast.Eia.pow (Ast.Eia.atom (Ast.const (Z.of_int 2))) rhs)
    | Expr.App ({ name = Symbol.Simple "pow10"; _ }, [ expr ]) ->
      helper expr (fun rhs ->
        k @@ Ast.Eia.pow (Ast.Eia.atom (Ast.const (Z.of_int 10))) rhs)
    | Expr.App ({ name = Symbol.Simple "exp"; _ }, [ base; exp ]) ->
      helper base (fun base -> helper exp (fun exp -> k (Ast.Eia.pow base exp)))
    (* Bit-wise operations *)
    | Expr.App ({ name = Symbol.Simple "bwand"; _ }, hd :: tl) ->
      list_mapk helper (hd :: tl) (fun xs ->
        let hd = List.hd xs in
        let tl = List.tl xs in
        k (List.fold_left Ast.Eia.bwand hd tl))
    | Expr.App ({ name = Symbol.Simple "bwor"; _ }, hd :: tl) ->
      fold1 Ast.Eia.bwor hd tl k
    | Expr.App ({ name = Symbol.Simple "bwxor"; _ }, hd :: tl) ->
      fold1 Ast.Eia.bwxor hd tl k
    | Expr.Unop (_ty, Ty.Unop.Neg, expr) -> helper expr (fun t -> k (neg t))
    (* Arithmetic operations. *)
    | Expr.Binop (_ty, Ty.Binop.Add, lhs, rhs) ->
      helper lhs (fun lhs -> helper rhs (fun rhs -> k @@ Ast.Eia.Add [ lhs; rhs ]))
    | Expr.Binop (_ty, Ty.Binop.Sub, lhs, rhs) ->
      helper lhs (fun lhs -> helper rhs (fun rhs -> k (Ast.Eia.Add [ lhs; neg rhs ])))
    | Expr.Binop (_ty, Ty.Binop.Mul, lhs, rhs) ->
      helper lhs (fun lhs -> helper rhs (fun rhs -> k (Ast.Eia.Mul [ lhs; rhs ])))
    | Expr.App ({ name = Symbol.Simple "*"; _ }, exprs) ->
      list_mapk helper exprs (fun xs -> k (Ast.Eia.mul xs))
    | Expr.Unop (_ty, Ty.Unop.Length, expr) ->
      to_string expr (fun str -> k (Ast.Eia.len str))
    (* mod *)
    | Expr.Binop (_, Ty.Binop.Rem, lhs, rhs) ->
      (match Expr.view rhs with
       | Expr.Val (Int d) ->
         let* lhs = helper lhs in
         Ast.Eia.Mod (lhs, Z.of_int d)
       | _ -> failf "I expected term, in %a" Expr.pp orig_expr)
    | Expr.Triop (_, Ty.Triop.Ite, c, th, el) ->
      Format.printf
        "%s %d ITE.\n%!@[expr = @[%a@]@]\n%!"
        __FUNCTION__
        __LINE__
        Expr.pp
        orig_expr;
      (* TODO(Kakadu): Need to write something different here but I'm not sure what exactly *)
      _to_ir th (fun th ->
        _to_ir el (fun el ->
          helper c (fun c ->
            let c = k c in
            Ast.lor_ [ land_ [ c; th ]; land_ [ Ast.lnot c; el ] ])))
    | _ -> failf "expected term, in %a" Expr.pp orig_expr
  in
  helper

and _to_ir orig_expr k =
  let ( let* ) x f = x (fun z -> k (f z)) in
  (* Smtml Ty classification is kind of strange: it neither classifies the theory *)
  (* nor the return type. Let's introduce our own method for checking if the return *)
  (* type of the expr is string. *)
  let rec is_str expr =
    (Expr.ty expr = Ty.Ty_str
     &&
       match Expr.view expr with
       | Expr.Unop (_, Ty.Unop.Length, _)
       | Expr.App ({ name = Symbol.Simple "str.to.int"; _ }, [ _ ])
       | Expr.Cvtop (_, Ty.Cvtop.String_to_int, _) -> false
       | _ -> true)
    ||
      match Expr.view expr with
      | Expr.App ({ name = Symbol.Simple "str.from_int"; _ }, [ _ ])
      | Expr.App ({ name = Symbol.Simple "str.from.int"; _ }, [ _ ])
      | Expr.Cvtop (_, Ty.Cvtop.ToString, _) -> true
      | Expr.Triop (_, Ty.Triop.Ite, _, then_, _) -> is_str then_
      | _ -> false
  in
  let expr = Expr.view orig_expr in
  match expr with
  (* Constants. *)
  | Expr.Val v -> begin
    match v with
    | True -> k Ast.True
    | False -> k (Ast.lnot Ast.true_)
    | _ -> failf "unable to handle %a as boolean term" Expr.pp orig_expr
  end
  (* Variables. *)
  | Expr.Symbol symbol -> k (Ast.pred (Symbol.to_string symbol))
  (* Yes, probably this stuff is kinda over-engineered. *)
  (* Logical operations. *)
  (* Not. *)
  | Expr.Unop (_ty, Ty.Unop.Not, expr) -> _to_ir expr (fun x -> k (Ast.lnot x))
  | Expr.Binop (_ty, Ty.Binop.And, lhs, rhs) ->
    _to_ir lhs (fun lhs -> _to_ir rhs (fun rhs -> k (Ast.land_ [ lhs; rhs ])))
  | Expr.Naryop (_ty, Ty.Naryop.Logand, exprs) ->
    list_mapk _to_ir exprs (fun xs -> k (land_ xs))
  (* Binary and arbitrary or *)
  | Expr.Binop (_ty, Ty.Binop.Or, lhs, rhs) ->
    _to_ir lhs (fun lhs -> _to_ir rhs (fun rhs -> k (Ast.lor_ [ lhs; rhs ])))
  | Expr.Naryop (_ty, Ty.Naryop.Logor, exprs) ->
    list_mapk _to_ir exprs (fun xs -> k (Ast.lor_ xs))
  (* Implication *)
  | Expr.Binop (_ty, Ty.Binop.Implies, lhs, rhs) ->
    let* lhs = _to_ir lhs in
    let* rhs = _to_ir rhs in
    Ast.limpl lhs rhs
  (* Integer comparisons. *)
  | Expr.Relop (_ty, Ty.Relop.Eq, lhs, rhs) when is_str lhs || is_str rhs ->
    let build t c = Ast.str (Ast.Str.eq t c) in
    to_string lhs (fun lhs -> to_string rhs (fun rhs -> k @@ build lhs rhs))
  | Expr.Relop (_ty, rel, lhs, rhs) ->
    (* Format.printf "%s %d: expr = @[%a@]\n%!" __FILE__ __LINE__ Smtml.Expr.pp orig_expr; *)
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
    to_eia_term lhs (fun lhs -> to_eia_term rhs (fun rhs -> k @@ build lhs rhs))
  (* Strings. *)
  | Expr.App ({ name = Symbol.Simple "str.in.re"; _ }, [ str; re ])
  | Expr.Binop (_, Ty.Binop.String_in_re, str, re) ->
    to_string str (fun str ->
      to_regex re (fun re ->
        let re =
          Regex.concat
            (Regex.kleene (Regex.symbol [ Nfa.Str.u_eos ]))
            (Regex.concat re (Regex.kleene (Regex.symbol [ Nfa.Str.u_eos ])))
        in
        k (Ast.Str (Ast.Str.inre str re))))
  | Expr.Unop (_, Ty.Unop.Neg, arg) ->
    let* arg = _to_ir arg in
    Ast.lnot arg
    (* | Expr.App ({ name = Symbol.Simple "neg"; _ }, [ arg ]) -> failf "FUCK" *)

    (* Quantifiers and binders. *)
  | Expr.App ({ name = Symbol.Simple "str.prefixof"; _ }, [ str; str' ])
  | Expr.Binop (_, Ty.Binop.String_prefix, str, str') ->
    to_string str (fun str ->
      to_string str' (fun str' -> Ast.Str (Ast.Str.prefixof str str')))
  (* Quantifiers and binders. *)
  | Expr.Triop (_, Ty.Triop.Ite, c, t, e) ->
    let* c = _to_ir c in
    let* t = _to_ir t in
    let* e = _to_ir e in
    Ast.lor_ [ land_ [ c; t ]; land_ [ Ast.lnot c; e ] ]
  | Expr.Binder (((Binder.Forall | Binder.Exists) as q), atoms, formula) ->
    let binder =
      match q with
      | Binder.Forall -> Ast.any
      | Binder.Exists -> Ast.exists
      | _ -> failwith "Unreachable"
    in
    let atoms =
      List.map
        (fun expr ->
           match Expr.view expr with
           | Expr.App (symbol, [ expr ])
             when match Expr.view expr with
                  | Symbol { name = Symbol.Simple "Int"; _ } -> true
                  | _ -> false ->
             let var = Symbol.to_string symbol in
             Ast.var var
           | _ -> failwith "Unexpected value in quantifier")
        atoms
    in
    let rhs = _to_ir formula Fun.id in
    k (binder atoms rhs)
  | Expr.Binder (Binder.Let_in, bindings, expr) -> begin
    let bnds =
      List.map
        (fun e ->
           match Expr.view e with
           | Expr.App (symbol, [ expr ]) -> Symbol.to_string symbol, expr
           | _ -> failwith "Unexpected construction in let-in binding")
        bindings
    in
    let subst_symbol symbol ~by where =
      (* Format.printf
        "%s: [%s -> @[%a@]]%a\n%!"
        __FUNCTION__
        symbol
        Ast.pp_smtlib2
        by
        Ast.pp_smtlib2
        where; *)
      Ast.map
        (function
          | Ast.Pred symbol' when symbol = symbol' -> by
          | ast -> ast)
        where
    in
    let subst_var symbol ~by where =
      (* Format.printf
        "%s: [%s -> @[%a@]]%a\n%!"
        __FUNCTION__
        symbol
        Ast.Eia.pp_term
        by
        Ast.pp_smtlib2
        where; *)
      Ast.map
        (function
          | Ast.Eia eia ->
            Ast.eia
              (Ast.Eia.map2
                 Fun.id
                 (function
                   | Ast.Eia.Atom (Ast.Var v) when v = symbol -> by
                   | term -> term)
                 eia)
          | ast -> ast)
        where
    in
    _to_ir expr (fun ast ->
      list_foldk
        (fun acc (symbol, expr) k ->
           match _to_ir expr Fun.id with
           | ast' -> k @@ subst_symbol symbol ~by:ast' acc
           | exception Failure s ->
             Format.printf "Exception about '%s' ignored\n%!" s;
             k @@ to_eia_term expr (fun eia' -> k @@ subst_var symbol ~by:eia' acc))
        ast
        (List.rev bnds)
        k)
  end
  | _ -> failf "Expression %a can't be handled" Expr.pp orig_expr
;;
