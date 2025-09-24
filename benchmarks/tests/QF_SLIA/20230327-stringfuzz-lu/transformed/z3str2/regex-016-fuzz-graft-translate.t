regex-016-fuzz-graft-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-fuzz-graft-translate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "{H8$/Tfg~{U|sL[CLr.SVCk'\x0c'J~L1%$%4B")
  Fatal error: exception Failure("TBD")
  TIMEOUT
