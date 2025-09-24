regex-004-unsat-fuzz-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-fuzz-fuzz-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aaJJ++''\\\\xx00bb''vv**$$88dd\\\\\\\\II''\\\\nn''>>bbNNdd")
  Fatal error: exception Failure("TBD")
  TIMEOUT
