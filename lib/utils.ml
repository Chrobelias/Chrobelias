(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

module Map = Base.Map.Poly

let ( let* ) = Option.bind

let option_map_to_map_option (map : ('a, 'b option) Map.t) : ('a, 'b) Map.t option =
  Map.fold map ~init:(Some Map.empty) ~f:(fun ~key ~data acc ->
    let* acc = acc in
    let* data = data in
    Some (Map.set ~key ~data acc))
;;

let rec pow ~base:a = function
  | n when n < 0 -> failwith (Printf.sprintf "Bad argument: exp = %d" n)
  | 0 -> 1
  | 1 -> a
  | n ->
    let b = pow ~base:a (n / 2) in
    b * b * if n mod 2 = 0 then 1 else a
;;

let rec powz ~base:a = function
  | n when Z.(n < zero) ->
    failwith (Format.asprintf "Bad argument: exp = %a" Z.pp_print n)
  | n when n = Z.zero -> Z.one
  | n when n = Z.one -> a
  | n ->
    let b = powz ~base:a Z.(n / of_int 2) in
    Z.(b * b * if n mod of_int 2 = zero then one else a)
;;

let log ppf =
  match Sys.getenv "CHRO_DEBUG" with
  | exception Not_found -> Format.ifprintf Format.std_formatter ppf
  | _ -> Format.kasprintf (Format.printf "%s\n%!") ppf
;;

let rec strings_of_len n alpha =
  match n with
  | 0 -> [ "" ]
  | 1 -> alpha
  | n ->
    strings_of_len (n - 1) alpha
    |> List.concat_map (fun s -> List.map (fun a -> s ^ a) alpha)
;;
