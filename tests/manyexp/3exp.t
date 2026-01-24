QF_EIA tests with three exponentiated vars using only NFAs

  $ Chro -bound -1 ../manyexp/3exp.smt2
  sat (nfa)
  ((define-fun u () (_ Int) 2) (define-fun z () (_ Int) 2))
  unsat (nfa)
  sat (nfa)

The same tests with three exponentiated vars in the LSB mode

  $ Chro -bound -1 -lsb ../manyexp/3exp.smt2
  sat (nfa)
  ((define-fun u () (_ Int) 2) (define-fun z () (_ Int) 2))
  unsat (nfa)
  sat (nfa)
