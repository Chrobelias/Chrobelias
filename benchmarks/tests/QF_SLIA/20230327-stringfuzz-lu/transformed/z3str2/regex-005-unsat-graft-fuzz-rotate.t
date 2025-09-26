regex-005-unsat-graft-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-graft-fuzz-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "a~%OwHp\\\\]/2taD~}Id|n@PfeJ""<(w3")
  Fatal error: exception Failure("TBD")
  TIMEOUT
