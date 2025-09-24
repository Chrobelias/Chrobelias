regex-016-multiply-multiply-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-multiply-multiply-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "hhhh::::vvvv]]]]hhhh::::vvvv]]]]111122223333")
  Fatal error: exception Failure("TBD")
  TIMEOUT
