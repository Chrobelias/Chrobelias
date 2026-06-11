(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)
let trace_log fmt = Debug.trace "simpl" fmt

let _config = Config.config
let _base = _config.enc_base

module Z3 = Smtml.Z3_mappings.Solver

let _z3_solver = Z3.make ~params:
    Smtml.Params.(default () $ (Random_seed, Config.config.seed))
      ()

let ( -- ) i j =
  let rec aux n acc = if n < i then acc else aux (n - 1) (n :: acc) in
  aux j []
;;

module SM = struct
  include Map.Make (Base.String)

  let iteri ~f m = iter (fun key data -> f ~key ~data) m
  let find_exn m k = find k m
  let find m k = find_opt k m
  let mem env k = mem k env
  let add_exn m ~key ~data = add key data m
end

let _failf fmt = Format.kasprintf failwith fmt

type kv = KV : AstL.atom * AstL.Lia.term -> kv

type t =
  { env : AstL.Lia.term SM.t (** Integer equalities *)
  ; cstrts : kv list (* constraints multimap *)
  }

let pp ?(title = "") : Format.formatter -> t -> unit =
  let open Format in
  let pp_kv ppf key (data : AstL.Lia.term) =
    fprintf ppf "@[%s -> @[%a@];@]@ " key AstL.pp_term_smtlib2 data
  in
  fun ppf e ->
    if title = ""
    then (
      fprintf ppf "@[<hov> ";
      SM.iteri e.env ~f:(fun ~key ~data -> pp_kv ppf key data);
      List.iter
        (function
          | KV (Var key, data) -> pp_kv ppf key data)
        e.cstrts;
      fprintf ppf "@]")
    else (
      fprintf ppf "@[<v 6>@[%s@]@," title;
      SM.iteri e.env ~f:(fun ~key ~data -> pp_kv ppf key data);
      List.iter
        (function
          | KV (Var key, data) ->
            fprintf ppf "- %a" (fun ppf data -> pp_kv ppf key data) data)
        e.cstrts;
      fprintf ppf "@]")
[@@ocaml.warning "-32"]
;;

type term = AstL.Lia.term

let walk : t -> term -> term =
  fun e ->
  let fz = function
    | AstL.Lia.Atom (AstL.Var s) as orig ->
      (match SM.find_exn e.env s with
       | exception Not_found -> orig
       | t -> t)
    | t -> t
  in
  AstL.Lia.map_term fz
;;

