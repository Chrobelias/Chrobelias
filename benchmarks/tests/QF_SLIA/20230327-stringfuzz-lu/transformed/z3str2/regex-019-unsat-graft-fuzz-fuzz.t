regex-019-unsat-graft-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-019-unsat-graft-fuzz-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "dRC#ztu/n+YS")
  Fatal error: exception Failure("TBD")
  TIMEOUT
