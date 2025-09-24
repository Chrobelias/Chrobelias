regex-004-unsat-fuzz-multiply-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-fuzz-multiply-rotate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aabb$$!!PPddccdd")
  Fatal error: exception Failure("TBD")
  TIMEOUT
