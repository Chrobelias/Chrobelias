regex-019-unsat-reverse-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-019-unsat-reverse-fuzz-multiply.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "gg!!''' '' '''qqGG""""JJ}}''\\\\tt''11")
  Fatal error: exception Failure("TBD")
  TIMEOUT
