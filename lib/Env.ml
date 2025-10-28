module SM = struct
  include Map.Make (Base.String)

  let iteri ~f m = iter (fun key data -> f ~key ~data) m
  let find_exn m k = find k m
  let find m k = find_opt k m
  let mem env k = mem k env
  let add_exn m ~key ~data = add key data m
end

type t = { env : Ast.Eia.term SM.t }

let pp ?(title = "") : Format.formatter -> t -> unit =
  let open Format in
  fun ppf { env = s } ->
    if title = ""
    then (
      fprintf ppf "@[<hov> ";
      SM.iteri s ~f:(fun ~key ~data ->
        fprintf ppf "@[%s -> @[%a@];@]@ " key Ast.pp_term_smtlib2 data);
      fprintf ppf "@]")
    else (
      fprintf ppf "@[<v 6>@[%s@]@," title;
      SM.iteri s ~f:(fun ~key ~data ->
        fprintf ppf "@[%s -> @[%a@]@]@," key Ast.pp_term_smtlib2 data);
      fprintf ppf "@]")
[@@ocaml.warning "-32"]
;;

let walk : t -> _ =
  fun e ->
  let f = function
    | Ast.Eia.Atom (Ast.Var s) as orig ->
      (match SM.find_exn e.env s with
       | exception Not_found -> orig
       | t -> t)
    | t -> t
  in
  Ast.map_term f
;;

(* let is_absent_key k map = not (SM.mem map k) *)

exception Occurs

let occurs_var_exn =
  let rec helper env v term =
    let _ : Ast.Eia.term = term in
    Ast.fold_term
      (fun () ->
         let open Ast in
         function
         | Eia.Atom (Var v2) when String.equal v v2 -> raise Occurs
         | Eia.Atom (Var v2) ->
           (match SM.find env v2 with
            | None -> ()
            | Some t -> helper env v t)
         | Atom (Const _) | Atom (Str_const _) -> ()
         | Eia.Add xs | Eia.Mul xs -> List.iter (helper env v) xs
         | Eia.Pow (l, r) ->
           helper env v l;
           helper env v r
         | Eia.Sofi x | Eia.Iofs x | Eia.Len x -> helper env v x
         | x -> Format.kasprintf failwith "not implemented: %a" Ast.pp_term_smtlib2 x)
      ()
      term
  in
  fun env v t -> helper env.env v t
;;

let occurs_var env v term =
  try
    occurs_var_exn env v term;
    false
  with
  | Occurs -> true
;;

let extend_exn : t -> _ -> _ -> t =
  fun e key data ->
  if SM.mem e.env key
  then (
    Format.eprintf "old value = %a\n" Ast.pp_term_smtlib2 (SM.find_exn e.env key);
    Format.eprintf "new value = %a\n" Ast.pp_term_smtlib2 data;
    failwith (Format.sprintf "key %s aready exists." key));
  let data = walk e data in
  if occurs_var e key data then raise Occurs else { env = SM.add_exn e.env ~key ~data }
;;

let empty : t = { env = SM.empty }
let is_empty { env } = SM.is_empty env
let length { env } = SM.cardinal env [@@warning "-32"]
let lookup k { env = map } = SM.find map k
let lookup_exn k { env } = SM.find_exn env k
let is_absent_key k { env } = not (SM.mem env k)
let fold { env } ~init ~f = SM.fold (fun key data acc -> f ~key ~data acc) env init

let filter_mapi ~f { env } : (string, _) Base.Map.Poly.t =
  SM.fold
    (fun key data acc ->
       match f ~key ~data with
       | None -> acc
       | Some x -> Base.Map.Poly.add_exn acc ~key ~data:x)
    env
    Base.Map.Poly.empty
;;

let merge : t -> t -> t =
  fun e1 e2 ->
  let env =
    SM.merge
      (fun key v1 v2 ->
         if Stdlib.(v1 = v2)
         then v1
         else failwith "We tried to subtitute a varible by two different terms")
      e1.env
      e2.env
  in
  { env }
;;

let to_eqs : t -> Ast.t list =
  fun { env } ->
  SM.fold
    (fun key data acc ->
       match data with
       | data -> Ast.Eia (Ast.Eia.eq (Ast.Eia.Atom (Ast.Var key)) data) :: acc)
    env
    []
;;

let enrich m other =
  let _ : t = m in
  let _ : (Ast.atom, [ `Int of Z.t | `Str of string ]) Base.Map.Poly.t = other in
  Base.Map.fold other ~init:m.env ~f:(fun ~key ~data acc ->
    match key, data with
    | Ast.Var s, `Int z -> SM.add_exn acc ~key:s ~data:(Ast.Eia.Atom (Const z))
    | Ast.Var s, `Str z -> SM.add_exn acc ~key:s ~data:(Ast.Eia.Atom (Str_const z))
    | key, `Int z ->
      Format.eprintf "@[%a ~~> %a@]\n" Ast.pp_atom key Z.pp_print z;
      failwith "Enriching model is not fully implemented"
    | key, `Str z ->
      Format.eprintf "@[%a ~~> %S@]\n" Ast.pp_atom key z;
      failwith "Enriching model is not fully implemented"
    (* | _ -> failwith "Enriching model is not fully implemented" *))
  |> fun env -> { env }
;;
