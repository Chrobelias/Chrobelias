regex-005-unsat-fuzz-multiply-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-fuzz-multiply-multiply.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aaaaaaaa$$$$!!!!PPPPCCCCZZZZaaaahhhhAAAAhhhh''''\\\\\\\\\\\\\\\\nnnn''''cccc<<<<wwww''''{{{{cccc~~~~9999^^^^GGGGaaaa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
