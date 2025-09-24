regex-003-graft-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-graft-fuzz-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "?A8R'\n'w`'\t''N5)0' 'S'\n'xx0b'L]'Q*U<=(=Q}-"{+8~+?#-E8.idW`{B^ac'qY'\x0c'L->D2tf99M5])Ig{)Rt9IZ~10KVw=-3H3'\r'"c;")
  Fatal error: exception Failure("TBD")
  TIMEOUT
