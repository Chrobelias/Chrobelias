regex-002-unsat-reverse-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-reverse-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "UUUUUUUUU")
  Fatal error: exception Failure("TBD")
  TIMEOUT
