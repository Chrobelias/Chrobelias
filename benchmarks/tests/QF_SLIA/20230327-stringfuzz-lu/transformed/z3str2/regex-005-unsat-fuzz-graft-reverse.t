regex-005-unsat-fuzz-graft-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-fuzz-graft-reverse.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "aG^9~c{'w<c'n\\\\'hAhaZCP!$aa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
