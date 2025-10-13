Basic QF_S tests

  $ Chro ./qf-s.smt2
  sat ; nfa
  ((define-fun a () (_ String) "abc"))
  sat ; nfa
  sat ; nfa
  unsat
  sat ; nfa
  unsat
  unsat
  sat ; nfa
  sat ; nfa
  unsat
  sat ; nfa
  unsat
  sat ; nfa
  ((define-fun %27 () (_ Int) 12) (define-fun a () (_ String) "100100100100"))
  ((define-fun a () (_ String) "BaLyuLyuLyuLyuLyuLyuLyu")
   (define-fun x () (_ Int) 23))
  Fatal error: exception Sexplib0__Sexp.Not_found_s(_)
  Raised at Base__Map.Tree0.find_exn.if_not_found in file "src/map.ml", line 632, characters 6-84
  Called from Base__Map.Accessors.find_exn in file "src/map.ml" (inlined), lines 2202-2206, characters 4-41
  Called from Dune__exe__Chro.join_int_model.seek in file "bin/chro.ml", line 243, characters 15-38
  Called from Dune__exe__Chro.join_int_model.(fun) in file "bin/chro.ml", line 255, characters 10-18
  Called from Dune__exe__Chro.exec in file "bin/chro.ml", line 364, characters 27-51
  Called from Stdlib__List.fold_left in file "list.ml", line 123, characters 24-34
  Called from Dune__exe__Chro in file "bin/chro.ml", lines 411-414, characters 4-7
  [2]

+  1 sat
+  2 sat
+  3 sat
+  4 unsat
+  5 unsat
+  6 unsat
+  7 unsat
+  8 unsat
+  9 sat
+  10 unsat
+  11 sat
+  12 unsat

5, 8
