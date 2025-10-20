Basic LIA tests

  $ CHRO_OMIT_Z3_MODEL=1 OCAMLRUNPARAM='b=0' Chro -bound 0 -no-over-approx ./lia.smt2
  sat (presimpl)
  unsat
  sat (presimpl)
  sat (presimpl)
  sat (under I)
  sat (under I)
  sat (under I)
  unsat
  sat (under I)
  sat (under I)
  sat (under I)
  unsat
  sat (under I)
  unsat
  unsat
  sat (under I)
  unsat
  sat (under I)

Test Frobenious coin problem for 7 and 11

  $ Chro -bound -1 -no-over-approx examples/LIA/fcp_7_11.smt2 || echo TIMEOUT | sed 's/[[:space:]]*$//'
  sat (nfa)
  ((define-fun P () (_ Int) 59))

Test Frobenious coin problem for 7, 11, and 13

  $ Chro -bound -1 -no-over-approx examples/LIA/fcp_7_11_13.smt2 | sed 's/[[:space:]]*$//'
  sat (nfa)
  ((define-fun P () (_ Int) 30))

Test Frobenious coin problem for 2 and 4

  $ Chro -bound 4 -no-over-approx examples/LIA/fcp_2_4.smt2
  unsat
  no model

Test for all nats exists bigger

  $ Chro -bound 5 -no-over-approx examples/LIA/for-all-nats-exists-bigger.smt2
  sat (under I)
