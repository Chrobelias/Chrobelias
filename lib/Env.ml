module SM = struct
  include Map.Make (Base.String)

  let iteri ~f m = iter (fun key data -> f ~key ~data) m
  let find_exn m k = find k m
  let find m k = find_opt k m
  let mem env k = mem k env
  let add_exn m ~key ~data = add key data m
end

type t =
  { env : Ast.Eia.term SM.t
  ; cstrts : Ast.Eia.term list SM.t
  }

let pp ?(title = "") : Format.formatter -> t -> unit =
  let open Format in
  let pp_kv ppf key data =
    fprintf ppf "@[%s -> @[%a@];@]@ " key Ast.pp_term_smtlib2 data
  in
  fun ppf { env = s; cstrts } ->
    if title = ""
    then (
      fprintf ppf "@[<hov> ";
      SM.iteri s ~f:(fun ~key ~data -> pp_kv ppf key data);
      SM.iteri cstrts ~f:(fun ~key ~data -> List.iter (pp_kv ppf key) data);
      fprintf ppf "@]")
    else (
      fprintf ppf "@[<v 6>@[%s@]@," title;
      SM.iteri s ~f:(fun ~key ~data -> pp_kv ppf key data);
      SM.iteri cstrts ~f:(fun ~key ~data -> List.iter (pp_kv ppf key) data);
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
           (* TODO: take into account string constriants too *)
             (match SM.find env v2 with
              | None -> ()
              | Some t -> helper env v t)
         | Atom (Const _) | Atom (Str_const _) -> ()
         | Eia.Add xs | Eia.Mul xs -> List.iter (helper env v) xs
         | Eia.Pow (l, r) ->
           helper env v l;
           helper env v r
         | Eia.Sofi x | Iofs x | Len x -> helper env v x
         | Len2 (Var v2) -> if String.equal v v2 then raise Occurs
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

let add_cstrt map ~key data =
  match SM.find_exn map key with
  | exception Not_found -> SM.add_exn map ~key ~data:[ data ]
  | ds -> SM.add_exn map ~key ~data:(data :: ds)
;;

let extend_cstrt_exn env ~key data =
  occurs_var_exn env key data;
  { env with cstrts = add_cstrt env.cstrts ~key data }
;;

let extend_exn : t -> _ -> _ -> t =
  fun e key data ->
  if SM.mem e.env key
  then (
    Format.eprintf "old value = %a\n" Ast.pp_term_smtlib2 (SM.find_exn e.env key);
    Format.eprintf "new value = %a\n" Ast.pp_term_smtlib2 data;
    failwith (Format.sprintf "key %s aready exists." key));
  let data = walk e data in
  if occurs_var e key data
  then raise Occurs
  else (
    match data with
    | Ast.Eia.Iofs _ | Len _ | Len2 _ | Sofi _ ->
      { e with cstrts = add_cstrt e.cstrts ~key data }
    | _ -> { e with env = SM.add_exn e.env ~key ~data })
;;

let empty : t = { env = SM.empty; cstrts = SM.empty }

(* let is_empty { env } = SM.is_empty env *)
let length { env; _ } = SM.cardinal env [@@warning "-32"]
let lookup k { env; _ } = SM.find env k
let lookup_exn k { env; _ } = SM.find_exn env k
let is_absent_key k { env; cstrts } = (not (SM.mem env k)) && not (SM.mem cstrts k)
let fold { env; _ } ~init ~f = SM.fold (fun key data acc -> f ~key ~data acc) env init

let filter_mapi ~f { env; _ } : (string, _) Base.Map.Poly.t =
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
         match v1, v2 with
         | None, None -> None
         | Some v1, Some v2 ->
           if Stdlib.(v1 = v2)
           then Some v1
           else failwith "We tried to subtitute a varible by two different terms"
         | Some v, _ | _, Some v -> Some v)
      e1.env
      e2.env
  in
  let cstrts =
    SM.merge
      (fun key v1 v2 ->
         match v1, v2 with
         | None, None -> None
         | Some xs, Some ys ->
           Some (Base.List.dedup_and_sort ~compare:Stdlib.compare (xs @ ys))
         | Some xs, _ | _, Some xs -> Some xs)
      e1.cstrts
      e2.cstrts
  in
  { env; cstrts }
;;

let to_eqs : t -> Ast.t list =
  fun { env; cstrts } ->
  let mk_eq v rhs = Ast.Eia (Ast.Eia.eq (Ast.Eia.Atom (Ast.Var v)) rhs) in
  (* if SM.is_empty cstrts
  then ()
  else Format.eprintf "%s %d: Some constraints may be missing\n%!" __FILE__ __LINE__; *)
  let acc =
    SM.fold
      (fun key data acc -> List.fold_left (fun acc rhs -> mk_eq key rhs :: acc) acc data)
      cstrts
      []
  in
  SM.fold
    (fun key data acc ->
       match data with
       | data -> Ast.Eia (Ast.Eia.eq (Ast.Eia.Atom (Ast.Var key)) data) :: acc)
    env
    acc
;;

let enrich m other =
  let _ : t = m in
  let _ : (Ast.atom, [ `Int of Z.t | `Str of string ]) Base.Map.Poly.t = other in
  let new_env =
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
  in
  { env = new_env; cstrts = m.cstrts }
;;
