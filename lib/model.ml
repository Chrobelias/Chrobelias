module Map = Base.Map.Poly

type t = (string, [ `Int of Z.t | `Str of string | `Bool of bool ]) Map.t
type tys = (string, [ `Int | `Str | `Bool ]) Map.t

let pp ppf m =
  let open Format in
  fprintf ppf "@[<v 1>@[(@]\n ";
  let i = ref 0 in
  (* Mutability only for pretty-printing *)
  Map.iteri m ~f:(fun ~key ~data ->
    if not (String.starts_with ~prefix:"%" key)
    then begin
      if !i <> 0 then fprintf ppf "@ " else incr i;
      match data with
      | `Int z -> fprintf ppf "  @[(define-fun %s () Int\n    %a)@]" key Z.pp_print z
      | `Str s -> fprintf ppf "  @[(define-fun %s () String\n    \"%s\")@]" key s
      | `Bool b -> fprintf ppf "  @[(define-fun %s () Bool\n    %b)@]" key b
    end
    else ());
  fprintf ppf "\n)@]"
;;

let to_string = Format.asprintf "%a" pp

let%expect_test "model printing covers every sort" =
  let m =
    Map.of_alist_exn
      [ "b", `Bool true; "c", `Bool false; "x", `Int (Z.of_int (-4)); "s", `Str "ab" ]
  in
  print_string (to_string m);
  [%expect
    {|
    (
       (define-fun b () Bool
        true)
       (define-fun c () Bool
        false)
       (define-fun s () String
        "ab")
       (define-fun x () Int
        -4)
    )
    |}]
;;
