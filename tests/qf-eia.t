Basic QF_EIA tests

  $ Chro ./qf-eia.smt2
  sat (nfa)
  unsat
  unsat
  sat (underappox)
  unsat
  sat (underappox)
  unsat
  unsat
  unsat
  sat (underappox)
  unsat
  sat (underappox)
  unsat
  sat ()
sat

Test ExEy y >=0 x & 2**y = x & x > 4

  $ Chro ./examples/QF_EIA/basic-exp-sat.smt2
  sat (nfa)

Test Ex x > 2**x

  $ Chro ./examples/QF_EIA/basic-exp-unsat.smt2
  unsat

Test Frobenius coin problem with exponential restrictions

  $ Chro -bound 0 -no-over-approx ./examples/fcp_7_11_with_exps.smt2
  sat (nfa)

Test Double exponent theorem

  $ Chro ./examples/double_exp.smt2
  unsat
