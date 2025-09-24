regex-004-unsat-multiply-fuzz-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-multiply-fuzz-reverse.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "5q1t'4ddcC6wT_e|:!y'n\\'d[FDAWXXY'qmVtv""""l<MJ'b0x\\'QLuIY|KrdVJQN(d_4C7x")
  Fatal error: exception Failure("TBD")
  TIMEOUT
