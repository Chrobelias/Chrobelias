regex-005-unsat-translate-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-translate-reverse.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x ">>>>>>>>>")
  Fatal error: exception Failure("TBD")
  TIMEOUT
