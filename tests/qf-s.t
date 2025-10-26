Basic QF_S tests

  $ Chro ./qf-s.smt2
  sat (nfa)
  ((define-fun a () (_ String) "abc"))
  sat (nfa)
  sat (nfa)
  unsat (nfa)
  sat (nfa)
  unsat (nfa)
  unsat (nfa)
  sat (nfa)
  sat (nfa)
  unsat (nfa)
  sat (nfa)
  unsat (nfa)
  sat (nfa)
  ((define-fun %24 () (_ Int) 12) (define-fun a () (_ String) "100100100100"))
  ((define-fun a () (_ String) "BaLyuLyuLyuLyuLyuLyuLyu")
   (define-fun x () (_ Int) 23))
  Warning: some of the eia model pieces are likely to be missed: %30 = %32
  ; Can't join models. Something may be missing
  ((define-fun a () (_ String) "Ba") (define-fun b () (_ String) "20"))
  Warning: some of the eia model pieces are likely to be missed: q = %36
  ((define-fun a () (_ String) "Ba") (define-fun b () (_ String) "01"))
  ((define-fun a () (_ String) "BabBabBabLyubaLyubaLyuba")
   (define-fun b () (_ String) "2")
   (define-fun q () (_ Int) 24))
  ((define-fun a () (_ String) "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"))
  sat (nfa)

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
