regex-045-unsat-translate-translate-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-045-unsat-translate-translate-graft.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "?m=")
  Fatal error: exception Failure("TBD")
  TIMEOUT