let equal (env : t) (env' : t) =
  SM.equal AstL.Lia.equal env.env env'.env && env.cstrts = env'.cstrts
;;

exception Occurs

let rec occurs_var_exn =
  fun env v (term : AstL.Lia.term) ->
  let f () =
    let open AstL in
    function
    | Lia.Atom (Var v2) when String.equal v v2 -> raise Occurs
    | Lia.Atom (Var v2) ->
      (match SM.find env.env v2 with
       | None -> ()
       | Some t -> occurs_var_exn env v t)
    | Const _ -> ()
    | Lia.Add xs | Lia.Mul xs -> List.iter (occurs_var_exn env v) xs
    | x ->
      Format.kasprintf failwith "not implemented in occurs_var: %a" AstL.pp_term_smtlib2 x
  in
  AstL.Lia.fold_term f () term
;;

let occurs_var env v term =
  try
    occurs_var_exn env v term;
    false
  with
  | Occurs -> true
;;

let add_cstrt map (key : AstL.atom) (data : term) =
  { map with cstrts = KV (key, data) :: map.cstrts }
;;

let extend_cstrt_exn env ~key data =
  match key with
  | AstL.Var vname ->
    occurs_var_exn env vname data;
    add_cstrt env key data
;;

let extend_int_exn e vname data =
  match SM.find e.env vname with
  | Some old_data ->
    Format.eprintf "old value = %a\n" AstL.pp_term_smtlib2 old_data;
    Format.eprintf "new value = %a\n" AstL.pp_term_smtlib2 data;
    failwith (Format.sprintf "key %s aready exists." vname)
  | None ->
    let data = walk e data in
    if occurs_var e vname data then raise Occurs;
    (*match data with
    | Ast.Lia.Iofs _ | Len _ | Len2 _ -> add_cstrt e (Ast.Var (vname, I)) data
    | _ -> *)
    { e with env = SM.add_exn e.env ~key:vname ~data }
;;

let set_int_exn e vname data =
  match SM.find e.env vname with
  | Some old_data -> { e with env = SM.add_exn (SM.remove vname e.env) ~key:vname ~data }
  | None ->
    let data = walk e data in
    if occurs_var e vname data then raise Occurs;
    { e with env = SM.add_exn e.env ~key:vname ~data }
;;

let extend_exn =
  fun e (key : AstL.atom) (data : term) ->
  match key, data with
  | AstL.Var vname, data ->
    let data : term = data in
    extend_int_exn e vname data
;;

let empty : t = { env = SM.empty; cstrts = [] }

[@@@ocaml.warnerror "-32"]

(* let is_empty { env } = SM.is_empty env *)
let length { env; cstrts } = SM.cardinal env + List.length cstrts [@@warning "-32"]

let definite_length { env; cstrts } =
  let env =
    SM.filter
      (fun _ -> function
         | AstL.Lia.Const _ -> true
         | _ -> false)
      env
  in
  SM.cardinal env + List.length cstrts
[@@warning "-32"]
;;

let is_absent_key k e = not (SM.mem e.env k)

let merge =
  fun ~f e1 e2 ->
  let merge2 f key v1 v2 =
    match v1, v2 with
    | None, None -> None
    | Some v1, Some v2 ->
      if Stdlib.(v1 = v2) then Some v1 else Some (f ~key ~data1:v1 ~data2:v2)
    | Some v, _ | _, Some v -> Some v
  in
  let env = SM.merge (merge2 f) e1.env e2.env in
  let cstrts = e1.cstrts @ e2.cstrts in
  { env; cstrts }
;;

let merge_exn =
  merge ~f:(fun ~key ~data1:v1 ~data2:v2 ->
    failwith
      (Format.asprintf
         "Attempt to subtitute varible %s by two different terms: %a and %a"
         key
         AstL.Lia.pp_term
         v1
         AstL.Lia.pp_term
         v2))
;;

let to_eqs =
  fun { env; cstrts } ->
  let open AstL.Lia in
  let mk_eq v rhs = AstL.Lia (Eq (Atom (Var v), rhs)) in
  cstrts
  |> List.map (function KV (AstL.Var v, rhs) -> mk_eq v rhs)
  |> SM.fold (fun key data acc -> mk_eq key data :: acc) env
;;

let lookup_int name { env; _ } = SM.find_opt name env
let lookup_int_exn name { env; _ } = SM.find_exn env name

type relop =
  | Leq
  | Eq

module type SYM = sig
  type term
  type ph

  include FT_SIG.z_lin_term with type term := term
  include FT_SIG.z_ph with type ph := ph and type term := term

  val exists : AstL.atom list -> ph -> ph
end

module Id_symantics : SYM with type term = AstL.Lia.term and type ph = AstL.t = struct
  type term = AstL.Lia.term
  type ph = AstL.t

  open AstL.Lia

  let mod_ = mod_
  let mul = mul
  let add = add
  let land_ xs = AstL.land_ xs
  let lor_ xs = AstL.lor_ xs
  let not = AstL.lnot
  let pred s = AstL.Pred s
  let constz s = Const s
  let var s = Atom (Var s)
  let exists atoms ph = AstL.exists atoms ph
  let eqz l r = AstL.Lia (AstL.Lia.eq l r)
  let neqz l r = AstL.Lia (AstL.Lia.neq l r)
  let leq l r = AstL.Lia (AstL.Lia.leq l r)
  let lt l r = AstL.Lia (AstL.Lia.lt l r)
  let true_ = AstL.true_
  let false_ = AstL.false_
end

let apply_term_symantics (type a) (module S : SYM with type term = a) =
  let rec helperT : AstL.Lia.term -> a = function
    | AstL.Lia.Const n -> S.constz n
    | Atom (AstL.Var s) -> S.var s
    | Add terms -> S.add (List.map helperT terms)
    | Mul terms -> S.mul (List.map helperT terms)
    | Mod (t, z) -> S.mod_ (helperT t) z
  in
  fun x -> helperT x
;;

let apply_symantics (type a) (module S : SYM with type ph = a) =
  let helperT = apply_term_symantics (module S) in
  let rec helper = function
    | AstL.Land xs -> S.land_ (List.map helper xs)
    | Lor xs -> S.lor_ (List.map helper xs)
    | Lnot x -> S.not (helper x)
    | True -> S.true_
    | Lia e -> helper_lia e
    | Pred s -> S.pred s
    | Exists (vs, ph) -> S.exists vs (helper ph)
  and helper_lia lia =
    match lia with
    | Eq (l, r) -> S.(eqz (helperT l) (helperT r))
    | Neq (l, r) -> S.(neqz (helperT l) (helperT r))
    | Leq (l, r) -> S.(leq (helperT l) (helperT r))
  in
  helper
;;

let make_main_symantics env =
  let module Set = Base.Set.Poly in
  let module Main_symantics_ = struct
    open AstL
    include Id_symantics

    let compare_term = Lia.compare_term
    let constz c = Lia.Const c

    let var s : term =
      match lookup_int s env with
      | None -> Lia.Atom (AstL.Var s)
      | Some c -> c
    ;;

    let collect_inside_mul xs =
      List.fold_right
        (fun x acc : term list ->
           match x, acc with
           | Lia.Mul ys, _ -> ys @ acc
           | e, Lia.Add ss :: tl | Add ss, e :: tl ->
             Add (List.map (fun x -> Lia.Mul [ x; e ]) ss) :: tl
           | x, _ -> x :: acc)
        xs
        []
    ;;

    let mul xs =
      let fold_and_sort init op xs =
        let c, xs =
          List.fold_left
            (fun (cacc, phacc) -> function
               | Lia.(Const c) -> op c cacc, phacc
               | ph -> cacc, ph :: phacc)
            (init, [])
            xs
        in
        c, List.sort compare_term xs
      in
      match fold_and_sort Z.one Z.( * ) (collect_inside_mul xs) with
      | c, _ when Z.(equal c zero) -> constz Z.zero
      | c, [] -> Lia.Const c
      | c, [ h ] when Z.equal c Z.one -> h
      | c, xs when Z.equal c Z.one -> mul (List.sort compare_term xs)
      | c, [ Add ss ] -> Add (List.map (fun x -> mul [ constz c; x ]) ss)
      | c, xs -> mul (constz c :: List.sort compare_term xs)
    ;;

    let add xs =
      let collect_inside_add xs =
        let extend h tl =
          let rec loop c1 tl1 = function
            | ph :: ptl when ph = Lia.Mul tl1 ->
              if Z.(equal c1 minus_one)
              then ptl
              else mul (constz Z.(one + c1) :: tl1) :: ptl
            | Lia.Mul (Const c2 :: tl2) :: ptl when Stdlib.(tl1 = tl2) ->
              if Z.(c1 + c2 = zero) then ptl else mul (constz Z.(c1 + c2) :: tl1) :: ptl
            | ph :: ptl -> ph :: loop c1 tl1 ptl
            | [] -> [ h ]
          in
          match h with
          | Mul (Const c1 :: tl1) -> loop c1 tl1 tl
          | Mul tl1 -> loop Z.one tl1 tl
          | _ -> h :: tl
        in
        List.fold_right
          (fun x acc ->
             match x, acc with
             | Lia.Add ts, _ -> ts @ acc
             | Mul (Const c1 :: ph1), Lia.Mul (Const c2 :: ph2) :: tl
               when List.equal Lia.eq_term ph1 ph2 ->
               if Z.(c1 + c2 = zero) then tl else mul (constz Z.(c1 + c2) :: ph1) :: tl
             | Mul [ Const c1; ph1 ], ph2 :: tl when Lia.eq_term ph1 ph2 ->
               extend (mul [ constz Z.(of_int 1 + c1); ph1 ]) tl
             | a, _ -> extend a acc)
          xs
          []
      in
      let fold_and_sort init op xs =
        let c, xs =
          List.fold_left
            (fun (cacc, phacc) -> function
               | Lia.Const c -> op c cacc, phacc
               | ph -> cacc, ph :: phacc)
            (init, [])
            xs
        in
        c, List.sort compare_term xs
      in
      let fold_coeff c1 c2 term acc =
        if c1 = Z.(minus_one * c2)
        then acc
        else Lia.Mul [ Const Z.(c1 + c2); term ] :: acc
      in
      let rec fold_add = function
        | t1 :: t2 :: tl when Lia.equal t1 t2 ->
          fold_add (mul [ constz Z.(of_int 2); t1 ] :: tl)
        | Lia.Mul [ Const c1; t1 ] :: t2 :: tl when Lia.equal t1 t2 ->
          fold_add (fold_coeff c1 Z.one t1 tl)
        | t1 :: Mul [ Const c2; t2 ] :: tl when Lia.equal t1 t2 ->
          fold_add (fold_coeff Z.one c2 t1 tl)
        | Mul [ Const c1; t1 ] :: Mul [ Const c2; t2 ] :: tl when Lia.equal t1 t2 ->
          fold_add (fold_coeff c1 c2 t1 tl)
        | t1 :: xs -> t1 :: fold_add xs
        | one_atom -> one_atom
      in
      match fold_and_sort Z.zero Z.( + ) (collect_inside_add xs) with
      | c, [] -> constz c
      | c, terms when Z.(c = zero) -> add (fold_add terms)
      | c, [ term ] when Z.(c = zero) -> term
      | c, terms -> add (constz c :: fold_add terms)
    ;;

    let rec negate = function
      | Lia.Add xs -> add (List.map negate xs)
      | x -> mul [ constz Z.minus_one; x ]
    ;;

    (** Formulas *)
    let exists var ph = AstL.exists var ph

    let true_ = AstL.true_
    let false_ = AstL.false_

    let rec not = function
      | AstL.Lia (Leq (lhs, rhs)) -> lia (AstL.Lia.gt lhs rhs)
      | Lia (Eq (lhs, rhs)) -> Id_symantics.neqz lhs rhs
      | Lnot x -> x
      | Land xs -> lor_ (List.map not xs)
      | Lor xs -> land_ (List.map not xs)
      | x -> lnot x
    ;;

    let land_ xs =
      let flat =
        List.concat_map
          (function
            | AstL.Land xs -> xs
            | x -> [ x ])
          xs
      in
      let compare_ast l r =
        match l, r with
        | AstL.True, AstL.True -> 0
        | True, _ -> -1
        | _, True -> 1
        | Lnot _, _ -> -1
        | _, Lnot _ -> 1
        | _ -> AstL.compare l r
      in
      let flat = Base.List.dedup_and_sort ~compare:compare_ast flat in
      match flat with
      | [] -> Id_symantics.false_
      | Lnot True :: _ -> Id_symantics.false_
      | [ h ] -> h
      | _ ->
        (match List.drop_while (( = ) AstL.True) flat with
         | [] -> AstL.true_
         | xs -> AstL.land_ xs)
    ;;

    let lor_ xs =
      let flat =
        List.concat_map
          (function
            | AstL.Lor xs -> xs
            | x -> [ x ])
          xs
      in
      let compare_ast l r =
        match l, r with
        | AstL.True, AstL.True -> 0
        | True, _ -> -1
        | _, True -> 1
        | Lnot _, _ -> -1
        | _, Lnot _ -> 1
        | _ -> AstL.compare l r
      in
      let flat = Base.List.dedup_and_sort ~compare:compare_ast flat in
      match flat with
      | [] -> Id_symantics.true_
      | [ h ] -> h
      | True :: _ -> Id_symantics.true_
      | xs -> AstL.lor_ xs
    ;;

    let relop op l r =
      let ofop =
        match op with
        | Leq -> fun x y -> Lia (Lia.leq x y)
        | Eq -> fun x y -> Lia (Lia.eq x y)
      in
      match l, r with
      | Lia.(Const l), Lia.(Const r) ->
        (match op with
         | Eq when Z.equal l r -> AstL.true_
         | Eq -> AstL.false_
         | Leq when l <= r -> AstL.true_
         | Leq -> AstL.false_)
      | Lia.(Add (Atom (Var v1) :: Mul [ Const c; Atom (Var v2) ] :: tl)), rhs
        when String.equal v1 v2 && c = Z.minus_one -> ofop (add tl) rhs
      | Lia.Add ls, Lia.Add rs -> ofop (add (ls @ List.map negate rs)) (constz Z.zero)
      | Add (Const c :: tl), Const n -> ofop (add tl) (constz Z.(n - c))
      | Const c, Add (Const n :: tl) -> ofop (add (List.map negate tl)) (constz Z.(n - c))
      | Const c, Add xs -> ofop (add (List.map negate xs)) (constz Z.(-c))
      | _ -> ofop l r
    ;;

    let cancel_left op lhs rhs =
      let open AstL.Lia in
      let simplify divisor =
        let divide_by d = function
          | Mul (Const lc :: ltl) -> Mul (Const Z.(lc / d) :: ltl)
          | Const lc -> Const Z.(lc / d)
          | lt when Z.(d = one) -> lt
          | other -> failwith "Unexpected divison in linear term"
        in
        function
        | [] -> constz Z.zero
        | [ atom ] -> divide_by divisor atom
        | atoms -> Add (List.map (divide_by divisor) atoms)
      in
      let gcd atoms =
        let rec gcd acc = function
          | Mul (Const lc :: ltl) :: other -> Z.gcd lc (gcd acc other)
          | Const lc :: other -> Z.gcd lc (gcd acc other)
          | _ :: other -> Z.one
          | [] -> acc
        in
        gcd Z.zero atoms
      in
      let lhs' = List.filter (fun x -> Bool.not (List.mem x rhs)) lhs in
      let rhs' = List.filter (fun x -> Bool.not (List.mem x lhs)) rhs in
      let gcd_l, gcd_r = gcd lhs', gcd rhs' in
      match lhs', rhs' with
      | [ Const c ], _ when Z.(c mod gcd_r <> zero) -> false_
      | _, [ Const c ] when Z.(c mod gcd_l <> zero) -> false_
      | _ ->
        let d = Z.gcd gcd_l gcd_r in
        op (simplify d lhs') (simplify d rhs')
    ;;

    let lt l r = relop Leq (add [ constz Z.one; l ]) r

    let leq l r =
      let open AstL.Lia in
      match l, r with
      | Add lhs, Add rhs -> cancel_left (relop Leq) lhs rhs
      | lhs, Add rhs -> cancel_left (relop Leq) [ lhs ] rhs
      | Add lhs, rhs -> cancel_left (relop Leq) lhs [ rhs ]
      | _ -> relop Leq l r
    ;;

    let eqz l r =
      let open AstL.Lia in
      match l, r with
      | l, r when eq_term l r -> true_
      | Add lhs, Add rhs -> cancel_left (relop Eq) lhs rhs
      | lhs, Add rhs -> cancel_left (relop Eq) [ lhs ] rhs
      | Add lhs, rhs -> cancel_left (relop Eq) lhs [ rhs ]
      | Mul (Const lc :: ltl), Mul (Const rc :: rtl) ->
        let gcd1 = Z.gcd lc rc in
        if Z.(equal gcd1 one)
        then relop Eq l r
        else
          relop Eq (mul (constz Z.(lc / gcd1) :: ltl)) (mul (constz Z.(rc / gcd1) :: rtl))
      | _ -> relop Eq l r
    ;;

    let neqz l r =
      match l, r with
      | AstL.Lia.Const l, AstL.Lia.Const r -> if l <> r then AstL.true_ else AstL.false_
      | eiat1, eiat2 when AstL.Lia.eq_term eiat1 eiat2 -> AstL.false_
      | _ -> Id_symantics.neqz l r
    ;;
  end
  in
  let module Main_symantics = struct
    include Main_symantics_
  end
  in
  (module Main_symantics : SYM with type ph = AstL.t and type term = AstL.Lia.term)
;;

let eq_propagation =
  let open AstL in
  let fold_and_filter f acc xs =
    let acc = ref acc in
    let changed = ref false in
    let xs =
      List.filter_map
        (fun h ->
           match f !acc h with
           | Some acc2 ->
             if acc2 <> !acc then changed := true;
             acc := acc2;
             None
           | None -> Some h)
        xs
    in
    !acc, xs
  in
  let helper orig_ast env ast =
    let module Set = Base.Set.Poly in
    let var_can_subst v = is_absent_key v env in
    match ast with
    (* **************************** integer stuff *********************************** *)
    | Lia (Eq ((Atom (Var vn1 as v1) as lhs), (Atom (Var vn2 as v2) as rhs))) ->
      (match var_can_subst vn1, var_can_subst vn2 with
       | true, other ->
         if occurs_var env vn1 rhs then None else Some (extend_exn env v1 rhs)
       | false, true ->
         if occurs_var env vn2 lhs then None else Some (extend_exn env v2 lhs)
       | false, false -> None)
    | Lia (Eq (Atom (Var vn as v1), (Const c as rhs)))
    | Lia (Eq ((Const c as rhs), Atom (Var vn as v1)))
      when var_can_subst vn ->
      (* (= v c) *)
      Some (extend_exn env v1 rhs)
    | Lia (Eq (Mul [ Const _; Atom (Var vn as v) ], (Const z as rhs)))
    | Lia (Eq ((Const z as rhs), Mul [ Const _; Atom (Var vn as v) ]))
      when Z.(equal z zero) && var_can_subst vn ->
      (* (= ( * c v) 0) *)
      Some (extend_exn env v rhs)
    | Lia (Eq (Mul [ Const cl; Atom (Var vn as v) ], Const cr))
    | Lia (Eq (Const cr, Mul [ Const cl; Atom (Var vn as v) ]))
      when Z.(cr mod cl = zero) && var_can_subst vn ->
      let rhs = Lia.(Const Z.(cr / cl)) in
      Some (extend_exn env v rhs)
    | Lia (Eq (Atom (Var vn as vr), Mul [ Const cl; Atom (Var vn2) ]))
    | Lia (Eq (Mul [ Const cl; Atom (Var vn) ], Atom (Var vn2 as vr)))
      when vn == vn2 && var_can_subst vn ->
      (* (= ( * c v) vr) *)
      Some (extend_exn env vr (Const Z.zero))
    | Lia (Eq (Mul [ Const cl; Atom (Var vn as vr) ], Mul [ Const cl2; Atom (Var vn2) ]))
      when vn == vn2 && cl <> cl2 && var_can_subst vn ->
      Some (extend_exn env vr (Const Z.zero))
    | Lia
        (Eq
           ( Add [ Atom (Var v1n as v1); Mul [ Const c; (Atom (Var v2n) as v2) ] ]
           , Const z0 ))
    | Lia
        (Eq
           ( Const z0
           , Add [ Atom (Var v1n as v1); Mul [ Const c; (Atom (Var v2n) as v2) ] ] ))
      when Z.(equal z0 zero) && var_can_subst v1n ->
      (* (= (+ v1 c*v2)) 0) *)
      if occurs_var env v1n v2
      then None
      else (
        let new_rhs =
          if Z.(equal c minus_one) then v2 else Lia.Mul [ Const Z.(-c); v2 ]
        in
        Some (extend_exn env v1 new_rhs))
    | _ -> None
  in
  fun env ast ->
    match ast with
    | Land xs ->
      let env', ys = fold_and_filter (helper ast) env xs in
      let ans_ph = if ys = [] && xs <> [] then True else AstL.land_ ys in
      env', ans_ph
    | Lia _ ->
      (match helper ast env ast with
       | Some e -> e, AstL.True
       | None -> env, ast)
    | ph -> env, ph
