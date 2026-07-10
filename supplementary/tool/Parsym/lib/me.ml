let trace_log fmt = Debug.trace "me" fmt
let _config = Config.config
let _base = _config.enc_base

module Map = Base.Map.Poly
module Set = Base.Set.Poly

let failf fmt = Format.kasprintf Result.error fmt

exception Unsupported_constraint of string

let return = Result.ok
let ( let* ) = Result.bind

let collect_free_ir (ir : Ir.t) =
  Ir.fold
    (fun acc -> function
       | Ir.Rel (_, term, _) -> term |> Map.keys |> Set.of_list |> Set.union acc
       | Ir.SReg (atom, _) -> Set.add acc atom
       | Ir.Reg (_, atoms) -> Set.union acc (atoms |> Set.of_list)
       | Ir.Exists (xs, ir) -> Set.diff acc (Set.of_list xs)
       | _ -> acc)
    Set.empty
    ir
;;

module type S = sig
  type t
  type repr

  val symbol : string -> t
  val poly_of_const : Z.t -> t
  val minus : t -> t -> t
  val add : t -> t -> t
  val mul : t -> t -> t
  val bwop : FT_SIG.sup_binop -> t -> t -> t
  val prj : t -> repr
  val prjs : t -> Ir.atom * Ir.t list
  val iofs : string Ast.RLia.term -> t
end

[@@@warnerror "-32-37-39"]

