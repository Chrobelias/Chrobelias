Basic QF_EIA tests

  $ Chro ./qf-eia.smt2
  sat
  unsat
  unsat
  sat
  unsat
  sat
  unsat
  unsat
  unsat
  sat
  unsat
  sat
  unsat
  sat
  unsat

Test ExEy y >=0 x & 2**y = x & x > 4

  $ Chro ./examples/QF_EIA/basic-exp-sat.smt2
  sat

Test Ex x > 2**x

  $ Chro ./examples/QF_EIA/basic-exp-unsat.smt2
  unsat

Test Frobenius coin problem with exponential restrictions

  $ Chro ./examples/fcp_7_11_with_exps.smt2
  sat
