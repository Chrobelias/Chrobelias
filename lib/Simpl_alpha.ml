type subst = (string, string, Base.String.comparator_witness) Base.Map.t

let rec walk s name =
  match Base.Map.find s name with
  | Some x -> walk s x
  | None -> name
;;

let unify subst l1 l2 =
  let l1 = walk subst l1 in
  let l2 = walk subst l2 in
  if String.equal l1 l2
  then Some subst
  else Some (Base.Map.add_exn subst ~key:l1 ~data:l2)
;;

let pp_subst : Format.formatter -> subst -> unit =
  fun ppf s ->
  Format.fprintf ppf "@[{| ";
  Base.Map.iteri s ~f:(fun ~key ~data -> Format.fprintf ppf "%s -> %s; " key data);
  Format.fprintf ppf "|}@]"
;;

let pp_poly : Format.formatter -> (Ir.atom, int) Ir.Map.t -> unit =
  fun ppf s ->
  Format.fprintf ppf "@[{| ";
  Base.Map.iteri s ~f:(fun ~key ~data ->
    Format.fprintf ppf "%a -> %d; " Ir.pp_atom key data);
  Format.fprintf ppf "|}@]"
[@@warnerror "-32"] [@@warning "-32"]
;;

open Ir

let alpha_compare =
  let exception Exit of int in
  let rec helper (subst : subst) (l, r) =
    match l, r with
    | Lnot l, Lnot r -> helper subst (l, r)
    | Rel (Eq, _, _), (Rel (Leq, _, _) | SEq _ | SReg _ | Itos _)
    | SLen _, (SEq _ | SReg _ | True | Reg _ | Itos _ | Lnot _ | Land _ | Lor _)
    | Rel (Eq, _, _), SLen (_, _)
    | Rel (Leq, _, _), (SLen (_, _) | Itos _)
    | SEq (_, _), Exists (_, _)
    | ( SEq (_, _)
      , ( True
        | Reg (_, _)
        | SReg (_, _)
        | SLen (_, _)
        | SEq (_, _)
        | Itos (_, _)
        | Stoi (_, _)
        | Lnot _ | Land _ | Lor _ ) )
    | (Rel (Leq, _, _) | SEq _), Rel (Eq, _, _)
    | (Exists _ | Stoi _ | Reg _ | SEq _), Rel _
    | Rel _, (Exists _ | Stoi _ | Reg _ | SEq _)
    | Rel _, SReg _
    | SReg _, Rel _
    | Lnot _, Rel _
    | Rel _, Lnot _
    | Land _, Lnot _
    | Land _, Rel _
    | Rel _, Land _
    | Lor _, Rel _
    | Rel _, Lor _
    | ( Stoi _
      , ( True
        | Reg (_, _)
        | SLen (_, _)
        | SEq (_, _)
        | SReg _ | Exists _
        | Itos (_, _)
        | Lnot _ | Land _ | Lor _ ) )
    | Lnot _, (SReg (_, _) | SLen (_, _) | SEq (_, _) | Stoi (_, _) | Itos _)
    | Lnot _, (True | Reg (_, _) | Land _ | Lor _ | Exists _)
    | ( Reg (_, _)
      , ( True
        | Exists (_, _)
        | SReg (_, _)
        | SLen (_, _)
        | SEq (_, _)
        | Stoi (_, _)
        | Itos (_, _)
        | Lnot _ | Land _ | Lor _ ) )
    | ( Exists _
      , ( SLen _ | True
        | Reg (_, _)
        | SReg (_, _)
        | SEq (_, _)
        | Stoi (_, _)
        | Itos (_, _)
        | Land _ | Lor _ ) )
    | SLen _, (Exists _ | Rel _ | Stoi _)
    | Rel (_, _, _), True
    | Exists _, Lnot _
    (* Multiple variables are postponed for later *)
    | Exists (_ :: _ :: _, _), _
    | _, Exists (_ :: _ :: _, _) -> Stdlib.compare l r
    | Exists ([ Var a ], l), Exists ([ Var b ], r) ->
      helper (Base.Map.add_exn subst ~key:a ~data:b) (l, r)
    | Rel (Eq, l, c1), Rel (Eq, r, c2) | Rel (Leq, l, c1), Rel (Leq, r, c2) ->
      let rez = Z.compare c1 c2 in
      if rez = 0 then helper_polyn subst l r else rez
    | Land xs, Land ys | Lor xs, Lor ys -> helper_lists subst (xs, ys)
    | Stoi (Var l1, Var r1), Stoi (Var l2, Var r2)
    | SLen (Var l1, Var r1), SLen (Var l2, Var r2) ->
      let l1 = walk subst l1 in
      let l2 = walk subst l2 in
      (match unify subst l1 l2 with
       | None -> String.compare l1 l2
       | Some subst ->
         let r1 = Base.Map.find subst r1 |> Option.value ~default:r1 in
         let r2 = Base.Map.find subst r2 |> Option.value ~default:r2 in
         (match unify subst r1 r2 with
          | None -> String.compare r1 r2
          | Some _ -> String.compare r1 r2))
    | Exists (Var _ :: [], _), Exists (Pow2 _ :: [], _)
    | Stoi (Var _, Var _), Stoi (Pow2 _, _)
    | Stoi (Var _, Var _), Stoi (Var _, Pow2 _)
    | SLen (Var _, Var _), SLen (Pow2 _, _)
    | SLen (Var _, Var _), SLen (Var _, Pow2 _) -> raise (Exit (-1))
    | Stoi (Pow2 _, _), Stoi (_, _)
    | Stoi (Var _, Pow2 _), Stoi (_, _)
    | SLen (Pow2 _, _), SLen (_, _)
    | SLen (Var _, Pow2 _), SLen (_, _) -> 1
    | Exists (Pow2 _ :: [], _), Exists (_ :: [], _) -> 1
    | Exists ([], _), Exists (_, _) | Exists (_, _), Exists ([], _) ->
      (* TODO(Kakadu): change representation c *)
      failwith "Should not happen"
    (* and helper_atom subst l r =  *)
    | l, r ->
      Format.eprintf "Not implemented comparison:\n\t%a\n\t%a\n%!" Ir.pp l Ir.pp r;
      assert false
  and helper_lists subst = function
    | h1 :: tl1, h2 :: tl2 ->
      let c = helper subst (h1, h2) in
      if c = 0 then helper_lists subst (tl1, tl2) else c
    | [], _ :: _ -> -1
    | _ :: _, [] -> 1
    | [], [] -> 0
  and helper_polyn subst l r =
    Debug.printfln "  subst = %a" pp_subst subst;
    let _ : (atom, Z.t) Map.t = l in
    let normalize subst m =
      let _ : (atom, Z.t) Map.t = m in
      Base.Map.fold subst ~init:m ~f:(fun ~key ~data acc ->
        match Map.find_exn acc (Var key) with
        | (exception Sexplib0.Sexp.Not_found_s _) | (exception Not_found) -> acc
        | v -> Map.remove acc (Var key) |> Map.add_exn ~key:(Var data) ~data:v)
    in
    let l = normalize subst l in
    let r = normalize subst r in
    let ans2 = Ir.Map.compare_direct Stdlib.compare l r in
    ans2
  in
  fun a b ->
    try
      let _ = helper (Base.Map.empty (module Base.String)) (a, b) in
      0
    with
    | Exit n -> n
;;

(* Debug.printfln "   ans = %d" ans; *)

let rec simplify : Ir.t -> Ir.t = function
  | True -> True
  | Exists (atoms, rhs) -> exists atoms (simplify rhs)
  | Lnot rhs -> lnot (simplify rhs)
  | Reg _ as x -> x
  | Rel _ as x -> x
  | Lor _ as x -> x
  | SReg _ as x -> x
  | SLen _ as x -> x
  | Stoi _ as x -> x
  | Itos _ as x -> x
  | SEq _ as x -> x
  | SPrefixOf _ as x -> x
  | Land xs ->
    (* We simplify only conjuncts because interesting test needs it.
      benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/heapsort.c.koat_2.smt2
    *)
    let xs = List.map simplify xs in
    Land (Base.List.dedup_and_sort ~compare:alpha_compare xs)
;;
