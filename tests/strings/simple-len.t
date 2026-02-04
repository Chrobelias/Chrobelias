Basic QF_S len test

  $ Chro ./simple-len.smt2
  sat (nfa)
  (
     (define-fun x () String
      "1999999999")
     (define-fun y () String
      "9")
  )
