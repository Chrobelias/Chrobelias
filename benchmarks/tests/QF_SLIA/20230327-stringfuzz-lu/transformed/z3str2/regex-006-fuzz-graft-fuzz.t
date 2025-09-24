regex-006-fuzz-graft-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-006-fuzz-graft-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "efM+$!:^FrD8}1o+2(c")
  Fatal error: exception Failure("TBD")
  TIMEOUT
