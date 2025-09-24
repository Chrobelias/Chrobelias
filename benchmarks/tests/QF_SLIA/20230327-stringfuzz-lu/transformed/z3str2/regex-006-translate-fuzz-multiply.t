regex-006-translate-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-006-translate-fuzz-multiply.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "OOXX%%33tt&&RRllRR")
  Fatal error: exception Failure("TBD")
  TIMEOUT
