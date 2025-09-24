regex-005-unsat-rotate-graft-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-rotate-graft-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "axaSZ|rde4'\n'a7mmQjFD")
  Fatal error: exception Failure("TBD")
  TIMEOUT
