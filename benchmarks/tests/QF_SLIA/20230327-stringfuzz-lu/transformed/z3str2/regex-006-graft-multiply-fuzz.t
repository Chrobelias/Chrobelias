regex-006-graft-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-006-graft-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "9S'\x0c'b'\x0c'0XZZDa9=`dYcaab")
  Fatal error: exception Failure("TBD")
  TIMEOUT
