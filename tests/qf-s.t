Basic QF_S tests

  $ Chro ./qf-s.smt2
  sat (under I)
  ((define-fun a () (_ String) "abc"))
  sat (presimpl)
  sat (presimpl)
  unsat (presimpl)
  sat (under I)
  unsat (presimpl)
  unsat (presimpl)
  sat (under I)
  sat (under I)
  sat (nfa)
  unsat (simpl)
  sat (nfa)
  unsat (nia)
  sat (presimpl)
  ((define-fun a () (_ String) "100100100100"))
  ((define-fun a () (_ String) "BaBaBaBaBaBaBaBaBaBaLyu"))
  ((define-fun a () (_ String) "Ba") (define-fun b () (_ String) "20"))
  ((define-fun a () (_ String) "Ba") (define-fun b () (_ String) "01"))
  ((define-fun a () (_ String) "BabBabBabBabBabBabBabBab")
   (define-fun b () (_ String) "2"))
  ((define-fun a () (_ String) "00000000000"))
  sat (under I)

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
