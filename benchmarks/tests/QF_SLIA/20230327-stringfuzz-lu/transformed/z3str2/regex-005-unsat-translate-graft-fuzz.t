regex-005-unsat-translate-graft-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-translate-graft-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "VVV)3Yp7l'\t'QvM:5'\t'Va")
  Fatal error: exception Failure("TBD")
  TIMEOUT
