type subst = (string, string, Base.String.comparator_witness) Base.Map.t

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
  let rec helper (subst : subst) (l, r) =
    match l, r with
    | Lnot l, Lnot r -> helper subst (l, r)
    | Rel (Eq, _, _), Rel (Leq, _, _)
    | Rel (Leq, _, _), Rel (Eq, _, _)
    (* *)
    | Exists _, Rel _
    | Rel _, Exists _
    | Lnot _, Rel _
    | Rel _, Lnot _
    | Land _, Lnot _
    | Land _, Rel _
    | Rel _, Land _
    | Lor _, Rel _
    | Rel _, Lor _
    (* Multiple variables are postponed for later *)
    | Exists (_ :: _ :: _, _), _
    | _, Exists (_ :: _ :: _, _) -> Stdlib.compare l r
    | Exists ([ Var a ], l), Exists ([ Var b ], r) ->
      helper (Base.Map.add_exn subst ~key:a ~data:b) (l, r)
    | Rel (Eq, l, c1), Rel (Eq, r, c2) | Rel (Leq, l, c1), Rel (Leq, r, c2) ->
      let rez = Int.compare c1 c2 in
      if rez = 0 then helper_polyn subst l r else rez
    | Land xs, Land ys | Lor xs, Lor ys -> helper_lists subst (xs, ys)
    | l, r ->
      Format.eprintf "Not implemented:\n\t%a\n\t%a\n%!" Ir.pp l Ir.pp r;
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
    let _ : (atom, int) Map.t = l in
    let normalize subst m =
      let _ : (atom, int) Map.t = m in
      Base.Map.fold subst ~init:m ~f:(fun ~key ~data acc ->
        match Map.find_exn acc (Var key) with
        | (exception Sexplib0.Sexp.Not_found_s _) | (exception Not_found) -> acc
        | v -> Map.remove acc (Var key) |> Map.add_exn ~key:(Var data) ~data:v)
    in
    let l = normalize subst l in
    let r = normalize subst r in
    (* Debug.printfln "  norm_l = %a" pp_poly l;
    Debug.printfln "  norm_r = %a" pp_poly r; *)
    let ans2 = Ir.Map.compare_direct Stdlib.compare l r in
    (* Debug.printfln "   ans2 = %d" ans2; *)
    ans2
  in
  fun a b ->
    (* Debug.printfln "WTF: l = %a" Ir.pp a;
    Debug.printfln "     r = %a" Ir.pp b; *)
    let ans = helper (Base.Map.empty (module Base.String)) (a, b) in
    (* Debug.printfln "   ans = %d" ans; *)
    ans
;;

let rec simplify : Ir.t -> Ir.t = function
  | True -> True
  | Exists (atoms, rhs) -> exists atoms (simplify rhs)
  | Lnot rhs -> lnot (simplify rhs)
  | Reg _ as x -> x
  | Rel _ as x -> x
  | Lor _ as x -> x
  | Land xs ->
    (* We simplify only conjuncts because interesting test needs it.
      benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/heapsort.c.koat_2.smt2
    *)
    let xs = List.map simplify xs in
    Land (Base.List.dedup_and_sort ~compare:alpha_compare xs)
;;
