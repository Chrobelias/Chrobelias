regex-003-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "hra4d53'\x0b'b1&\\[Ji"X[?0!")
  Fatal error: exception Failure("TBD")
  TIMEOUT
