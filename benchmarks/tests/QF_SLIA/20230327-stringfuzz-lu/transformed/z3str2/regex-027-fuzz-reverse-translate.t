regex-027-fuzz-reverse-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-027-fuzz-reverse-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "r'[y]'\r'^")
  Fatal error: exception Failure("TBD")
  TIMEOUT
