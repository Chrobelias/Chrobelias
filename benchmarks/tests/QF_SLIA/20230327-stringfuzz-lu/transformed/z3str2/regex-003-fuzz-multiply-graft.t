regex-003-fuzz-multiply-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-fuzz-multiply-graft.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "ccdd$$!!PPCCZZaahhAAhh''\\\\\\\\nn''cc<<ww''{{cc~~99^^GGdd")
  Fatal error: exception Failure("TBD")
  TIMEOUT
