regex-018-fuzz-fuzz-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-018-fuzz-fuzz-reverse.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "k@b'n\\\\")
  Fatal error: exception Failure("TBD")
  TIMEOUT
