(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2026, Chrobelias. *)

(* The memoized atoms must accept the same points as the direct builders. *)

module Map = Base.Map.Poly

module Check
    (C : NfaCollection.Type)
    (N : sig
       type t = C.t

       val length : t -> int
       val rename_tracks : (int * int) list -> t -> t
       val intersect : t -> t -> t
       val run : t -> bool
     end) =
struct
  module M = NfaCollection.Memoize (C) (N)

  let names = [| "a"; "b"; "c" |]

  let accepts vars nfa point =
    List.fold_left
      (fun acc (x, v) -> N.intersect acc (C.eq vars (Map.singleton (Ir.var x) Z.one) v))
      nfa
      point
    |> N.run
  ;;

  (* Returns the number of disagreements. *)
  let run ~seed ~lo ~hi ~rounds =
    Random.init seed;
    let bad = ref 0 in
    for _ = 1 to rounds do
      let k = 1 + Random.int 3 in
      let tracks = [ 0; 1; 2; 3; 4 ] |> List.sort (fun _ _ -> Random.int 3 - 1) in
      let vars =
        List.init k (fun i -> Ir.var names.(i), List.nth tracks i) |> Map.of_alist_exn
      in
      let term =
        List.init k (fun i -> Ir.var names.(i), Z.of_int (Random.int 13 - 6))
        |> Map.of_alist_exn
      in
      (* Several constants per term, so that the shared state spaces are
         reused after being partly filled. *)
      let pairs =
        List.init 3 (fun _ ->
          let c = Z.of_int (Random.int 61 - 30) in
          let m = Z.of_int (2 + Random.int 5) in
          let build layers f =
            Memo.layers := layers;
            f ()
          in
          let both f = build [] f, build [ `Atoms; `Consts ] f in
          [ both (fun () -> M.eq vars term c)
          ; both (fun () -> M.neq vars term c)
          ; both (fun () -> M.leq vars term c)
          ; both (fun () -> M.mod_eq vars term m c)
          ])
        |> List.concat
      in
      let rec points i =
        if i = k
        then [ [] ]
        else
          List.concat_map
            (fun rest -> List.init (hi - lo + 1) (fun v -> (names.(i), Z.of_int (lo + v)) :: rest))
            (points (i + 1))
      in
      List.iter
        (fun (direct, memo) ->
           List.iter
             (fun p -> if accepts vars direct p <> accepts vars memo p then incr bad)
             (points 0))
        pairs
    done;
    !bad
  ;;
end

module MsbCheck = Check (NfaCollection.Msb) (Nfa.Msb (Nfa.Bv))
module LsbCheck = Check (NfaCollection.Lsb) (Nfa.Lsb (Nfa.Bv))

let%expect_test "memoized atoms agree with the direct builders" =
  let saved = !Memo.layers in
  Printf.printf
    "msb: %d\nlsb: %d\n"
    (MsbCheck.run ~seed:1 ~lo:(-4) ~hi:4 ~rounds:60)
    (LsbCheck.run ~seed:2 ~lo:0 ~hi:6 ~rounds:60);
  Memo.layers := saved;
  [%expect {|
    msb: 0
    lsb: 0
    |}]
;;
