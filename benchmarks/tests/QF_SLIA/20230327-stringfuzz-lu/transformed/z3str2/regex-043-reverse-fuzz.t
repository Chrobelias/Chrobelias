regex-043-reverse-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-043-reverse-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
