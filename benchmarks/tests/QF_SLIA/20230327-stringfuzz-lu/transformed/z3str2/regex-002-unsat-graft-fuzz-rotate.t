regex-002-unsat-graft-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-graft-fuzz-rotate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "a|Z}`<9-T2:EvMe1aaa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
