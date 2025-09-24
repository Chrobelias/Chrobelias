regex-020-fuzz-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-020-fuzz-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "v7n")
  Fatal error: exception Failure("TBD")
  TIMEOUT
