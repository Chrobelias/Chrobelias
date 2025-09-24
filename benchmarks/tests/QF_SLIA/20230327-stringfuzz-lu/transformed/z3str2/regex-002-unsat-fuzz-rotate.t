regex-002-unsat-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-fuzz-rotate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aaRqdaa`Y4}V'\\x0b''b|M4")
  Fatal error: exception Failure("TBD")
  TIMEOUT
