regex-005-unsat-translate-translate-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-translate-translate-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "jjjjjjjjj")
  Fatal error: exception Failure("TBD")
  TIMEOUT
