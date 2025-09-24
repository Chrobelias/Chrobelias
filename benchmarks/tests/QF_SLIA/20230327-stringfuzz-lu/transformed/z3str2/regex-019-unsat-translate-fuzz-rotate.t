regex-019-unsat-translate-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-019-unsat-translate-fuzz-rotate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "cdP,u8E]C\\\\h{IQjZ""""""""""")
  Fatal error: exception Failure("TBD")
  TIMEOUT
