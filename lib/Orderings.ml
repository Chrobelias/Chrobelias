type t = (Ir.atom * Ir.atom) list (* (lesser, larger) list *)

(* TODO: use OCamlGraph library  *)
(* TODO: if there is a loop of path > 1 --- unsat  *)

let pp ppf xs =
  let open Format in
  pp_print_list
    ~pp_sep:(fun ppf () -> fprintf ppf " ")
    (fun ppf (l, r) -> fprintf ppf "%a<%a" Ir.pp_atom l Ir.pp_atom r)
    ppf
    xs
;;

let compare ~small larger order =
  match List.mem (small, larger) order with
  | true -> `LT
  | false ->
    (match List.mem (larger, small) order with
     | true -> `GT
     | false -> `Unknown)
;;

let mine_orderings ast =
  let open Ast in
  let f acc = function
    | Eia (Eia.Leq (Eia.Atom (Var v), Eia.Atom (Const c))) -> (v, c) :: acc
    | _ -> acc
  in
  match ast with
  | Ast.Land xs -> List.fold_left f [] xs
  | _ -> []
;;

let prepare_order_check ir =
  let module M = Base.Map.Poly in
  let f acc ph =
    Format.printf "ph = %a, \n%!" Ir.pp ph;
    Format.printf " tag = %d\n%!" (Obj.tag (Obj.repr ph));
    match ph with
    | Land [ Ir.Rel (Ir.Leq, m, rhs) ]
    | Ir.Rel (Ir.Leq, m, rhs) (*when M.length m = 2 && Z.(rhs >= zero) *) ->
      Format.printf "%s %d\n%!" __FUNCTION__ __LINE__;
      let v1, coeff1 = M.min_elt_exn m in
      let v2, coeff2 = M.max_elt_exn m in
      Format.printf "  coeff1 = %a, coeff2 = %a\n%!" Z.pp_print coeff1 Z.pp_print coeff2;
      (match Z.sign coeff1, Z.sign coeff2 with
       | -1, 1 -> (v2, v1) :: acc
       | _ ->
         Format.printf
           "Skip: %a, coeff1 = %a, coeff2 = %a\n%!"
           Ir.pp_smtlib2
           ph
           Z.pp_print
           coeff1
           Z.pp_print
           coeff2;
         acc)
    | _ -> acc
  in
  match ir with
  | Ir.Exists (_, Ir.Land xs) | Ir.Land xs -> List.fold_left f [] xs
  | _ -> []
;;
