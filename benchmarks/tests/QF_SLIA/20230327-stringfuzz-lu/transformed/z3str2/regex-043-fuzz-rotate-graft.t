regex-043-fuzz-rotate-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-043-fuzz-rotate-graft.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x """""Gv")
  Fatal error: exception Failure("TBD")
  TIMEOUT