;;

let next = function
  | [] -> failwith "Bad argument: next_step"
  | h :: tl -> (1 + h) :: tl
;;

let pp_step fmt step =
  Format.pp_print_list
    ~pp_sep:(fun ppf () -> Format.fprintf ppf ".")
    Format.pp_print_int
    fmt
    (List.rev step)
;;

let basic_simplify step ?multiple env ast =
  (* AM: here I have removed another trace logger *)
  trace_log "iter(%a)= @[%a@]" pp_step step AstL.pp_smtlib2 ast;
  let rec loop step env ast =
    let (module Symantics) = make_main_symantics env in
    let ast2 = apply_symantics (module Symantics) ast in
    let env2, ast2 = eq_propagation env ast2 in
    let __ _ = trace_log "env2 = %a" (pp ~title:"") env2 in
    let __ () = trace_log "ast2 = @[%a@]" AstL.pp_smtlib2 ast2 in
    let next_step = next step in
    match length env2 > length env, AstL.equal ast ast2 with
    | true, equal ->
      let () = trace_log "%a" (pp ~title:"Something ready to substitute") env2 in
      let __ () = trace_log "ast2 = @[%a@]" AstL.pp_smtlib2 ast2 in
      if not equal
      then trace_log "iter(%a)= @[%a@]" pp_step next_step AstL.pp_smtlib2 ast2;
      loop next_step (merge_exn env2 env) ast2
    | false, false ->
      trace_log "iter(%a)= @[%a@]" pp_step next_step AstL.pp_smtlib2 ast2;
      loop next_step env ast2
    | false, true ->
      trace_log "fixed-point";
      ast2, env2
  in
  loop step env ast
