regex-003-translate-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-translate-fuzz-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "\\\\\\\\\\\\\\\\NN''00||++||''\\\\rr''``SS!!<<11JJii==11ddTT\\\\\\\\33kkmmcckkEEqq''\\\\nn''""""hhOOzzEEOO{{''RR99**&&""""((")
  Fatal error: exception Failure("TBD")
  TIMEOUT
