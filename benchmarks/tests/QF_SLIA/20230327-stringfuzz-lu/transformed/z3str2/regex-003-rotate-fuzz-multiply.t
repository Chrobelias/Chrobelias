regex-003-rotate-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-rotate-fuzz-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "QQff99""""<<??CCNNee..==vv''\\\\nn''$$DD**;;YYBBSS''' '' '''ee")
  Fatal error: exception Failure("TBD")
  TIMEOUT
