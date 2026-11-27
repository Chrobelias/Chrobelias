open Smtml

exception Unsupported of string

let unsupported e = raise (Unsupported (Fmt.str "%a" Expr.pp e))

let map f e =
  match Expr.view e with
  | Expr.List l -> Expr.list (List.map f l)
  | App (s, l) -> Expr.app s (List.map f l)
  | Unop (t, o, a) -> Expr.raw_unop t o (f a)
  | Binop (t, o, a, b) -> Expr.raw_binop t o (f a) (f b)
  | Triop (t, o, a, b, c) -> Expr.raw_triop t o (f a) (f b) (f c)
  | Relop (t, o, a, b) -> Expr.raw_relop t o (f a) (f b)
  | Cvtop (t, o, a) -> Expr.raw_cvtop t o (f a)
  | Naryop (t, o, l) -> Expr.raw_naryop t o (List.map f l)
  | Extract (a, high, low) -> Expr.raw_extract (f a) ~high ~low
  | Concat (a, b) -> Expr.raw_concat (f a) (f b)
  | Binder (b, vs, a) -> Expr.binder b vs (f a)
  | Val _ | Ptr _ | Symbol _ -> e
;;

let rec subst env e =
  match Expr.view e with
  | Expr.Symbol s -> Option.value (List.assoc_opt (Symbol.to_string s) env) ~default:e
  | Binder (Let_in, bs, body) ->
    let bind b =
      match Expr.view b with
      | App (s, [ t ]) -> Symbol.to_string s, subst env t
      | _ -> unsupported b
    in
    subst (List.map bind bs @ env) body
  | Binder _ -> unsupported e
  | _ -> map (subst env) e
;;

let eq a b = Expr.raw_relop Ty_none Eq a b
let ite c a b = Expr.raw_triop Ty_none Ite c a b

let sort_name = function
  | Ty.Ty_int -> "Int"
  | Ty_bool -> "Bool"
  | Ty_str -> "String"
  | t -> raise (Unsupported (Fmt.str "arrays of %a" Ty.pp t))
;;

let eliminate cmds =
  let arrs =
    List.filter_map
      (function
        | Ast.Declare_const { id; sort = { ty = Ty_array (_, e); _ } }
        | Declare_fun { id; args = []; sort = { ty = Ty_array (_, e); _ } } ->
          Some (Symbol.to_string id, e)
        | _ -> None)
      cmds
  in
  let reads = ref []
  and fresh = ref [] in
  let read a i =
    match List.find_opt (fun (b, j, _) -> a = b && Expr.equal i j) !reads with
    | Some (_, _, v) -> v
    | None ->
      let ty = List.assoc a arrs in
      let id = Symbol.make_const ty (Printf.sprintf "%s!%d" a (List.length !reads)) in
      let v = Expr.symbol id in
      let decl =
        Ast.Declare_const
          { id; sort = Symbol.{ ty; name = Simple (sort_name ty); namespace = Sort } }
      in
      fresh := decl :: !fresh;
      List.iter
        (fun (b, j, w) ->
           if a = b
           then
             fresh
             := Ast.Assert (Expr.raw_binop Ty_bool Implies (eq i j) (eq v w)) :: !fresh)
        !reads;
      reads := (a, i, v) :: !reads;
      v
  in
  let is_arr s = List.mem_assoc (Symbol.to_string s) arrs in
  let rec tr e =
    match Expr.view e with
    | Expr.Binop (_, Select, a, i) -> sel a (tr i)
    | Triop (_, Store, _, _, _) -> unsupported e
    | Symbol s when is_arr s -> unsupported e
    | _ -> map tr e
  and sel a i =
    match Expr.view a with
    | Expr.Triop (_, Store, b, j, v) -> ite (eq (tr j) i) (tr v) (sel b i)
    | Triop (_, Ite, c, x, y) -> ite (tr c) (sel x i) (sel y i)
    | Symbol s when is_arr s -> read (Symbol.to_string s) i
    | _ -> unsupported a
  in
  let cmd = function
    | (Ast.Declare_const { id; _ } | Declare_fun { id; _ }) when is_arr id -> []
    | Assert e ->
      let e = tr (subst [] e) in
      let f = List.rev !fresh in
      fresh := [];
      f @ [ Ast.Assert e ]
    | c -> [ c ]
  in
  if arrs = [] then cmds else List.concat_map cmd cmds
;;
