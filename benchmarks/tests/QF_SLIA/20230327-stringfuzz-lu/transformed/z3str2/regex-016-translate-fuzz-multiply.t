regex-016-translate-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-translate-fuzz-multiply.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "LLMMgg((DD''' '' '''hhVVJJVV..00uu''\\\\xx00bb''""""FF||II##qqZZ''\\\\tt''''' '' '''0011gg''\\\\xx00bb''''\\\\xx00bb''RRPPUUdd==1133")
  Fatal error: exception Failure("TBD")
  TIMEOUT
