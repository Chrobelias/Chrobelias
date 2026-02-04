QF_EIA tests with three exponentiated vars using only NFAs

  $ Chro -bound -1 ../manyexp/3exp.smt2
  sat (nfa)
  (
     (define-fun u () Int
      2)
     (define-fun x () Int
      0)
     (define-fun y () Int
      0)
     (define-fun z () Int
      2)
  )
  unsat (nfa)
  sat (nfa)

The same tests with three exponentiated vars in the LSB mode

  $ Chro -bound -1 -lsb ../manyexp/3exp.smt2
  sat (nfa)
  (
     (define-fun u () Int
      2)
     (define-fun x () Int
      0)
     (define-fun y () Int
      0)
     (define-fun z () Int
      2)
  )
  unsat (nfa)
  sat (nfa)
