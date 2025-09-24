regex-002-unsat-reverse-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-reverse-fuzz-rotate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "fYrfa]+kF!U3x6Q*vaaa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