module Symantics : S with type repr = (Ir.atom, Z.t) Map.t * Z.t * Ir.t list = struct
  let failf fmt = Format.kasprintf failwith fmt

  type repr = (Ir.atom, Z.t) Map.t * Z.t * Ir.t list

  type t =
    | Poly of (Ir.atom, Q.t) Map.t * Z.t * Ir.t list
    | Symbol of Ir.atom * Ir.t list

  let pp ppf =
    let open Format in
    function
    | Poly _ -> fprintf ppf "Poly"
    | Symbol (a, _) -> fprintf ppf "Symbol (%a,_)" Ir.pp_atom a
  ;;

  let as_poly = function
    | Poly (poly, c, sups) as x -> x
    | Symbol (symbol, sups) -> Poly (Map.singleton symbol Q.one, Z.zero, sups)
  ;;

  let from_rat : (Ir.atom, Q.t) Map.t -> Z.t -> (Ir.atom, Z.t) Map.t * Z.t =
    fun mapa c ->
    let lcmz = Map.fold mapa ~init:Z.one ~f:(fun ~key:_ ~data -> Z.lcm (Q.den data)) in
    let mapa = Map.map mapa ~f:(fun q -> Z.(lcmz / Q.den q * Q.num q)) in
    let c = Z.(c * lcmz) in
    mapa, c
  ;;

  let as_symbol = function
    | Poly (poly, c, sups)
      when c = Z.zero && Map.length poly = 1 && Map.nth_exn poly 0 |> snd = Q.one ->
      Symbol (Map.nth_exn poly 0 |> fst, sups)
    | Poly (poly, c, sups) ->
      let var = Ir.internal () in
      let poly, c = from_rat poly c in
      let sup = Ir.eq (Map.add_exn ~key:var ~data:Z.minus_one poly) Z.(( ~- ) c) in
      Symbol (var, sup :: sups)
    | Symbol _ as s -> s
  ;;

  let prj = function
    | Poly (mapa, c, sups) ->
      let mapa, c = from_rat mapa c in
      mapa, c, sups
    | Symbol (symbol, sups) -> Map.singleton symbol Z.one, Z.zero, sups
  ;;

  let prjs v =
    match as_symbol v with
    | Symbol (symbol, sups) -> symbol, sups
    | _ -> assert false
  ;;

  let symbol s = Symbol (Ir.var s, [])
  let poly_of_const c = Poly (Map.empty, c, [])

  let rec bwop : FT_SIG.sup_binop -> t -> t -> t =
    fun op l r ->
    match l, r with
    | Symbol (lhs, sups), Symbol (rhs, sups2) ->
      let regex =
        match op with
        | Bwand -> Regex.bwand
        | Bwor -> Regex.bwor
        | Bwxor -> Regex.bwxor
      in
      let var = Ir.internal () in
      let sup = Ir.reg regex [ var; lhs; rhs ] in
      let sups = sups @ sups2 in
      Symbol (var, sup :: sups)
    | Poly _, _ -> bwop op (as_symbol l) r
    | _, Poly _ -> bwop op l (as_symbol r)
  ;;

  let rec minus l r =
    match l, r with
    | (Symbol _ as s), (Poly _ as p) -> minus (as_poly s) p
    | (Poly _ as p), (Symbol _ as s) -> minus p (as_poly s)
    | Poly (poly, c, sups), Poly (poly', c', sups') ->
      let poly =
        Map.merge poly poly' ~f:(fun ~key:_ vs ->
          match vs with
          | `Left a -> Some a
          | `Right a -> Some Q.(zero - a)
          | `Both (a, b) -> Some Q.(a - b))
      in
      let c = Z.(c' - c) in
      let sups = sups @ sups' in
      Poly (poly, c, sups)
    | Symbol (_, _), Symbol (_, _) -> minus (as_poly l) (as_poly r)
  ;;

  let rec add l r =
    match l, r with
    | (Poly _ as p), (Symbol _ as s) | (Symbol _ as s), (Poly _ as p) -> add p (as_poly s)
    | Poly (poly, c, sups), Poly (poly', c', sups') ->
      let poly =
        Map.merge poly poly' ~f:(fun ~key:_ vs ->
          match vs with
          | `Left a | `Right a -> Some a
          | `Both (a, b) -> Some Q.(a + b))
      in
      let c = Z.(c' + c) in
      let sups = sups @ sups' in
      Poly (poly, c, sups)
    | Symbol (l, sup1), Symbol (r, sup2) ->
      if Ir.eq_atom l r
      then Poly (Map.singleton l (Q.of_int 2), Z.zero, sup1 @ sup2)
      else
        Poly (Map.add_exn ~key:r ~data:Q.one (Map.singleton l Q.one), Z.zero, sup1 @ sup2)
  ;;

  let pp_polynom ppf poly =
    let fprintf = Format.fprintf in
    let pp_map ppf mapa =
      let one =
        fun ~key ~data ->
        match data with
        | data when data = Q.one -> fprintf ppf "%a@ " Ir.pp_atom key
        | data when data > Q.zero ->
          fprintf ppf "(* %a %a)@ " Q.pp_print data Ir.pp_atom key
        | _ -> fprintf ppf "(* (- %a) %a)@ " Q.pp_print (Q.( ~- ) data) Ir.pp_atom key
      in
      if Map.length mapa = 1
      then (
        let v, coeff = Map.min_elt_exn mapa in
        one ~key:v ~data:coeff)
      else (
        fprintf ppf "@[(+ ";
        Map.iteri mapa ~f:one;
        fprintf ppf ")@]@ ")
    in
    fprintf ppf "@[(%a)@]@ " pp_map poly
  ;;

  let rec mul l r =
    match l, r with
    | (Poly _ as p), (Symbol _ as s) | (Symbol _ as s), (Poly _ as p) -> mul p (as_poly s)
    | Poly (poly, c, sups), Poly (poly', c', sups') ->
      let poly, c, d =
        if Map.length poly' = 0
        then poly, c, c'
        else if Map.length poly = 0
        then poly', c', c
        else
          raise
            (Unsupported_constraint
               (Format.asprintf
                  "unable to multiply var by var: %a with %a"
                  pp_polynom
                  poly
                  pp_polynom
                  poly'))
      in
      let poly = poly |> Map.map ~f:Q.(fun a -> a * Q.of_bigint d) in
      let c = Z.(c * d) in
      let sups = sups @ sups' in
      Poly (poly, c, sups)
    | _ ->
      Format.print_flush ();
      failf "not implemented: %s. l = %a, r = %a%!" __FUNCTION__ pp l pp r
  ;;

  let stoi (v : _ Ast.RLia.term) =
    match v with
    | Ast.RLia.Atom (Var (v, _)) ->
      Symbol (Ir.var v, [ Ir.leq (Map.singleton (Ir.var v) Z.minus_one) Z.zero ])
    | Ast.RLia.(Str_const s) ->
      let u = Ir.internal () in
      let re = Regex.int_to_re s in
      Symbol (u, [ Ir.sreg u re ])
    | _ -> failwith (Format.asprintf "TBD: %a %s %d" Ast.RLia.pp_term v __FILE__ __LINE__)
  ;;

  let iofs = stoi
end

let is_int (type a) : a Ast.RLia.term -> bool = function
  | Ast.RLia.Atom _ | Add _ | Mul _ | Mod _ | Bwand _ | Bwor _ | Bwxor _ -> true
  | _ -> false
;;

let cast_to_int (type a) : a Ast.RLia.term -> Z.t Ast.RLia.term option = function
  | (Add _ | Mul _ | Mod _ | Bwand _ | Bwor _ | Bwxor _) as x -> Some x
  | Ast.RLia.Atom (Var (v, I)) -> Some (Ast.RLia.Atom (Var (v, I)))
  | _ -> None
;;

[@@@ocaml.warnerror "-8"]

let rec of_str_atom = function
  | Ast.RLia.Atom (Var (atom, _)) -> return (Ir.var atom, [])
  | Str_const s ->
    let re = Regex.int_to_re s in
    let u = Ir.internal () in
    (u, [ Ir.sreg u re ]) |> return
  | ast ->
    (match cast_to_int ast with
     | Some ast ->
       let u = Ir.internal () in
       let* ast = helper ast in
       let poly, c, sup = ast |> Symantics.prj in
       let poly = Map.add_exn poly ~key:u ~data:Z.minus_one in
       (u, Ir.eq poly c :: sup) |> return
     | None -> failwith (Format.asprintf "Not implemented %a" Ast.RLia.pp_term ast))

and helper : 'a. 'a Ast.RLia.term -> _ =
  fun (type a) : (a Ast.RLia.term -> _) -> function
  | Ast.RLia.Atom (Var (v, _)) -> return (Symantics.symbol v)
  | Const c -> return (Symantics.poly_of_const c)
  | Str_const _ -> failf "Not implemented"
  | Add (hd :: tl) ->
    List.fold_left
      (fun acc (x : _ Ast.RLia.term) ->
         let* acc = acc in
         let* x = helper x in
         return (Symantics.add acc x))
      (helper hd)
      tl
  | Mul [ lhs; rhs ] ->
    let* lhs = helper lhs in
    let* rhs = helper rhs in
    begin try
      let res = Symantics.mul lhs rhs in
      return res
    with
    | Failure s -> failf "%s" s
    end
  | (Bwand (lhs, rhs) | Bwor (lhs, rhs) | Bwxor (lhs, rhs)) as rlia ->
    let* lhs = helper lhs in
    let* rhs = helper rhs in
    let regex =
      match rlia with
      | Bwand _ -> Symantics.bwop Bwand
      | Bwor _ -> Symantics.bwop Bwor
      | Bwxor _ -> Symantics.bwop Bwxor
      | _ -> failwith "unreachable"
    in
    return (regex lhs rhs)
  | Iofs v -> return (Symantics.iofs v)
  | other -> raise (Unsupported_constraint (Format.asprintf "%a" Ast.RLia.pp_term other))

and of_rlia2 : Ast.RLia.t -> (Ir.t, string) result =
  fun rlia ->
  let as_atom = function
    | poly, c when c = Z.zero && Map.length poly = 1 && Map.nth_exn poly 0 |> snd = Z.one
      -> Some (Map.nth_exn poly 0 |> fst)
    | _ -> None
  in
  (* trace_log "%s: %a" __FUNCTION__ Ast.RLia.pp rlia; *)
    match rlia with
    (* | Eq
        (Ast.RLia.Atom (Ast.Var (v, _)), Ast.RLia.Iofs (Ast.RLia.Atom (Ast.Var (u, _))), I)
      -> return (Ir.land_ [ Ir.stoi (Ir.var v) (Ir.var u) ]) *)
    | Eq (Atom (Var (v, _)), Str_const str, S) ->
      let l = Ir.var v in
      return (Ir.sreg l (Regex.int_to_re str))
    | Eq (lhs, rhs, I) ->
      let* lhs = helper lhs in
      let* rhs = helper rhs in
      let poly, c, sups = Symantics.prj (Symantics.minus lhs rhs) in
      let ans = Ir.land_ (Ir.eq poly c :: sups) in
      (* trace_log "%a ~~> %a" Ast.RLia.pp rlia Ir.pp ans; *)
      return ans
    | Eq (lhs, rhs, S) as seq -> return (Ir.Unsupp (Format.asprintf "%a" Ast.RLia.pp seq))
    | Neq (lhs, rhs, I) ->
      let* lhs = helper lhs in
      let* rhs = helper rhs in
      let poly, c, sups = Symantics.prj (Symantics.minus lhs rhs) in
      let ans = Ir.land_ (Ir.neq poly c :: sups) in
      (* trace_log "%a ~~> %a" Ast.RLia.pp rlia Ir.pp ans; *)
      return ans
    | Neq (lhs, rhs, S) as sneq ->
      return (Ir.Unsupp (Format.asprintf "%a" Ast.RLia.pp sneq))
      (* trace_log "%a ~~> %a" Ast.RLia.pp rlia Ir.pp ans; *)
    | Leq (lhs, rhs) ->
      let* lhs = helper lhs in
      let* rhs = helper rhs in
      let poly, c, sups = Symantics.prj (Symantics.minus lhs rhs) in
      let ans = Ir.land_ (Ir.leq poly c :: sups) in
      (* trace_log "%a ~~> %a" Ast.RLia.pp rlia Ir.pp ans; *)
      return ans
    | InRe (str, Ast.S, re) ->
      let* str, sup = of_str_atom str in
      let ir = Ir.sreg str re in
      ir :: sup |> Ir.land_ |> return
    | InReRaw (str, Ast.S, re) ->
      let* str, sup = of_str_atom str in
      let ir = Ir.sregraw str re in
      ir :: sup |> Ir.land_ |> return
    | InReRaw (rlia, Ast.I, re) ->
      let* str = helper rlia in
      let str, sups = Symantics.prjs str in
      let ir = Ir.sregraw str re in
      ir :: sups |> Ir.land_ |> return
    | InRe (rlia, Ast.I, re) ->
      let* lhs = helper rlia in
      let lhs, sups = Symantics.prjs lhs in
      let ir = Ir.sreg lhs re in
      ir :: sups |> Ir.land_ |> return
    | V (rlia, pow) ->
      let flatten expr =
        let poly, c, sups = Symantics.prj expr in
        let e = as_atom (poly, c) in
        if Option.is_some e
        then Option.get e, sups
        else begin
          let e = Ir.internal () in
          let poly_e = Map.add_exn poly ~key:e ~data:Z.minus_one in
          e, Ir.eq poly_e Z.(-c) :: sups
        end
      in
      if AstL.Lia.equal rlia pow
      then
        let* expr = helper rlia in
        let e, sups = flatten expr in
        return (Ir.land_ (Ir.v e e :: sups))
      else
        let* expr = helper rlia in
        let* pow = helper pow in
        let e, sups = flatten expr in
        let p, sups' = flatten pow in
        let sups = sups @ sups' in
        return (Ir.land_ (Ir.v e p :: sups))
;;

let ir_of_ast env ast =
  let rec ir_of_ast (ast : Ast.t) =
    match ast with
    | True -> return Ir.true_
    | Lnot ast ->
      let* ir = ir_of_ast ast in
      return (Ir.lnot ir)
    | Land asts ->
      let* irs = List.map ir_of_ast asts |> Base.Result.all in
      return (Ir.land_ irs)
    | Lor asts ->
      let* irs = List.map ir_of_ast asts |> Base.Result.all in
      return (Ir.lor_ irs)
    | Exists (atoms, ast) ->
      let atoms =
        List.map
          (function
            | Ast.Any_atom (Ast.Var (v, _)) -> Ir.var v)
          atoms
      in
      let* ir = ir_of_ast ast in
      return (Ir.exists atoms ir)
    | RLia rlia ->
      (try
         (match Sys.getenv_opt "CHRO_EIA" with
          (*| Some "old" -> of_rlia*)
          | _ -> of_rlia2)
           rlia
       with
       | Unsupported_constraint s -> return (Ir.Unsupp s))
    | Unsupp s -> return (Ir.Unsupp s)
    | Pred s -> failf "Unexpected %s" s
  in
  let* ir = ast |> ir_of_ast in
  ir |> return
;;
