regex-005-unsat-fuzz-graft-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-fuzz-graft-translate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "ii?\\yQUi]<]AMM"ADWvA'\r'Dq9._i")
  Fatal error: exception Failure("TBD")
  TIMEOUT
