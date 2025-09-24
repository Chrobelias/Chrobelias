regex-003-fuzz-translate-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-fuzz-translate-multiply.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "ZZ99RR''\\\\xx00cc''==::__``zz@@OOzzllzz22yy''++zz@@LL00IIzzGGLL11PPIIEE**SS66QQ//TTzz@@''\\\\xx00bb''zz''\\\\xx00cc''__))))WW##>>")
  Fatal error: exception Failure("TBD")
  TIMEOUT
