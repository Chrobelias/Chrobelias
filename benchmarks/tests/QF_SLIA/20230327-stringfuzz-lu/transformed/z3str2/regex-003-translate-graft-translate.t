regex-003-translate-graft-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-translate-graft-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "SSSS%'\n'GSS^0vG$SSSS%SSSS%'\n'")
  Fatal error: exception Failure("TBD")
  TIMEOUT
