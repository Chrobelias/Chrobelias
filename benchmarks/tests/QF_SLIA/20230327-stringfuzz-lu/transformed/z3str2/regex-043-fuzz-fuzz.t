regex-043-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-043-fuzz-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "m0i!a")
  Fatal error: exception Failure("TBD")
  TIMEOUT
