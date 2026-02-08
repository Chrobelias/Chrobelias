Basic QF_S tests

  $ Chro ./qf-s.smt2
  sat (presimpl)
  (
     (define-fun a () String
      "abc")
     (define-fun b () String
      "")
     (define-fun q () Int
      0)
     (define-fun x () Int
      0)
  )
  sat (presimpl)
  sat (presimpl)
  unsat (presimpl)
  sat (presimpl)
  unsat (presimpl)
  unsat (presimpl)
  sat (under I)
  sat (presimpl)
  sat (presimpl)
  unsat (presimpl)
  sat (nfa)
  unsat (nia)
  sat (presimpl)
  (
     (define-fun a () String
      "100100100100")
     (define-fun b () String
      "")
     (define-fun q () Int
      0)
     (define-fun x () Int
      0)
  )
  (
     (define-fun a () String
      "BaBaBaBaBaBaBaBaBaBaLyu")
     (define-fun b () String
      "")
     (define-fun q () Int
      0)
     (define-fun x () Int
      23)
  )
  (
     (define-fun a () String
      "Ba")
     (define-fun b () String
      "20")
     (define-fun q () Int
      0)
     (define-fun x () Int
      0)
  )
  (
     (define-fun a () String
      "Ba")
     (define-fun b () String
      "01")
     (define-fun q () Int
      2)
     (define-fun x () Int
      0)
  )
  (
     (define-fun a () String
      "BabBabBabBabBabBabBabBab")
     (define-fun b () String
      "2")
     (define-fun q () Int
      24)
     (define-fun x () Int
      0)
  )
  (
     (define-fun a () String
      "00000000000")
     (define-fun b () String
      "")
     (define-fun q () Int
      0)
     (define-fun x () Int
      0)
  )
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
