regex-027-rotate-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-027-rotate-rotate-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "5&%t6")
  Fatal error: exception Failure("TBD")
  TIMEOUT
