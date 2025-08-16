[@@@ocaml.warnerror "-26-32"]

module type SYM0 = sig
  type term
  type ph

  include Overapprox.s_term with type term := term
  include Overapprox.s_ph with type ph := ph and type term := term
  include Overapprox.s_extra with type ph := ph and type term := term

  val pow2var : string -> term
end

module type SYM = sig
  include SYM0

  type repr

  val prj : ph -> Smtml.Expr.t list
end

module Sugar (S : sig
    type term
    type ph

    val eq : term -> term -> ph
    val leq : term -> term -> ph
    val lt : term -> term -> ph
  end) =
struct
  let ( = ) = S.eq
  let ( < ) = S.lt
  let ( <= ) = S.leq
end

let make_sym bound =
  let module M = struct
    open Smtml

    type term = Smtml.Expr.t list
    type ph = term

    (* let ( let* ) xs f = List.concat_map f xs *)
    let return x = [ x ]

    let ( <*> ) : 'a 'b. ('a -> 'b) list -> 'a list -> 'b list =
      fun fs xs -> List.concat_map (fun f -> List.map (fun x -> f x) xs) fs
    ;;

    let const n = return (Smtml.Expr.value (Value.Int n))
    let var s = return (Smtml.Expr.symbol (Smtml.Symbol.make Smtml.Ty.Ty_int s))
    let true_ = return Expr.Bool.true_
    let false_ = return Expr.Bool.false_
    let not x = return Expr.Bool.not <*> x
    let mul2 a b = return (Expr.binop Ty.Ty_int Ty.Binop.Mul) <*> a <*> b
    let add2 a b = return (Expr.binop Ty.Ty_int Ty.Binop.Mul) <*> a <*> b
    let land2 a b = return Expr.Bool.and_ <*> a <*> b
    let lor2 a b = return Expr.Bool.or_ <*> a <*> b

    let manyarg f = function
      | [] -> assert false
      | h :: tl -> List.fold_left f h tl
    ;;

    let mul = manyarg mul2
    let add = manyarg add2
    let land_ = manyarg land2
    let lor_ = manyarg lor2
    let leq a b = return (Expr.relop Ty.Ty_int Ty.Relop.Le) <*> a <*> b
    let lt a b = return (Expr.relop Ty.Ty_int Ty.Relop.Lt) <*> a <*> b
    let eq a b = return (Expr.relop Ty.Ty_int Ty.Relop.Eq) <*> a <*> b
    let pow base p = return (Expr.binop Ty.Ty_int Ty.Binop.Pow) <*> base <*> p

    let bw op l r =
      match op with
      | Me.Bwand -> return (Expr.binop Ty.Ty_int Ty.Binop.And) <*> l <*> r
      | Bwor -> return (Expr.binop Ty.Ty_int Ty.Binop.Or) <*> l <*> r
      | Bwxor -> return (Expr.binop Ty.Ty_int Ty.Binop.Xor) <*> l <*> r
    ;;

    let pow2var str : term =
      List.concat @@ List.init bound (fun i -> pow (const 2) (const i))
    ;;

    type repr = Smtml.Expr.t list

    let prj = Fun.id
  end
  in
  (module struct
    include M
    include Sugar (M)
  end : SYM)
;;

let apply_symnatics (module S : SYM) =
  let rec helper = function
    | Ast.Land xs -> S.land_ (List.map helper xs)
    | Lor xs -> S.lor_ (List.map helper xs)
    | Lnot x -> S.not (helper x)
    | True -> S.true_
    | Eia e -> helper_eia e
    | Pred s -> assert false
    | Exists (vs, ph) as other ->
      Format.eprintf "Unsupported: %a\n%!" Ast.pp other;
      exit 2
  and helperT = function
    | Ast.Eia.Atom (Ast.Const n) -> S.const n
    | Atom (Ast.Var s) -> S.var s
    | Add terms -> S.add (List.map helperT terms)
    | Mul terms -> S.mul (List.map helperT terms)
    | Pow (Atom (Ast.Const 2), Atom (Ast.Var x)) -> S.pow2var x
    | Pow (base, p) -> S.pow (helperT base) (helperT p)
    | Bwand _ | Bwor _ | Bwxor _ -> failwith "not implemented"
  and helper_eia eia =
    match eia with
    | Ast.Eia.Eq (l, r) -> S.(helperT l = helperT r)
    | Leq (l, r) -> S.(helperT l <= helperT r)
  in
  fun x -> S.prj (helper x)
;;

let log = Debug.printfln

let check bound ast =
  let ((module S : SYM) as sym) = make_sym bound in
  let phs = apply_symnatics sym ast in
  log "There are %d choices \n%!" (List.length phs);
  try
    List.iteri
      (fun i ph ->
         let solver = Smtml.Z3_mappings.Solver.make () in
         Smtml.Z3_mappings.Solver.reset solver;
         log "Checking (%d): @[%a@]" i Smtml.Expr.pp ph;
         match Smtml.Z3_mappings.Solver.check solver ~assumptions:[ ph ] with
         | `Sat -> raise Exit
         | _ -> ())
      phs;
    (* TODO: if all Unsat, add a constraints (x>bound) *)
    log "Can't decide in %s" __FILE__;
    `Unknown
  with
  | Exit -> `Sat
;;
