(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

module Map = Base.Map.Poly
module Set = Base.Set.Poly

let ( let* ) = Option.bind

exception Timeout

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

let div_rem a b =
  match Z.sign a, Z.sign b with
  | -1, 1 ->
    Z.div_rem a b |> fun (x, y) -> if Z.(y = zero) then x, y else Z.(x - one), Z.(y + b)
  | -1, -1 ->
    Z.div_rem a b |> fun (x, y) -> if Z.(y = zero) then x, y else Z.(x + one), Z.(y - b)
  | _ -> Z.div_rem a b
;;

let div_floor a b = if Z.(a mod b >= zero) then Z.(a / b) else Z.((a / b) - one)
let div_ceil a b = if Z.(a mod b <= zero) then Z.(a / b) else Z.((a / b) + one)

let to_bits n =
  let last_bit n =
    match Z.(n mod of_int 2) with
    | n when n = Z.zero -> false
    | _ -> true
  in
  let n = if Z.(n < zero) then Z.(-n) else n in
  let rec helper acc = function
    | x when x = Z.zero -> false :: acc
    | x when x = Z.one -> true :: acc
    | x -> last_bit x :: helper acc (Z.shift_right x 1)
  in
  helper [] n
;;

let rec powerset = function
  | [] -> [ [] ]
  | x :: xs ->
    let ps = powerset xs in
    let with_x = List.map (fun subset -> x :: subset) ps in
    ps @ with_x
;;

let rec cartesian = function
  | [] -> [ [] ]
  | x :: xs -> List.concat_map (fun n -> List.map (fun l -> n :: l) (cartesian xs)) x
;;

let%expect_test "cartesian_test" =
  let v = cartesian [ [ 1; 2; 3 ]; [ 4; 5 ]; [ 6 ] ] in
  Format.printf "1: %d \n%!" (List.length v);
  List.iter
    (fun v' ->
       Format.printf
         "%a\n%!"
         (Format.pp_print_list
            ~pp_sep:(fun ppf () -> Format.fprintf ppf " ")
            Format.pp_print_int)
         v')
    v;
  Format.printf "\n%!";
  let v = cartesian [ [ 1 ]; [ 4 ]; [ 7 ] ] in
  Format.printf "2: %d \n%!" (List.length v);
  List.iter
    (fun v' ->
       Format.printf
         "%a\n%!"
         (Format.pp_print_list
            ~pp_sep:(fun ppf () -> Format.fprintf ppf " ")
            Format.pp_print_int)
         v')
    v;
  Format.printf "\n%!";
  let v = cartesian [ [ 1 ]; [ 4 ]; [] ] in
  Format.printf "3: %d \n%!" (List.length v);
  List.iter
    (fun v' ->
       Format.printf
         "%a\n%!"
         (Format.pp_print_list
            ~pp_sep:(fun ppf () -> Format.fprintf ppf " ")
            Format.pp_print_int)
         v')
    v;
  Format.printf "\n%!";
  let v = cartesian [ [ 1 ] ] in
  Format.printf "4: %d \n%!" (List.length v);
  List.iter
    (fun v' ->
       Format.printf
         "%a\n%!"
         (Format.pp_print_list
            ~pp_sep:(fun ppf () -> Format.fprintf ppf " ")
            Format.pp_print_int)
         v')
    v;
  Format.printf "\n%!";
  let v = cartesian [ [] ] in
  Format.printf "5: %d \n%!" (List.length v);
  List.iter
    (fun v' ->
       Format.printf
         "%a\n%!"
         (Format.pp_print_list
            ~pp_sep:(fun ppf () -> Format.fprintf ppf " ")
            Format.pp_print_int)
         v')
    v;
  Format.printf "\n%!";
  [%expect
    {|
    1: 6
    1 4 6
    1 5 6
    2 4 6
    2 5 6
    3 4 6
    3 5 6

    2: 1
    1 4 7

    3: 0

    4: 1
    1

    5: 0
    |}]
;;

let cartesian2 lss =
  List.fold_right
    (fun xs acc ->
       List.fold_left
         (fun nested_acc x ->
            List.fold_left
              (fun inner_acc combo -> (x :: combo) :: inner_acc)
              nested_acc
              acc)
         []
         xs)
    lss
    [ [] ]
;;

let rec strings_of_len n alpha =
  match n with
  | 0 -> [ "" ]
  | 1 -> alpha
  | n ->
    strings_of_len (n - 1) alpha
    |> List.concat_map (fun s -> List.map (fun a -> s ^ a) alpha)
;;

let with_extra_char alpha =
  let ascii = List.init (128 - 32) (fun i -> Char.chr (i + 32)) |> Set.of_list in
  let diff = Set.diff ascii alpha in
  let extra_char =
    (if Set.mem diff '0' then Option.some '0' else Set.nth diff 0)
    |> Option.map Set.singleton
    |> Option.value ~default:Set.empty
  in
  Set.union alpha extra_char |> Set.to_list
;;

let find_map_n n f lst =
  let rec aux acc count = function
    | _ when count <= 0 -> List.rev acc
    | [] -> List.rev acc
    | x :: tl ->
      let res = f x in
      if Option.is_some res
      then aux (Option.get res :: acc) (count - 1) tl
      else aux acc count tl
  in
  aux [] n lst
;;

let unique lst =
  let counts = Hashtbl.create (List.length lst) in
  List.iter
    (fun x ->
       let count =
         try Hashtbl.find counts x with
         | Not_found -> 0
       in
       Hashtbl.replace counts x (count + 1))
    lst;
  List.filter (fun x -> Hashtbl.find counts x = 1) lst
;;
