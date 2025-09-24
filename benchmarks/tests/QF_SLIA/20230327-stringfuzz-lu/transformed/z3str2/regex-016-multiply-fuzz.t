regex-016-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "aC'\t'%-7j'\x0c'+z#\\i5,Vv=Bxut:Us/Y=abb<,)DP[W+t|]UEJU&'\n'.2'\n'|kF8&-sCB'\t'L\\+~TxA2<(l' '{LGA4jK")
  Fatal error: exception Failure("TBD")
  TIMEOUT
