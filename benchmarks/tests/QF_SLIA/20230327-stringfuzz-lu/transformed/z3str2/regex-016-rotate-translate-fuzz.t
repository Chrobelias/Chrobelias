regex-016-rotate-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-rotate-translate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "4' '~NsEeZs&YOS'\t'bD9zR$Y`'\x0b'=%`8H4zZgb797rVk")
  Fatal error: exception Failure("TBD")
  TIMEOUT
