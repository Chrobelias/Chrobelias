regex-016-graft-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-graft-fuzz-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "uu[[::aaUUVV11CCrr9933((!!((//{{PP%%MMddbbcc~~ZZ11")
  Fatal error: exception Failure("TBD")
  TIMEOUT
