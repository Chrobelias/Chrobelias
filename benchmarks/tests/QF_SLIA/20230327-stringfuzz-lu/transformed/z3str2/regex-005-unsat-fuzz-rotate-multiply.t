regex-005-unsat-fuzz-rotate-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-fuzz-rotate-multiply.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aaaa$$!!PPCCZZaahhAAhh''\\\\\\\\nn''cc<<ww''{{cc~~99^^GGaa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
