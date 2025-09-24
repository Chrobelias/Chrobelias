regex-045-unsat-fuzz-fuzz-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-045-unsat-fuzz-fuzz-graft.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "s")
  Fatal error: exception Failure("TBD")
  TIMEOUT
