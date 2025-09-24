regex-005-unsat-graft-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-graft-multiply.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aaaaaaaaaaaaaaaaaa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
