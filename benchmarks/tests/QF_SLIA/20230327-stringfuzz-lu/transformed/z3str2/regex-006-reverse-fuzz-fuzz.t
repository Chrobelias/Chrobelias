regex-006-reverse-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-006-reverse-fuzz-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "b+6/UfD"<;q/zwZ1d}x#(\\>F")
  Fatal error: exception Failure("TBD")
  TIMEOUT
