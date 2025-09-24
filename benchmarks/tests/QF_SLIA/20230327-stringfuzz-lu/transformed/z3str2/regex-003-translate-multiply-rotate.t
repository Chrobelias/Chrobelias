regex-003-translate-multiply-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-translate-multiply-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "\\\\\\\\\\\\\\\\((NN''\\\\\\\\xx00bb'']]\\\\\\\\\\\\\\\\((\\\\\\\\\\\\\\\\((NN")
  Fatal error: exception Failure("TBD")
  TIMEOUT
