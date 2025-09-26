regex-003-multiply-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-multiply-fuzz-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "ccdd''\\\\xx00bb''LLHHKK11mmaabbccddcczz%%44""""CC__FFttPPOO==''\\\\tt''''\\\\xx00bb''[[llrrCCSSIIEEMMEE~~''\\\\xx00cc''YY11$$''\\\\tt''}}~~33dd''\\\\nn''==33wwZZnn[[yyBB''\\\\nn''00__66NNZZRRAA")
  Fatal error: exception Failure("TBD")
  TIMEOUT
