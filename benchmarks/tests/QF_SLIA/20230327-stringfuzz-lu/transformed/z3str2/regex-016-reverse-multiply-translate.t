regex-016-reverse-multiply-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-reverse-multiply-translate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "332211YY'\n''\n'\\\\..YY'\n''\n'\\\\..")
  Fatal error: exception Failure("TBD")
  TIMEOUT
