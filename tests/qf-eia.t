Basic QF_EIA tests

  $ Chro ./qf-eia.smt2
  sat (under int)
  unsat (nfa)
  unsat (nfa)
  sat (under int)
  unsat (nfa)
  sat (under int)
  unsat (nfa)
  unsat (nfa)
  unsat (nfa)
  sat (under int)
  unsat (nfa)
  sat (nfa)
  unsat (nfa)
  sat (presimpl int)

Basic QF_EIA tests using only NFAs

  $ Chro -bound -1 -no-over ./qf-eia.smt2
  sat (nfa)
  unsat (nfa)
  unsat (nfa)
  sat (nfa)
  unsat (nfa)
  sat (nfa)
  unsat (nfa)
  unsat (nfa)
  unsat (nfa)
  sat (simpl)
  unsat (nfa)
  sat (nfa)
  unsat (nfa)
  sat (presimpl int)

Same basic QF_EIA tests using only NFAs but in the LSB mode

  $ Chro -lsb -bound -1 -no-over ./qf-eia.smt2
  sat (nfa)
  unsat (nfa)
  unsat (nfa)
  sat (nfa)
  unsat (nfa)
  sat (nfa)
  unsat (nfa)
  unsat (nfa)
  unsat (nfa)
  sat (simpl)
  unsat (nfa)
  sat (nfa)
  unsat (nfa)
  sat (presimpl int)

Test ExEy y >=0 x & 2**y = x & x > 4

  $ Chro ./examples/QF_EIA/basic-exp-sat.smt2
  sat (under int)

Test Ex x > 2**x

  $ Chro ./examples/QF_EIA/basic-exp-unsat.smt2
  unsat (over)

Test ExEyEz y = 2**x & z = 2**y & z mod 10 = 6

  $ Chro -bound -1 ./examples/QF_EIA/double_exp-10-sat.smt2
  sat (nfa)

Test ExEyEz y = 2**x & z = 2**y & z mod 100 = 36

  $ Chro ./examples/QF_EIA/double_exp-100-sat.smt2
  sat (nfa)
  (
     (define-fun x () Int
      4)
     (define-fun y () Int
      16)
     (define-fun z () Int
      65536)
  )

Test ExEyEz y = 2**x & z = 2**y & z mod 100 = 36 with -lsb

  $ Chro ./examples/QF_EIA/double_exp-100-sat.smt2 -lsb
  sat (nfa)
  (
     (define-fun x () Int
      4)
     (define-fun y () Int
      16)
     (define-fun z () Int
      65536)
  )

Test Frobenius coin problem with exponential restrictions (MS: omit due to quantifier alternations)

$ timeout 2 Chro -bound 0 -no-over ./examples/fcp_7_11_with_exps.smt2
sat (nfa)

Test Double exponent theorem

  $ Chro ./examples/double_exp.smt2
  unsat (nfa)

Test EXP-solver simplified problems

  $ Chro ./examples/hash_3_6.smt2
  sat (nfa)
  (
     (define-fun u () Int
      1)
     (define-fun v () Int
      3)
     (define-fun w () Int
      20576666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666667)
     (define-fun x () String
      "123459999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
  )

  $ Chro ./examples/hash_130_137.smt2
  sat (nfa)
  (
     (define-fun u () Int
      0)
     (define-fun v () Int
      0)
     (define-fun w () Int
      89655680896556808965568089655680896556808965568089655680896556808965568089655680896556808965597)
     (define-fun x () String
      "12282828282828282828282828282828282828282828282828282828282828282828282828282828282828282828286789")
  )
