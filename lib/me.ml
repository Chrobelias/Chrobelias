(** Middle-end *)

module Map = Base.Map.Poly
module Set = Base.Set.Poly

let log = Utils.log
let failf fmt = Format.kasprintf Result.error fmt
let return = Result.ok
let ( let* ) = Result.bind

let as_var = function
  | Ir.Pow2 var -> Ir.var var
  | Ir.Var var -> Ir.var var
;;

let collect_free_ir (ir : Ir.t) =
  Ir.fold
    (fun acc -> function
       | Ir.Rel (_, term, _) ->
         term |> Map.keys |> List.map as_var |> Set.of_list |> Set.union acc
       | Ir.SReg (atom, _) -> Set.add acc atom
       | Ir.SLen (atom, atom') -> Set.add (Set.add acc atom) atom'
       | Ir.Stoi (atom, atom') -> Set.add (Set.add acc atom) atom'
       | Ir.Itos (atom, atom') -> Set.add (Set.add acc atom) atom'
       | Ir.SEq (atom, atom') -> Set.add (Set.add acc atom) atom'
       | Ir.Reg (_, atoms) -> Set.union acc (atoms |> Set.of_list)
       | Ir.Exists (xs, ir) -> Set.diff acc (Set.of_list xs)
       | _ -> acc)
    Set.empty
    ir
;;

(** Final-tagless style for building our representation  *)
module type S = sig
  type t
  type repr

  val symbol : string -> t
  val poly_of_const : Z.t -> t
  val minus : t -> t -> t
  val add : t -> t -> t
  val mul : t -> t -> t
  val bwop : FT_SIG.sup_binop -> t -> t -> t
  val pow : base:t -> t -> t
  val prj : t -> repr
  val prjs : t -> Ir.atom * Ir.t list

  (* Alias for [iofs] *)
  val stoi : string Ast.Eia.term -> t
  val iofs : string Ast.Eia.term -> t
  val len2 : string Ast.Eia.term -> t
end

[@@@warnerror "-32-37-39"]

(*| s -> failf "unsupported string expression %a" Ast.pp (Ast.Eia s)*)

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
          failf
            "unable to multiply var by var: %a with %a"
            pp_polynom
            poly
            pp_polynom
            poly'
      in
      let poly = poly |> Map.map ~f:Q.(fun a -> a * Q.of_bigint d) in
      let c = Z.(c * d) in
      let sups = sups @ sups' in
      Poly (poly, c, sups)
    | _ ->
      Format.print_flush ();
      failf "not implemented: %s. l = %a, r = %a%!" __FUNCTION__ pp l pp r
  ;;

  let rec pow ~base exp =
    let two = Config.base () in
    let four = Z.(two * two) in
    match base, exp with
    | Poly (base_poly, base, base_sups), _ when Map.is_empty base_poly && base = four ->
      pow ~base:(Poly (base_poly, two, base_sups)) (mul (poly_of_const two) exp)
    | Poly (base_poly, base, base_sups), Poly (exp_map, exp_c, exp_sups)
      when Map.is_empty base_poly && base = two ->
      let merged_sups = base_sups @ exp_sups in
      (match Map.length exp_map with
       | 0 -> Poly (base_poly, Utils.powz ~base:two exp_c, base_sups @ exp_sups)
       | 1 ->
         let coeff =
           if Z.(exp_c > zero)
           then Q.of_bigint (Utils.powz ~base:two exp_c)
           else (
             let c = Utils.powz ~base:two Z.(-exp_c) in
             Q.(one / of_bigint c))
         in
         let merged_sups, var =
           match Map.min_elt_exn exp_map with
           | Var s, coeff when Q.(coeff = one) -> merged_sups, Ir.pow2 s
           | Var s, coeff ->
             let newv : string = Ir.internal_name () in
             ( Ir.eq
                 (Map.of_alist_exn
                    [ Ir.Var newv, Z.minus_one; Ir.var s, Q.to_bigint coeff ])
                 Z.zero
               :: merged_sups
             , Ir.pow2 newv )
           | Pow2 s, coeff when exp_c = Z.zero ->
             let newv : string = Ir.internal_name () in
             ( Ir.eq
                 (Map.of_alist_exn
                    [ Ir.Var newv, Z.minus_one; Pow2 s, Q.to_bigint coeff ])
                 Z.zero
               :: merged_sups
             , Ir.pow2 newv )
           | x -> failf "not implemented: %a\n%!" Ir.pp_atom (x |> fst)
         in
         Poly (Map.singleton var coeff, Z.zero, merged_sups)
       | _ ->
         let var = Ir.internal_name () in
         let coeff =
           if Z.(exp_c > zero)
           then Q.of_bigint (Utils.powz ~base:two exp_c)
           else (
             let c = Utils.powz ~base:two Z.(-exp_c) in
             Q.(one / of_bigint c))
         in
         let sup1 =
           let mapa, c =
             from_rat (Map.add_exn ~key:(Ir.var var) ~data:Q.(zero - one) exp_map) Z.zero
           in
           Ir.eq mapa c
         in
         (* Debug.printfln "new variable %a for " Ir.pp_atom var; *)
         Poly (Map.singleton (Ir.pow2 var) coeff, Z.zero, (sup1 :: base_sups) @ exp_sups))
    | Poly (base_poly, c, base_sups), Symbol (exp_symbol, exp_sups)
      when Map.length base_poly = 0 && c = two ->
      let poly =
        match exp_symbol with
        | Var v -> Map.singleton (Ir.pow2 v) Q.one
        | _ -> failwith "unreachable"
      in
      let sups = base_sups @ exp_sups in
      Poly (poly, Z.zero, sups)
    | Symbol (a, _), _ ->
      failwith
        (Format.asprintf
           "only the same base %a is supported in exponents (got %a)"
           Z.pp_print
           (Config.base ())
           Ir.pp_atom
           a)
    | Poly (base_poly, base_c, base_sups), _ ->
      failwith
        (Format.asprintf
           "only the same base %a is supported in exponents (got %a)"
           Z.pp_print
           (Config.base ())
           Z.pp_print
           base_c)
  ;;

  let len2 (v : string Ast.Eia.term) =
    match v with
    | Ast.Eia.Atom (Var (v, _)) ->
      let u = Ir.internal () in
      Symbol (u, [ Ir.slen u (Ir.var v) ])
    | Ast.Eia.Str_const s ->
      Poly (Map.empty, Z.(pow (Config.base ()) (String.length s) - one), [])
    | _ -> failwith "unreachable"
  ;;

  let stoi (v : _ Ast.Eia.term) =
    match v with
    | Ast.Eia.Atom (Var (v, _)) -> Symbol (Ir.var v, [])
    | Ast.Eia.(Str_const s) ->
      let u = Ir.internal () in
      let re = Regex.int_to_re s in
      Symbol (u, [ Ir.sreg u re ])
    | _ -> failwith (Format.asprintf "TBD: %a %s %d" Ast.Eia.pp_term v __FILE__ __LINE__)
  ;;

  let iofs = stoi

  (*let sofi : Z.t Ast.Eia.term -> _ = function
    | Ast.Eia.Atom (Var (v, _)) -> Symbol (Ir.var v, [])
    | Ast.Eia.Const n ->
      (* TODO(Kakadu): Goshan, please double check three lines below *)
      let u = Ir.internal () in
      let re = str_to_re (Format.asprintf "%a" Z.pp_print n) in
      Symbol (u, [ Ir.sreg u re ])
    | v -> failwith (Format.asprintf "TBD: %a %s %d" Ast.Eia.pp_term v __FILE__ __LINE__)
  ;;*)
  (*let u = Ir.internal () in
    let v =
      match v with
      | Ast.Eia.Atom (Var v) -> v
      | _ ->
        Format.eprintf "term = %a\n%!" Ast.Eia.pp_term v;
        failwith (Format.asprintf "TBD: %s %d" __FILE__ __LINE__)
    in
    Symbol (u, [ Ir.stoi u (Ir.var v) ]) *)
end

let is_int (type a) : a Ast.Eia.term -> bool = function
  | Ast.Eia.Atom _ | Len _ | Add _ | Mul _ | Mod _ | Bwand _ | Bwor _ | Bwxor _ | Pow _ ->
    true
  | _ -> false
;;

let cast_to_int (type a) : a Ast.Eia.term -> Z.t Ast.Eia.term option = function
  | (Len _ | Add _ | Mul _ | Mod _ | Bwand _ | Bwor _ | Bwxor _ | Pow _) as x -> Some x
  | Ast.Eia.Atom (Var (v, I)) -> Some (Ast.Eia.Atom (Var (v, I)))
  | _ -> None
;;

[@@@ocaml.warnerror "-8"]

let rec of_str_atom = function
  | Ast.Eia.Atom (Var (atom, _)) -> return (Ir.var atom, [])
  | Str_const s ->
    let re = Regex.int_to_re s in
    let u = Ir.internal () in
    (u, [ Ir.sreg u re ]) |> return
  | Concat _ -> failf "unsupported concatenation"
  | At _ -> failf "unsupported indexation"
  | Substr _ -> failf "unsupported substrings"
  | Sofi v ->
    let v, sup = helper v |> Result.get_ok |> Symantics.prjs in
    let u = Ir.internal () in
    (u, Ir.itos u v :: sup) |> return
  | ast ->
    (match cast_to_int ast with
     | Some ast ->
       let u = Ir.internal () in
       let* ast = helper ast in
       let poly, c, sup = ast |> Symantics.prj in
       let poly = Map.add_exn poly ~key:u ~data:Z.minus_one in
       (u, Ir.eq poly c :: sup) |> return
     | None -> failwith (Format.asprintf "NOT YET IMPLEMENTED %a" Ast.Eia.pp_term ast))

and helper : 'a. 'a Ast.Eia.term -> _ =
  fun (type a) : (a Ast.Eia.term -> _) -> function
  | Ast.Eia.Atom (Var (v, _)) -> return (Symantics.symbol v)
  | Const c -> return (Symantics.poly_of_const c)
  | Str_const _ -> failf "unimplemented "
  | Add (hd :: tl) ->
    List.fold_left
      (fun acc (x : _ Ast.Eia.term) ->
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
  | Pow (base, exp) ->
    let* base = helper base in
    let* exp = helper exp in
    return (Symantics.pow ~base exp)
  | (Bwand (lhs, rhs) | Bwor (lhs, rhs) | Bwxor (lhs, rhs)) as eia ->
    let* lhs = helper lhs in
    let* rhs = helper rhs in
    let regex =
      match eia with
      | Bwand _ -> Symantics.bwop Bwand
      | Bwor _ -> Symantics.bwop Bwor
      | Bwxor _ -> Symantics.bwop Bwxor
      | _ -> failwith "unreachable"
    in
    return (regex lhs rhs)
  | Iofs v -> return (Symantics.stoi v)
  | Len v as el ->
    failwith
      (Format.asprintf
         "Lengths should have been rewritten into chrob.len, found %a"
         Ast.Eia.pp_term
         el)
  | Len2 v -> return (Symantics.len2 v)
  | other ->
    (* Format.eprintf "%s fails on '%a'\n%!" __FUNCTION__ Ast.Eia.pp_term other; *)
    failf "unimplemented %a" Ast.Eia.pp_term other

and of_eia2 : Ast.Eia.t -> (Ir.t, string) result =
  fun eia ->
  (* log "%s: %a" __FUNCTION__ Ast.Eia.pp eia; *)
    match eia with
    | Eq (Ast.Eia.Atom (Ast.Var (v, _)), Ast.Eia.Len2 (Atom (Ast.Var (v', _))), I) ->
      return (Ir.slen (Ir.var v) (Ir.var v'))
    | Eq (Ast.Eia.Const v, Ast.Eia.Len2 (Atom (Ast.Var (v', _))), I) ->
      let u = Ir.internal () in
      return (Ir.land_ [ Ir.slen u (Ir.var v'); Ir.eq (Map.singleton u Z.one) v ])
    | Eq (Ast.Eia.Atom (Ast.Var (v, _)), Ast.Eia.Iofs (Ast.Eia.Atom (Ast.Var (u, _))), I)
      -> return (Ir.land_ [ Ir.stoi (Ir.var v) (Ir.var u) ])
    | Eq (Atom (Var (v, _)), Str_const str, S) ->
      let l = Ir.var v in
      return (Ir.sreg l (Regex.int_to_re str))
    (*
       | Ast.Eia.Eq (a, b) ->
      let* a, sup_a = of_str a in
      let* b, sup_b = of_str_atom b in
      let sup = sup_a @ sup_b in
      let atoms =
        List.map collect_free_ir sup |> List.fold_left Set.union Set.empty |> Set.to_list
      in
      let ir = Ir.seq a b in
      begin
        match atoms with
        | [] -> ir :: sup |> Ir.land_ |> return
        | atoms -> Ir.exists atoms (ir :: sup |> Ir.land_) |> return
      end *)
    | Eq (lhs, rhs, I) ->
      let* lhs = helper lhs in
      let* rhs = helper rhs in
      let poly, c, sups = Symantics.prj (Symantics.minus lhs rhs) in
      let ans = Ir.land_ (Ir.eq poly c :: sups) in
      (* log "%a ~~> %a" Ast.Eia.pp eia Ir.pp ans; *)
      return ans
    | Eq (lhs, rhs, S) ->
      let* a, sup_a = of_str_atom lhs in
      let* b, sup_b = of_str_atom rhs in
      let sup = sup_a @ sup_b in
      let ans = Ir.land_ (Ir.seq a b :: sup) in
      (* log "%a ~~> %a" Ast.Eia.pp eia Ir.pp ans; *)
      return ans
    | Leq (lhs, rhs) ->
      let* lhs = helper lhs in
      let* rhs = helper rhs in
      let poly, c, sups = Symantics.prj (Symantics.minus lhs rhs) in
      let ans = Ir.land_ (Ir.leq poly c :: sups) in
      (* log "%a ~~> %a" Ast.Eia.pp eia Ir.pp ans; *)
      return ans
    | InRe (str, Ast.S, re) ->
      let* str, sup = of_str_atom str in
      let ir = Ir.sreg str re in
      ir :: sup |> Ir.land_ |> return
    | InReRaw (str, Ast.S, re) ->
      let* str, sup = of_str_atom str in
      let ir = Ir.sregraw str re in
      ir :: sup |> Ir.land_ |> return
    | InReRaw (eia, Ast.I, re) ->
      let* str = helper eia in
      let str, sups = Symantics.prjs str in
      let ir = Ir.sregraw str re in
      ir :: sups |> Ir.land_ |> return
    | InRe (eia, Ast.I, re) ->
      let* lhs = helper eia in
      let lhs, sups = Symantics.prjs lhs in
      let ir = Ir.sreg lhs re in
      ir :: sups |> Ir.land_ |> return
    | RLen (v, pow) ->
      let* lhs = helper v in
      let* rhs = helper pow in
      let lhs, sups = Symantics.prjs lhs in
      let rhs, sups' = Symantics.prjs rhs in
      let ir = Ir.slen lhs rhs in
      (ir :: sups) @ sups' |> Ir.land_ |> return
    | PrefixOf (a, b) ->
      let* a, sup_a = of_str_atom a in
      let* b, sup_b = of_str_atom b in
      let sup = sup_a @ sup_b in
      let ir = Ir.sprefixof a b in
      let atoms =
        List.map collect_free_ir sup |> List.fold_left Set.union Set.empty |> Set.to_list
      in
      begin match atoms with
      | [] -> ir :: sup |> Ir.land_ |> return
      | atoms -> Ir.exists atoms (ir :: sup |> Ir.land_) |> return
      end
    | Contains (a, b) ->
      let* a, sup_a = of_str_atom a in
      let* b, sup_b = of_str_atom b in
      let sup = sup_a @ sup_b in
      let ir = Ir.scontains a b in
      let atoms =
        List.map collect_free_ir sup |> List.fold_left Set.union Set.empty |> Set.to_list
      in
      begin match atoms with
      | [] -> ir :: sup |> Ir.land_ |> return
      | atoms -> Ir.exists atoms (ir :: sup |> Ir.land_) |> return
      end
    | SuffixOf (a, b) ->
      let* a, sup_a = of_str_atom a in
      let* b, sup_b = of_str_atom b in
      let sup = sup_a @ sup_b in
      let ir = Ir.ssuffixof a b in
      let atoms =
        List.map collect_free_ir sup |> List.fold_left Set.union Set.empty |> Set.to_list
      in
      begin match atoms with
      | [] -> ir :: sup |> Ir.land_ |> return
      | atoms -> Ir.exists atoms (ir :: sup |> Ir.land_) |> return
      end
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
    | Eia eia ->
      (match Sys.getenv_opt "CHRO_EIA" with
       (*| Some "old" -> of_eia*)
       | _ -> of_eia2)
        eia
    | Pred s | Unsupp s -> failf "Unexpected %s" s
  in
  (*let ast =
    Env.fold
      ~init:[ ast ]
      ~f:(fun ~key ~data acc ->
        match data with
        | Ast.TT (S, (Ast.Eia.Sofi _ as data)) ->
          Ast.eia (Ast.Eia.eq (Ast.Eia.atom (Ast.var key S)) data S) :: acc
        | Ast.TT (I, ((Ast.Eia.Iofs _ | Ast.Eia.Len _ | Ast.Eia.Len2 _) as data)) ->
          Ast.eia (Ast.Eia.eq (Ast.Eia.atom (Ast.var key I)) data I) :: acc
        | _ -> acc)
      env
  in
  let ast = Ast.land_ ast in*)
  (* let ast = SimplII.rewrite_len ast in *)
  let* ir = ast |> ir_of_ast in
  ir |> return
;;

let%expect_test _ =
  let open Ast in
  let wrap ast =
    Format.printf "@[%a@]\n%!" Ast.pp_smtlib2 (Eia ast);
    (*let ir1 = of_eia ast in
    Format.printf "@[IR1: %a@]\n%!" Ir.pp_smtlib2 ir1;*)
    let ir2 = of_eia2 ast |> Result.get_ok in
    Format.printf "@[IR2: %a@]\n%!" Ir.pp_smtlib2 ir2
  in
  wrap
    (Ast.Eia.leq
       Eia.(pow (const (Z.of_int 2)) (Eia.pow (const (Z.of_int 2)) (Atom (int_var "z"))))
       Eia.(Const Z.one));
  [%expect
    {|
    (<= (exp 2 (exp 2 z)) 1)
    IR2: (assert (<= pow2(%0)  1) )
         (assert (= (+ (* (- 1) %0) pow2(z) )  0) )
    |}]
;;
