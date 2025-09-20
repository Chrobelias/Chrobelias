Basic QF_S len test

  $ Chro ./simple-len.smt2
  sat (nfa)
  ((define-fun %10 () (_ String) "0000000009")
   (define-fun %7 () (_ String) "0000000010")
   (define-fun %8 () (_ String) "00000000010")
   (define-fun %9 () (_ String) "9999999999")
   (define-fun x () (_ String) "1000000000")
   (define-fun y () (_ String) "9"))
