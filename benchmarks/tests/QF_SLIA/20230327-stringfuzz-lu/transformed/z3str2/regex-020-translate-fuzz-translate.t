regex-020-translate-fuzz-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-020-translate-fuzz-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "'a'P_0b'96'\t''\t'&sCCCC|E")
  Fatal error: exception Failure("TBD")
  TIMEOUT
