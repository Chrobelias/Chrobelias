regex-018-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-018-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "1}3$'\x0b'?~l0,/2BA,]'\x0c'T(U{A")
  Fatal error: exception Failure("TBD")
  TIMEOUT
