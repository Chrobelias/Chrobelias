regex-016-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-fuzz-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "tbckR|""zu^ac75tbF_!'' '',11/wmB")
  Fatal error: exception Failure("TBD")
  TIMEOUT
