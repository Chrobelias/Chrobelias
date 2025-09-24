regex-003-fuzz-graft-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-fuzz-graft-reverse.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "dG^9~c{'w<c'n\\\\'hAhaZCP!$dc")
  Fatal error: exception Failure("TBD")
  TIMEOUT
