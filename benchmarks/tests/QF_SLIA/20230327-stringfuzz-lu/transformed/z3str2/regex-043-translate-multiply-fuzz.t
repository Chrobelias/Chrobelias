regex-043-translate-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-043-translate-multiply-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "UU~=cyU")
  Fatal error: exception Failure("TBD")
  TIMEOUT
