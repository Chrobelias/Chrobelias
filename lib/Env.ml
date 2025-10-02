type t = (string, [ `Eia of Ast.Eia.term | `Str of Ast.Str.term ]) Base.Map.Poly.t

let pp : Format.formatter -> t -> unit =
  fun ppf s ->
  Format.fprintf ppf "@[ ";
  Base.Map.iteri s ~f:(fun ~key ~data ->
    match data with
    | `Eia data -> Format.fprintf ppf "%s -> @[%a@]; " key Ast.pp_term_smtlib2 data
    | `Str data -> Format.fprintf ppf "%s -> @[%a@]; " key Ast.Str.pp_term data);
  Format.fprintf ppf "@]"
[@@ocaml.warning "-32"]
;;

let walk =
  fun env ->
  Ast.map_term
    (function
      | Ast.Eia.Atom (Ast.Var s) as orig ->
        (match Base.Map.Poly.find_exn env s with
         | (exception Base.Not_found_s _) | `Str _ -> orig
         | `Eia t -> t)
      | t -> t)
    (function
      | Ast.Str.Atom (Ast.Var s) as orig ->
        (match Base.Map.Poly.find_exn env s with
         | (exception Base.Not_found_s _) | `Eia _ -> orig
         | `Str t -> t)
      | t -> t)
;;

let is_absent_key k map = not (Base.Map.Poly.mem map k)

exception Occurs

let rec occurs_var_exn =
  fun env v term ->
  Ast.fold_term
    (fun () ->
       let open Ast in
       function
       | Eia.Atom (Var v2) when String.equal v v2 -> raise Occurs
       | Eia.Atom (Var v2) when not (is_absent_key v2 env) ->
         occurs_var_exn env v (Base.Map.Poly.find_exn env v2)
       | Eia.Len (Str.Atom (Var v2)) when String.equal v v2 -> raise Occurs
       | Eia.Stoi (Str.Atom (Var v2)) when String.equal v v2 -> raise Occurs
       | _ -> ())
    (fun () -> function
       | Ast.(Str.Atom (Var v2)) when String.equal v v2 -> raise Exit
       | _ -> ())
    ()
    term
;;

let occurs_var env v term =
  try
    occurs_var_exn env v term;
    false
  with
  | Occurs -> true
;;

let extend_exn : t -> _ -> _ -> t =
  fun env key data ->
  let data = walk env data in
  if occurs_var env key data then raise Occurs else Base.Map.Poly.add_exn env ~key ~data
;;

let empty : t = Base.Map.Poly.empty
let is_empty = Base.Map.Poly.is_empty
let length = Base.Map.Poly.length [@@warning "-32"]
let lookup k map = Base.Map.Poly.find map k
let lookup_exn k map = Base.Map.Poly.find_exn map k
let is_absent_key k map = not (Base.Map.Poly.mem map k)
let fold : t -> _ = Base.Map.Poly.fold

let merge : t -> t -> t =
  Base.Map.Poly.merge_skewed ~combine:(fun ~key v1 v2 ->
    if Stdlib.(v1 = v2)
    then v1
    else
      (*Format.eprintf "v1 = %a\n%!" Ast.pp_term_smtlib2 v1;
      Format.eprintf "v2 = %a\n%!" Ast.pp_term_smtlib2 v2;*)
      failwith "We tried to subtitute a varible by two different terms")
;;

let to_eqs : t -> Ast.t list =
  Base.Map.Poly.fold ~init:[] ~f:(fun ~key ~data acc ->
    match data with
    | `Eia data -> Ast.Eia (Ast.Eia.eq (Ast.Eia.Atom (Ast.Var key)) data) :: acc
    | `Str data -> Ast.Str (Ast.Str.eq (Ast.Str.Atom (Ast.Var key)) data) :: acc)
;;

let enrich m other =
  let _ : t = m in
  let _ : (Ast.atom, [ `Int of Z.t | `Str of string ]) Base.Map.Poly.t = other in
  Base.Map.fold other ~init:m ~f:(fun ~key ~data acc ->
    match key, data with
    | Ast.Var s, `Int z ->
      Base.Map.Poly.add_exn acc ~key:s ~data:(`Eia (Ast.Eia.Atom (Const z)))
    | _, `Str _ ->
      (* TODO(Kakadu): implememt it sooner or later  *)
      acc
    | _ -> failwith "Enriching model is not fully implemented")
;;
