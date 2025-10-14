let log = Utils.log

let find_vars_for_under2 ~base:b ast =
  let module S = Base.Set.Poly in
  Ast.fold
    (fun acc ->
       let open Ast.Eia in
       function
       | Ast.Eia (Ast.Eia.Eq (l, r)) | Eia (Ast.Eia.Leq (l, r)) ->
         let f =
           fun acc -> function
             | Ast.Eia.Mul [ Atom (Var v); Pow (Atom (Const base), Atom (Var _)) ]
               when Z.(equal (of_int b) base) -> S.add acc v
             | Mul [ Atom (Const _); Atom (Var v); Pow (Atom (Const base), Atom (Var _)) ]
               when Z.(equal (of_int b) base) -> S.add acc v
             | Mul [ Atom (Var v); Pow (Atom (Const base), Atom (Var _)) ]
               when Z.(equal (of_int b) base) -> S.add acc v
             | Mul [ Atom (Var v1); Atom (Var v2) ] -> S.add (S.add acc v1) v2
             | _ -> acc
         in
         Ast.Eia.fold_term f (Ast.Eia.fold_term f acc r) l
       | _ -> acc)
    S.empty
    ast
;;

module type SYM = sig
  include FT_SIG.s_term with type term := Q.t * Ast.Eia.term

  include
    FT_SIG.s_ph
    with type term := Q.t * Ast.Eia.term
     and type ph = Ast.t
     and type str = Ast.Str.term

  val exists : string list -> ph -> ph
end

module Sy = struct
  type term = Q.t * Ast.Eia.term

  let mod_ : term -> Z.t -> term = fun (c, t) z -> Q.(c / ~$$z), t

  let pow base exp =
    if Q.(equal one (fst base)) && Q.(equal one (fst exp))
    then Q.one, Ast.Eia.pow (snd base) (snd exp)
    else assert false
  ;;

  let constz n = Q.one, Ast.Eia.Atom (Const n)
  let const n = constz (Z.of_int n)
  let var s = Q.one, Ast.Eia.Atom (Var s)
  let bw _ _ _ = failwith "TBD"

  let mul xs =
    let c, rhs = List.fold_left_map (fun acc (c, ast) -> Q.(acc * c), ast) Q.one xs in
    c, Ast.Eia.mul rhs
  ;;

  let add : term list -> term = function
    | [] -> assert false
    | h :: tl ->
      let lcm1 =
        List.fold_left (fun acc (x, _) -> Z.lcm acc (Q.den x)) (Q.den (fst h)) tl
      in
      let ss =
        (List.map (fun (q, s) ->
           Ast.Eia.Mul [ Ast.Eia.Atom (Const Z.(Q.num q * lcm1 / Q.den q)); s ]))
          (h :: tl)
      in
      Q.make Z.one lcm1, Ast.Eia.Add ss
  ;;

  type ph = Ast.t

  let false_ = Ast.false_
  let true_ = Ast.true_
  let not x = Ast.Lnot x
  let land_ = Ast.land_
  let lor_ = Ast.lor_
  let exists var ph = Ast.Exists (List.map Ast.var var, ph)

  type str = Ast.Str.term

  let in_re l regex =
    let _ : str = l in
    Ast.Str (Ast.Str.InRe (l, regex))
  ;;

  let eq (cl, tl) (cr, tr) : ph =
    let lcm1 = Z.lcm (Q.den cl) (Q.den cr) in
    Ast.eia
    @@ Ast.Eia.eq
         (Ast.Eia.Mul [ Ast.Eia.Atom (Const Z.(Q.num cl * lcm1)); tl ])
         (Ast.Eia.Mul [ Ast.Eia.Atom (Const Z.(Q.num cr * lcm1)); tr ])
  ;;

  let leq (cl, tl) (cr, tr) : ph =
    let lcm1 = Z.lcm (Q.den cl) (Q.den cr) in
    Ast.eia
    @@ Ast.Eia.leq
         (Ast.Eia.Mul [ Ast.Eia.Atom (Const Z.(Q.num cl * lcm1)); tl ])
         (Ast.Eia.Mul [ Ast.Eia.Atom (Const Z.(Q.num cr * lcm1)); tr ])
  ;;

  let lt (cl, tl) (cr, tr) : ph =
    let lcm1 = Z.lcm (Q.den cl) (Q.den cr) in
    Ast.eia
    @@ Ast.Eia.lt
         (Ast.Eia.Mul [ Ast.Eia.Atom (Const Z.(Q.num cl * lcm1)); tl ])
         (Ast.Eia.Mul [ Ast.Eia.Atom (Const Z.(Q.num cr * lcm1)); tr ])
  ;;

  let mulq : Q.t -> term -> term = fun q (c, t) -> Q.(q * c), t
end

module _ : SYM = Sy

let gensym =
  let n = ref (-1) in
  fun ?(prefix = "eee") () ->
    incr n;
    Printf.sprintf "%s%d" prefix !n
;;

module Env = struct
  include Map.Make (String)

  let extend_exn k v m = add k v m
end

