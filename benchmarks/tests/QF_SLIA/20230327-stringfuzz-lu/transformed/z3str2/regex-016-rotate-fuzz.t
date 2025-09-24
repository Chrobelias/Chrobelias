regex-016-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-rotate-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "bu9)aVx'\x0c'K8iJi/g6Vvbcdag")
  Fatal error: exception Failure("TBD")
  TIMEOUT
