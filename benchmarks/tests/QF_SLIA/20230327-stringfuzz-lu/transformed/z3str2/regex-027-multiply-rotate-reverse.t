regex-027-multiply-rotate-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-027-multiply-rotate-reverse.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "bbaabb")
  Fatal error: exception Failure("TBD")
  TIMEOUT
