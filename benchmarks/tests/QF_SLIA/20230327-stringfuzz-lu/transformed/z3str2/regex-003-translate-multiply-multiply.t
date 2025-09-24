regex-003-translate-multiply-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-translate-multiply-multiply.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\((((NNNN''''\\\\\\\\\\\\\\\\xxxx0000bbbb'''']]]]\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\((((\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\((((NNNN")
  Fatal error: exception Failure("TBD")
  TIMEOUT
