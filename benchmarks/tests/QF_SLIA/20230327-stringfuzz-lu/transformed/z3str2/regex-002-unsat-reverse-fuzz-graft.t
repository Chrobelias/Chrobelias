regex-002-unsat-reverse-fuzz-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-reverse-fuzz-graft.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "fYrfa]+kF!U3x6Q*vaaa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
