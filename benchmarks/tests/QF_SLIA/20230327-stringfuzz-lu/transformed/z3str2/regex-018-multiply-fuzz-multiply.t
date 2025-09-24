regex-018-multiply-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-018-multiply-fuzz-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "==YYgg@@FF%%;;>>''\\\\rr''--^^VV<<jj55vv**}}>>TT''' '' '''AAjjJJ88,,")
  Fatal error: exception Failure("TBD")
  TIMEOUT