;;

let simplify_lia ast =
  ast
  |> basic_simplify [ 0 ] empty
  |> fun (ph, env) ->
  match ph, to_eqs env with
  | ph, [] -> ph
  | ph, eqs when AstL.equal ph AstL.true_ -> AstL.land_ eqs
  | ph, sqs -> AstL.land_ (ph :: to_eqs env)
;;

module type Smtml_symantics = sig
  include FT_SIG.z_lin_term with type term := Smtml.Expr.t
  include FT_SIG.z_ph with type ph := Smtml.Expr.t and type term = Smtml.Expr.t
  include FT_SIG.s_extra with type ph := Smtml.Expr.t and type term = Smtml.Expr.t

  val exists : string list -> Smtml.Expr.t -> Smtml.Expr.t
end

module SMT : Smtml_symantics = struct
  include FT_SIG.To_smtml_symantics

  let exists vs ph =
    Smtml.Expr.exists
      (List.map (fun s -> Smtml.Expr.symbol (Smtml.Symbol.make Ty_int s)) vs)
      ph
  ;;
end

let apply_term_symnatics (module S : Smtml_symantics) =
  let rec helperT = function
    | AstL.Lia.Const n -> S.constz n
    | Atom (AstL.Var s) -> S.var s
    | Add terms -> S.add (List.map helperT terms)
    | Mul terms -> S.mul (List.map helperT terms)
    | Mod (t, z) -> S.mod_ (helperT t) z
  in
  fun x -> helperT x
