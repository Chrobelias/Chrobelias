regex-018-reverse-reverse-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-018-reverse-reverse-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "3A")
  Fatal error: exception Failure("TBD")
  TIMEOUT
