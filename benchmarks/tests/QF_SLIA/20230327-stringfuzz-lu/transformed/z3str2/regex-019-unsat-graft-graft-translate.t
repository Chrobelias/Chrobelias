regex-019-unsat-graft-graft-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-019-unsat-graft-graft-translate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "kkkkk")
  Fatal error: exception Failure("TBD")
  TIMEOUT