;;

let apply_symnatics (module S : Smtml_symantics) =
  let rec helper = function
    | AstL.True -> S.true_
    | Lnot x -> S.not (helper x)
    | Land xs -> S.land_ (List.map helper xs)
    | Lor xs -> S.lor_ (List.map helper xs)
    | Lia e -> helper_lia e
    | Pred s -> S.pred s
    | Exists (vs, ph) ->
      let vs =
        List.filter_map
          (function
            | AstL.Var s -> Some s)
          vs
      in
      S.exists vs (helper ph)
  and helper_lia ph =
    match ph with
    | Leq (l, r) -> S.(helperT l <= helperT r)
    | Eq (l, r) -> S.(helperT l = helperT r)
    | Neq (l, r) -> S.(helperT l <> helperT r)
  and helperT = apply_term_symnatics (module S : Smtml_symantics) in
  fun x -> helper x
;;

let deparametrize ast =
  let open AstL in
  let base_eq = Lia (Eq (get_par 0, Lia.const (Z.of_int _base))) in
  let digits_neq =
    let open Lia in
    ast
    |> AstL.get_vars
    |> List.map (fun var ->
      land_
        [ Lia (leq (const Z.zero) (atom (int_var var)))
        ; Lia (leq (atom (int_var var)) (const (Z.of_int (_base - 1))))
        ])
    |> land_
  in
  land_ [ base_eq; digits_neq; ast ]
