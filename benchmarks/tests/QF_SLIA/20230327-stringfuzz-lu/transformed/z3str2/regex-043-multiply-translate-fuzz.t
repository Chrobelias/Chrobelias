regex-043-multiply-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-043-multiply-translate-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "v1QmOPi")
  Fatal error: exception Failure("TBD")
  TIMEOUT
