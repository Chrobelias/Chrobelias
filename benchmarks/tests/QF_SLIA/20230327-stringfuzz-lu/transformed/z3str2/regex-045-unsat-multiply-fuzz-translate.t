regex-045-unsat-multiply-fuzz-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-045-unsat-multiply-fuzz-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "LJ!H")
  Fatal error: exception Failure("TBD")
  TIMEOUT
