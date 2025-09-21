Basic QF_S len test

  $ Chro ./simple-len.smt2
  sat (nfa)
  ((define-fun %0 () (_ String) "0000000010")
   (define-fun %1 () (_ String) "00000000010")
   (define-fun %2 () (_ String) "9999999999")
   (define-fun %3 () (_ String) "0000000009")
   (define-fun x () (_ String) "1000000000")
   (define-fun y () (_ String) "9"))
