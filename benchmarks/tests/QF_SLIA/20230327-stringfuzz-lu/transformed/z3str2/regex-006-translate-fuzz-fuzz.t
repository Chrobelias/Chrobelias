regex-006-translate-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-006-translate-fuzz-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "O)aE,0/U5+%3}rd\\<?F>z")
  Fatal error: exception Failure("TBD")
  TIMEOUT
