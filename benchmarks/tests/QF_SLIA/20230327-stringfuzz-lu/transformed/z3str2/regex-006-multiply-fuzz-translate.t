regex-006-multiply-fuzz-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-006-multiply-fuzz-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "_#fy__oyymlf)j/yl'\x0b'3f/f}]&g7V")
  Fatal error: exception Failure("TBD")
  TIMEOUT
