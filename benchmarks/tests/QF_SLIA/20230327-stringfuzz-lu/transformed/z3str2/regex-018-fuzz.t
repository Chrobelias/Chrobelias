regex-018-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-018-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "123o")
  Fatal error: exception Failure("TBD")
  TIMEOUT
