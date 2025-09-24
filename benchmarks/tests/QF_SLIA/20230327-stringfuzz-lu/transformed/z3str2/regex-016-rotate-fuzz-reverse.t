regex-016-rotate-fuzz-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-rotate-fuzz-reverse.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "'' '';EM@5B13""q'1D!RW'sba""@k$P1D,k""rTfU)-']0")
  Fatal error: exception Failure("TBD")
  TIMEOUT
