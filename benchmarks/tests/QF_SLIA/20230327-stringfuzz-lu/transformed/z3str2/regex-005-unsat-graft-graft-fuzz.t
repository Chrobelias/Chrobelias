regex-005-unsat-graft-graft-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-graft-graft-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "K5qm|as,'\n'' '2%ss0A#!8%EfP!#|\\3B")
  Fatal error: exception Failure("TBD")
  TIMEOUT
