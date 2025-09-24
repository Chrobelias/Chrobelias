regex-018-fuzz-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-018-fuzz-reverse.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "8t\\\\e4A3;;$)1")
  Fatal error: exception Failure("TBD")
  TIMEOUT
