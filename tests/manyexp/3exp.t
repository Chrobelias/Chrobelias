QF_EIA tests with three exponentiated vars using only NFAs

  $ Chro -bound 0 ../manyexp/3exp.smt2
  sat (nfa)
  %33 = 4; u = 2; z = 2; 
  unsat

The same tests with three exponentiated vars in the LSB mode

  $ Chro -bound 0 -lsb ../manyexp/3exp.smt2
  sat (nfa)
  %17 = 4; u = 2; z = 2; 
  unsat
