regex-027-graft-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-027-graft-translate-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "P]`X~TR")
  Fatal error: exception Failure("TBD")
  TIMEOUT
