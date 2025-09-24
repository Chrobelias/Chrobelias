regex-005-unsat-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-fuzz-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aaaa~5F;'\\t'3")
  Fatal error: exception Failure("TBD")
  TIMEOUT
