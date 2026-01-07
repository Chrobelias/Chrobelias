module SM = struct
  include Map.Make (Base.String)

  let iteri ~f m = iter (fun key data -> f ~key ~data) m
  let find_exn m k = find k m
  let find m k = find_opt k m
  let mem env k = mem k env
  let add_exn m ~key ~data = add key data m
end

let _failf fmt = Format.kasprintf failwith fmt

type kv = KV : 'a Ast.atom * 'a Ast.Eia.term -> kv

type t =
  { env : Z.t Ast.Eia.term SM.t (** Integer equalities *)
  ; str_env : string Ast.Eia.term SM.t
    (* TODO(Kakadu): Maybe we don't need two environments... *)
    (** string equalities *)
  ; cstrts : kv list (* string constraints multimap *)
  }

let pp ?(title = "") : Format.formatter -> t -> unit =
  let open Format in
  let pp_kv ppf key (type a) (data : a Ast.Eia.term) =
    fprintf ppf "@[%s -> @[%a@];@]@ " key Ast.pp_term_smtlib2 data
  in
  fun ppf e ->
    if title = ""
    then (
      fprintf ppf "@[<hov> ";
      SM.iteri e.env ~f:(fun ~key ~data -> pp_kv ppf key data);
      SM.iteri e.str_env ~f:(fun ~key ~data -> pp_kv ppf key data);
      List.iter
        (function
          | KV (Var (key, _), data) -> pp_kv ppf key data)
        e.cstrts;
      fprintf ppf "@]")
    else (
      fprintf ppf "@[<v 6>@[%s@]@," title;
      SM.iteri e.env ~f:(fun ~key ~data -> pp_kv ppf key data);
      SM.iteri e.str_env ~f:(fun ~key ~data -> pp_kv ppf key data);
      List.iter
        (function
          | KV (Var (key, _), data) ->
            fprintf ppf "- %a" (fun ppf data -> pp_kv ppf key data) data)
        e.cstrts;
      fprintf ppf "@]")
[@@ocaml.warning "-32"]
;;

type 'a term = 'a Ast.Eia.term

let walk : 'a. t -> 'a term -> 'a term =
  fun e ->
  let fz = function
    | Ast.Eia.Atom (Ast.Var (s, I)) as orig ->
      (match SM.find_exn e.env s with
       | exception Not_found -> orig
       | t -> t)
    | t -> t
  in
  let fs = function
    | Ast.Eia.Atom (Ast.Var (s, S)) as orig ->
      (match SM.find_exn e.str_env s with
       | exception Not_found -> orig
       | t -> t)
    | t -> t
  in
  Ast.Eia.map_term fz fs
;;

let equal (env : t) (env' : t) =
  SM.equal Ast.Eia.equal env.env env'.env
  && SM.equal Ast.Eia.equal env.str_env env'.str_env
  && env.cstrts = env'.cstrts
;;

(* let is_absent_key k map = not (SM.mem map k) *)

exception Occurs

let occurs_var_exn =
  let rec helper : 'a. t -> string -> 'a Ast.Eia.term -> unit =
    fun (type a) env v (term : a Ast.Eia.term) ->
    let _ : _ Ast.Eia.term = term in
    let rec fz () =
      let open Ast in
      function
      | Eia.Atom (Var (v2, I)) when String.equal v v2 -> raise Occurs
      | Eia.Atom (Var (v2, I)) ->
        (* TODO: take into account string constriants too *)
          (match SM.find env.env v2 with
           | None -> ()
           | Some t -> helper env v t)
      | Const _ -> ()
      | Eia.Add xs | Eia.Mul xs -> List.iter (helper env v) xs
      | Eia.Pow (l, r) ->
        helper env v l;
        helper env v r
      | Iofs x | Len x -> fs () x
      | Len2 (Atom (Ast.Var (v2, S))) -> if String.equal v v2 then raise Occurs
      | x ->
        Format.kasprintf
          failwith
          "not implemented in occurs_var: %a"
          Ast.pp_term_smtlib2
          x
    and fs () =
      let open Ast in
      function
      | Eia.Atom (Var (v2, S)) when String.equal v v2 -> raise Occurs
      | Eia.Atom (Var (v2, S)) ->
        (* TODO: take into account string constriants too *)
          (match SM.find env.env v2 with
           | None -> ()
           | Some t -> helper env v t)
      | Ast.Eia.Str_const _ -> ()
      | Eia.Sofi x -> helper env v x
      | x ->
        Format.kasprintf
          failwith
          "not implemented in occurs_var: %a"
          Ast.pp_term_smtlib2
          x
    in
    Ast.Eia.fold_term fz fs () term
  in
  helper
;;

let occurs_var env v term =
  try
    occurs_var_exn env v term;
    false
  with
  | Occurs -> true
;;

let add_cstrt map (type a) (key : a Ast.atom) (data : a term) =
  { map with cstrts = KV (key, data) :: map.cstrts }
;;

let extend_cstrt_exn env ~key data =
  match key with
  | Ast.Var (vname, typ) ->
    occurs_var_exn env vname data;
    add_cstrt env key data
;;

let extend_int_exn e vname data =
  match SM.find e.env vname with
  | Some old_data ->
    Format.eprintf "old value = %a\n" Ast.pp_term_smtlib2 old_data;
    Format.eprintf "new value = %a\n" Ast.pp_term_smtlib2 data;
    failwith (Format.sprintf "key %s aready exists." vname)
  | None ->
    let data = walk e data in
    if occurs_var e vname data then raise Occurs;
    (*match data with
    | Ast.Eia.Iofs _ | Len _ | Len2 _ -> add_cstrt e (Ast.Var (vname, I)) data
    | _ -> *)
    { e with env = SM.add_exn e.env ~key:vname ~data }
;;

let set_int_exn e vname data =
  match SM.find e.env vname with
  | Some old_data ->
    Format.eprintf "old value = %a\n" Ast.pp_term_smtlib2 old_data;
    Format.eprintf "new value = %a\n" Ast.pp_term_smtlib2 data;
    { e with env = SM.add_exn (SM.remove vname e.env) ~key:vname ~data }
  | None ->
    let data = walk e data in
    if occurs_var e vname data then raise Occurs;
    (*match data with
    | Ast.Eia.Iofs _ | Len _ | Len2 _ -> add_cstrt e (Ast.Var (vname, I)) data
    | _ -> *)
    { e with env = SM.add_exn e.env ~key:vname ~data }
;;

let extend_string_exn e vname data =
  if SM.mem e.str_env vname
  then (
    Format.eprintf "old value = %a\n" Ast.pp_term_smtlib2 (SM.find_exn e.str_env vname);
    Format.eprintf "new value = %a\n" Ast.pp_term_smtlib2 data;
    failwith (Format.sprintf "key %s aready exists." vname));
  let data = walk e data in
  if occurs_var e vname data then raise Occurs;
  (*match data with
  | Ast.Eia.Sofi _ -> add_cstrt e (Ast.Var (vname, S)) data
  | _ -> *)
  { e with str_env = SM.add_exn e.str_env ~key:vname ~data }
;;

let extend_exn : 'a. t -> 'a Ast.atom -> 'a term -> t =
  fun (type a) e (key : a Ast.atom) (data : a term) ->
  match key, data with
  | Ast.Var (vname, I), data ->
    let data : Z.t term = data in
    extend_int_exn e vname data
  | Ast.Var (vname, S), data ->
    let _ : string term = data in
    extend_string_exn e vname data
;;

let empty : t = { env = SM.empty; str_env = SM.empty; cstrts = [] }

[@@@ocaml.warnerror "-32"]

(* let is_empty { env } = SM.is_empty env *)
let length { env; str_env; cstrts } =
  SM.cardinal env + SM.cardinal str_env + List.length cstrts
[@@warning "-32"]
;;

(* let lookup k { env; _ } = SM.find env k *)
(* let lookup_exn k { env; _ } = SM.find_exn env k *)
let is_absent_key k e = (not (SM.mem e.env k)) && not (SM.mem e.str_env k)

let fold { env; str_env; _ } ~init ~f =
  let init = SM.fold (fun key data acc -> f ~key ~data:(Ast.TT (I, data)) acc) env init in
  SM.fold (fun key data acc -> f ~key ~data:(Ast.TT (S, data)) acc) str_env init
;;

(* let filter_mapi ~f { env; _ } : (string, _) Base.Map.Poly.t =
  SM.fold
    (fun key data acc ->
       match f ~key ~data with
       | None -> acc
       | Some x -> Base.Map.Poly.add_exn acc ~key ~data:x)
    env
    Base.Map.Poly.empty
;; *)

let merge
  :  sf:
       (key:string
        -> data1:string Ast.Eia.term
        -> data2:string Ast.Eia.term
        -> string Ast.Eia.term)
  -> zf:
       (key:string
        -> data1:Z.t Ast.Eia.term
        -> data2:Z.t Ast.Eia.term
        -> Z.t Ast.Eia.term)
  -> t
  -> t
  -> t
  =
  fun ~sf ~zf e1 e2 ->
  let merge2 f key v1 v2 =
    match v1, v2 with
    | None, None -> None
    | Some v1, Some v2 ->
      if Stdlib.(v1 = v2) then Some v1 else Some (f ~key ~data1:v1 ~data2:v2)
    | Some v, _ | _, Some v -> Some v
  in
  let env = SM.merge (merge2 zf) e1.env e2.env in
  let str_env = SM.merge (merge2 sf) e1.str_env e2.str_env in
  let cstrts = e1.cstrts @ e2.cstrts in
  { env; str_env; cstrts }
;;

let merge_exn =
  merge
    ~sf:(fun ~key ~data1:v1 ~data2:v2 ->
      failwith
        (Format.asprintf
           "We tried to subtitute a %s varible by two different terms: %a %a"
           key
           Ast.Eia.pp_term
           v1
           Ast.Eia.pp_term
           v2))
    ~zf:(fun ~key ~data1:v1 ~data2:v2 ->
      failwith
        (Format.asprintf
           "We tried to subtitute a %s varible by two different terms: %a %a"
           key
           Ast.Eia.pp_term
           v1
           Ast.Eia.pp_term
           v2))
;;

let to_eqs : t -> Ast.t list =
  fun { env; str_env; cstrts } ->
  let mk_eq typ v rhs =
    Ast.Eia (Ast.Eia.Eq (Ast.Eia.Atom (Ast.Var (v, typ)), rhs, typ))
  in
  (* if SM.is_empty cstrts
  then ()
  else Format.eprintf "%s %d: Some constraints may be missing\n%!" __FILE__ __LINE__; *)
  cstrts
  |> List.map (function KV (Ast.Var (v, typ), rhs) -> mk_eq typ v rhs)
  |> SM.fold (fun key data acc -> mk_eq I key data :: acc) env
  |> SM.fold (fun key data acc -> mk_eq S key data :: acc) str_env
;;

let enrich m other =
  let _ : t = m in
  let _ : (Ast.any_atom, [ `Int of Z.t | `Str of string ]) Base.Map.Poly.t = other in
  let new_env =
    Base.Map.fold other ~init:m.env ~f:(fun ~key ~data acc ->
      match key, data with
      | Any_atom (Ast.Var (s, I)), `Int z | Any_atom (Ast.Var (s, S)), `Int z ->
        SM.add_exn acc ~key:s ~data:(Const z)
      | _, `Str z -> acc
      (*| Any_atom (Ast.Var (s, S)), `Int z ->
        failf
          "tried to enrich with a model having string %s an integer value %a"
          s
          Z.pp_print
          z*))
  in
  let new_str_env =
    Base.Map.fold other ~init:m.str_env ~f:(fun ~key ~data acc ->
      match key, data with
      | Any_atom (Ast.Var (s, S)), `Str z | Any_atom (Ast.Var (s, I)), `Str z ->
        SM.add_exn acc ~key:s ~data:(Str_const z)
      | _, `Int z -> acc
      (*| Any_atom (Ast.Var (s, I)), `Str z ->
        failf "tried to enrich with a model having integer %s a string value %s" s z*))
  in
  { env = new_env; cstrts = m.cstrts; str_env = new_str_env }
;;

let lookup_int name { env; _ } = SM.find_opt name env
let lookup_int_exn name { env; _ } = SM.find_exn env name
let lookup_string name { str_env = e; _ } = SM.find_opt name e
let lookup_string_exn name { str_env = e; _ } = SM.find_exn e name

let filter_mapi
      ~(fstr : string -> string Ast.Eia.term -> string Ast.Eia.term option)
      ~(fint : string -> Z.t Ast.Eia.term -> Z.t Ast.Eia.term option)
      env
  =
  fold
    ~f:(fun ~key ~data acc ->
      match data with
      | Ast.TT (Ast.S, str) -> begin
        match fstr key str with
        | Some v -> extend_string_exn acc key str
        | None -> acc
      end
      | Ast.TT (Ast.I, int) -> begin
        match fint key int with
        | Some v -> extend_int_exn acc key int
        | None -> acc
      end)
    ~init:empty
    env
;;
