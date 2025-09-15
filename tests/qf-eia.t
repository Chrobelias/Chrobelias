Basic QF_EIA tests

  $ Chro ./qf-eia.smt2
  sat (nfa)
  unsat
  unsat
  sat (underapprox1)
  unsat
  sat (underapprox1)
  unsat
  unsat
  unsat
  sat (underapprox1)
  unsat
  sat (underapprox1)
  unsat
  sat (presimpl)
  sat (underapprox1)
  %20 = 4; u = 2; z = 2; 

Basic QF_EIA tests using only NFAs

  $ Chro -bound -1 -no-over-approx ./qf-eia.smt2
  sat (nfa)
  unsat
  unsat
  sat (nfa)
  unsat
  sat (nfa)
  unsat
  unsat
  unsat
  sat (nfa)
  unsat
  sat (nfa)
  unsat
  sat (presimpl)
  sat (nfa)
  %57 = 4; u = 2; z = 2; 

Same basic QF_EIA tests using only NFAs but in the LSB mode

  $ Chro -lsb -bound -1 -no-over-approx ./qf-eia.smt2
  sat (nfa)
  unsat
  unsat
  sat (nfa)
  unsat
  sat (nfa)
  unsat
  unsat
  unsat
  sat (nfa)
  unsat
  sat (nfa)
  unsat
  sat (presimpl)
  sat (nfa)
  %29 = 4; u = 2; z = 2; 

Test ExEy y >=0 x & 2**y = x & x > 4

  $ Chro ./examples/QF_EIA/basic-exp-sat.smt2
  sat (nfa)

Test Ex x > 2**x

  $ Chro ./examples/QF_EIA/basic-exp-unsat.smt2
  unsat

Test Frobenius coin problem with exponential restrictions

  $ timeout 2 Chro -bound 0 -no-over-approx ./examples/fcp_7_11_with_exps.smt2
  sat (nfa)

Test Double exponent theorem

  $ Chro ./examples/double_exp.smt2
  unsat
