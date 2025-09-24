regex-016-reverse-translate-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-reverse-translate-multiply.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "332211gg''\\\\tt''ZZ??gg''\\\\tt''ZZ??")
  Fatal error: exception Failure("TBD")
  TIMEOUT
