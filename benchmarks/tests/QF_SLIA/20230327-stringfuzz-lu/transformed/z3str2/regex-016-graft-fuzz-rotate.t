regex-016-graft-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-graft-fuzz-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "u[:aUV1Cr93(!(/{P%Mdbc~Z1")
  Fatal error: exception Failure("TBD")
  TIMEOUT
