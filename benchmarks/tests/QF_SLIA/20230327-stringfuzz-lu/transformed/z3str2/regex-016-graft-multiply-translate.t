regex-016-graft-multiply-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-graft-multiply-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "hhjj'\x0c''\x0c'>>hhjj'\x0c''\x0c'>>112233")
  Fatal error: exception Failure("TBD")
  TIMEOUT