;;

let check_sat ?(base = Config.config.enc_base) ast =
  let open AstL in
  match ast |> deparametrize |> basic_simplify [ 0 ] empty |> fst with
  | ph when AstL.equal ph true_ -> `Sat
  | ph when AstL.equal ph false_ -> `Unsat
  | ph ->
    let ph = apply_symnatics (module SMT) ph in
    Debug.trace "Z3" "Checking satisfiability with Z3";
    Z3.check _z3_solver ~assumptions:[ ph ] 
    (*AM: if I understand smtml correctly, in this way we are populating 
      the state of the solver with additional lemmas, while only adding ph 
      temporarily. My hope is that we will check often similar formulas *)
;;

let flag () = Sys.getenv_opt "CHRO_DEBUG" |> Option.is_some

let debug_printf ppf =
  if flag ()
  then Format.kasprintf (Format.printf "%s%!") ppf
  else Format.ifprintf Format.std_formatter ppf
;;

let debug_printfln ppf =
  if flag ()
  then Format.kasprintf (Format.printf "%s%!\n") ppf
  else Format.ifprintf Format.std_formatter ppf
;;

let get_state_exn name =
  name |> Base.String.chop_prefix_exn ~prefix:"P" |> Base.Int.of_string
;;

let pred_name state = "P" ^ Int.to_string state
let get_predi n i = AstL.Pred (Format.asprintf "P_%d_%d" n i)

