regex-022-unsat-rotate-translate-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-022-unsat-rotate-translate-multiply.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "@@''\\\\xx00cc''")
  Fatal error: exception Failure("TBD")
  TIMEOUT
