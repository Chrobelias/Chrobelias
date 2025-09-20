QF_EIA tests with three exponentiated vars using only NFAs

  $ Chro -bound 0 ../manyexp/3exp.smt2
  sat (nfa)
  ((define-fun %33 () (_ Int) 4)(define-fun u () (_ Int) 2)
   (define-fun z () (_ Int) 2))
  unsat
  sat (nfa)

The same tests with three exponentiated vars in the LSB mode

  $ Chro -bound 0 -lsb ../manyexp/3exp.smt2
  sat (nfa)
  ((define-fun %17 () (_ Int) 4)(define-fun u () (_ Int) 2)
   (define-fun z () (_ Int) 2))
  unsat
  sat (nfa)
