regex-002-unsat-graft-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-graft-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aa\\Ys>iaaK1(:#2o'cpL")
  Fatal error: exception Failure("TBD")
  TIMEOUT
