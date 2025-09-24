regex-027-translate-fuzz-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-027-translate-fuzz-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "sJhs}9$"")
  Fatal error: exception Failure("TBD")
  TIMEOUT