let pred_name2 states =
  List.fold_left (fun acc i -> acc ^ "_" ^ Int.to_string i) "PP" states
;;

let get_states_z3 ph get_state =
  let open AstL in
  let open Lia in
  (* debug_printfln "Composed ast: %a" AstL.pp_smtlib2 ph; *)
  let ph = apply_symnatics (module SMT) ph in
  Z3.push _z3_solver;
  Debug.trace "Z3" "Getting a solution with Z3";
  let result =
    match Z3.check _z3_solver ~assumptions:[ ph ] with
    | `Sat ->
      (match Z3.model _z3_solver with
       | None -> assert false
       | Some m ->
         let digits =
           Hashtbl.fold
             (fun k v acc ->
                let _ : Smtml.Symbol.t = k in
                match k.name, v with
                | Smtml.Symbol.Simple s, Smtml.Value.Int n
                  when String.starts_with ~prefix:"lia" s ->
                  (* debug_printfln "var%d = %d;" (get_val s) n; *)
                  Lia (Lia.eq (atom (int_var s)) (const (Z.of_int n))) :: acc
                | _ -> acc)
             (Smtml.Z3_mappings.values_of_model m)
             []
         in
         Hashtbl.fold
           (fun k v acc ->
              let _ : Smtml.Symbol.t = k in
              match k.name, v with
              | Smtml.Symbol.Simple s, Smtml.Value.True when Option.is_some (get_state s)
                ->
                (* debug_printfln "State: %s is taken" s; *)
                (land_ digits, Option.get (get_state s)) :: acc
              | Smtml.Symbol.Simple s, Smtml.Value.False -> acc
              | _ -> acc)
           (Smtml.Z3_mappings.values_of_model m)
           [])
    | `Unsat -> []
    | _ -> failwith "Unknown in Z3"
  in
  Z3.pop _z3_solver 1;
  result
