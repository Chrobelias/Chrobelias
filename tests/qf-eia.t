Basic QF_EIA tests

  $ Chro ./qf-eia.smt2
  sat ; nfa
  unsat
  unsat
  sat ; underapprox1
  unsat
  sat ; underapprox1
  unsat
  unsat
  unsat
  sat ; underapprox1
  unsat
  sat ; underapprox1
  unsat
  sat ; presimpl

Basic QF_EIA tests using only NFAs

  $ Chro -bound -1 -no-over-approx ./qf-eia.smt2
  sat ; nfa
  unsat
  unsat
  sat ; nfa
  unsat
  sat ; nfa
  unsat
  unsat
  unsat
  sat ; nfa
  unsat
  sat ; nfa
  unsat
  sat ; presimpl

Same basic QF_EIA tests using only NFAs but in the LSB mode

  $ Chro -lsb -bound -1 -no-over-approx ./qf-eia.smt2
  sat ; nfa
  unsat
  unsat
  sat ; nfa
  unsat
  sat ; nfa
  unsat
  unsat
  unsat
  sat ; nfa
  unsat
  sat ; nfa
  unsat
  sat ; presimpl

Test ExEy y >=0 x & 2**y = x & x > 4

  $ Chro ./examples/QF_EIA/basic-exp-sat.smt2
  sat ; nfa

Test Ex x > 2**x

  $ Chro ./examples/QF_EIA/basic-exp-unsat.smt2
  unsat

Test Frobenius coin problem with exponential restrictions

  $ timeout 2 Chro -bound 0 -no-over-approx ./examples/fcp_7_11_with_exps.smt2
  sat ; nfa

Test Double exponent theorem

  $ Chro ./examples/double_exp.smt2
  unsat

Test EXP-solver simplified problems

  $ Chro ./examples/hash_3_6.smt2
  sat ; nfa
  ((define-fun u () (_ Int) 0)
   (define-fun v () (_ Int) 0)
   (define-fun w () (_ Int) 20575685)
   (define-fun x () (_ String) "123454110"))

  $ Chro ./examples/hash_130_137.smt2
  sat ; nfa
  ((define-fun u () (_ Int) 0)
   (define-fun v () (_ Int) 0)
   (define-fun w () (_ Int) 8847600088476000884760008847600088476000884760008965597)
   (define-fun x () (_ String) "1212121212121212121212121212121212121212121212121228286789"))