let apply_symantics env (module S : SYM) =
  let rec helper = function
    | Ast.Land xs -> S.land_ (List.map helper xs)
    | Lor xs -> S.lor_ (List.map helper xs)
    | Lnot x -> S.not (helper x)
    | True -> S.true_
    | Eia e -> helper_eia e
    | Pred _ as x ->
      Format.eprintf "Unknown part of the ast: @[%a@]\n%!" Ast.pp_smtlib2 x;
      assert false
    | Exists (vs, ph) ->
      let vs =
        List.filter_map
          (function
            | Ast.Var s -> Some s
            | Ast.Const _ -> None)
          vs
      in
      S.exists vs (helper ph)
    | Str _ as t -> t
  (* | Str (Ast.Str.InRe (term, regex)) as t ->
      S.in_re (helper_str term) regex
    | Str (Ast.Str.Eq (term, term')) as t -> t
  let l = helper_str term in
      let r = helper_str term' in

      S.str_equal l r *)
  and _helper_str : Ast.Str.term -> S.str = Fun.id
  (* | Ast.Str.Const s as ans -> ans
    | Ast.Str.Atom (Ast.Var s) -> S.str_var s
    | Atom (Const _) -> failwith "should not happen"
    | FromEia (Var eia) -> S.str_from_eia eia
    | FromEia (Const c) -> S.str_from_eia_const c
    | Concat (s1, s2) -> S.str_concat (helper_str s1) (helper_str s2)
    | Substr (s1, Var a, Var b) -> S.str_substr (helper_str s1) a b
    | Substr (s1, _, _) -> failwith "unimplemented"
    | At (s1, Var a) -> S.str_at (helper_str s1) a
    | At (s1, _) -> failwith "unimplemented" *)
  and helperT = function
    | Ast.Eia.Atom (Ast.Const n) -> S.const (Z.to_int n)
    | Atom (Ast.Var s) ->
      (match Env.find s env with
       | exception Not_found -> S.var s
       | t -> t)
    | Add terms -> S.add (List.map helperT terms)
    | Mul terms -> S.mul (List.map helperT terms)
    (* | Pow (Atom (Ast.Const base), Atom (Ast.Var x)) when base = Config.base () ->
      S.pow2var x *)
    | Pow (base, p) -> S.pow (helperT base) (helperT p)
    | Bwand (l, r) -> S.bw FT_SIG.Bwand (helperT l) (helperT r)
    | Bwor (l, r) -> S.bw FT_SIG.Bwor (helperT l) (helperT r)
    | Bwxor (l, r) -> S.bw FT_SIG.Bwxor (helperT l) (helperT r)
    | Mod (t, z) -> S.mod_ (helperT t) z
    | Len (Ast.Str.Const s) -> S.const (String.length s)
    | Stoi (Ast.Str.Const s) -> failwith "TBD"
    | (Stoi (Ast.Str.Atom (Const _)) | Len (Ast.Str.Atom (Const _))) as t ->
      Format.eprintf "%a\n%!" Ast.Eia.pp_term t;
      failwith "Strlen/Stoi should not be called from int constants. Types are bad"
    | (Len _ | Stoi _ | Stoi2 (Var _) | Stoi2 (Const _) | Len2 (Var _) | Len2 (Const _))
      as term -> Q.one, term
  (* Format.eprintf "@[%a@]\n%!" Ast.pp_term_smtlib2 term;
      failwith (Format.asprintf "Unsupported case in %s" __FUNCTION__) *)
  and helper_eia eia =
    match eia with
    | Ast.Eia.Eq (l, r) -> S.eq (helperT l) (helperT r)
    | Leq (l, r) -> S.leq (helperT l) (helperT r)
  in
  fun x -> helper x
;;

let bitlen ~base b =
  assert (b >= 0);
  let rec loop acc b = if b > 0 then loop (acc + 1) (b / base) else acc in
  loop 0 b
;;

let%test _ = bitlen ~base:2 7 = 3

let try_under2_heuristics
      ~base:k
      ?(all_as = List.init (k - 1) (( + ) 1))
      ?(all_bs = List.init k Fun.id)
      ~fLat:l
      ast
  =
  let under2vars = find_vars_for_under2 ~base:k ast in
  log
    "vars_for_under2: %a\n%!"
    Format.(pp_print_list pp_print_string)
    (Base.Set.to_list under2vars);
  (* log "base = %d" k; *)
  (* log "There are %d as and %d bs" (List.length all_as) (List.length all_bs); *)
  let ( let* ) xs f = List.concat_map f xs in
  let envs =
    match l with
    | n when n < 0 -> failwith "bad config"
    | l ->
      Base.Set.Poly.fold
        ~f:(fun acc name ->
          let* acc, phs = acc in
          let* a = all_as in
          let* b = all_bs in
          let var_names = List.init (1 + l) (fun _ -> gensym ~prefix:"u" ()) in
          let sum =
            List.mapi
              (fun i u ->
                 if i mod 2 = 1
                 then Sy.(mul [ const (-1); pow (const k) (var u) ])
                 else Sy.(pow (const k) (var u)))
              var_names
          in
          let ans =
            Sy.(
              add
                [ Sy.mulq
                    (Q.make (Z.of_int a) Z.(of_int k - one))
                    (Sy.mul [ Sy.add sum; pow (const k) (const @@ bitlen ~base:k b) ])
                ; const b
                ])
          in
          let _, constraints =
            List.fold_right
              (fun v (oldv, acc) ->
                 let v = Sy.var v in
                 v, Sy.(leq oldv v) :: acc)
              var_names
              (Sy.const 0, [])
          in
          [ Env.extend_exn name ans acc, constraints @ phs ])
        ~init:[ Env.empty, [] ]
        under2vars
  in
  List.map (fun (e, phs) -> apply_symantics e (module Sy) (Sy.land_ (ast :: phs))) envs
;;