;;

let get_states extra asts =
  let open AstL in
  let get_state name =
    match name |> Base.String.chop_prefix ~prefix:"P" with
    | Some s -> Some (Base.Int.of_string s)
    | None -> None
  in
  (* let get_val name =
    name |> Base.String.chop_prefix_exn ~prefix:"lia" |> Base.Int.of_string
  in *)
  let ph =
    match asts with
    | [] -> raise Exit
    | [ (ph, state) ] ->
      land_ [ deparametrize (land_ [ ph; extra ]); pred (pred_name state) ]
    | phs ->
      deparametrize
        (land_
           [ extra
           ; lor_ (List.map (fun (ph, state) -> land_ [ ph; pred (pred_name state) ]) phs)
           ])
  in
  get_states_z3 ph get_state
;;

(* The function takes on input 
1) [base]: an integer;
2) [extra]: LIA formulas for the terms on the edges, e.g., t1=2x+3y-1; other constraints restricting 
the Boolean variables that correspond to states
3) [asts]: a list of transitions, pairs (ph, states), where states is a list of ints, 
i.e., states of the nfas in the Boolean combination *)
let get_states_bool_comb extra asts =
  let open AstL in
  (* The map [bool_map] is used to retreive the list of states from a Z3 result; 
  there is one Boolean variable for each next state = (list of states of nfas for atomic constraints) *)
  let bool_map = ref Map.empty in
  let get_state name =
    match Map.find !bool_map name with
    | Some states -> Some states
    | None -> None
  in
  let state_pred states = List.mapi (fun i state -> get_predi i state) states |> land_ in
  List.iter
    (fun (_, states) ->
       bool_map := Map.add_exn !bool_map ~key:(pred_name2 states) ~data:states)
    asts;
  let ph =
    match asts with
    | [] -> raise Exit
    | [ (ph, states) ] ->
      land_
        [ deparametrize (land_ [ ph; extra ])
        ; state_pred states (*Here we add propositional variables for each state *)
        ; Pred (pred_name2 states)
          (*And one propositional variables to understand which 
        "state as list" was chosen *)
        ]
    | phs ->
      deparametrize
        (land_
           [ extra
           ; lor_
               (List.map
                  (fun (ph, states) ->
                     land_ [ ph; state_pred states; Pred (pred_name2 states) ])
                  phs)
           ])
  in
  (* Uncomment the line below to see the formula that goes to Z3 *)
  (* debug_printfln "Ph to Z3: %a" AstL.pp_smtlib2 ph; *)
  get_states_z3 ph get_state
;;
