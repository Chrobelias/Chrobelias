regex-022-unsat-multiply-translate-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-022-unsat-multiply-translate-graft.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "wwDD")
  Fatal error: exception Failure("TBD")
  TIMEOUT
