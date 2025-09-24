regex-005-unsat-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aaaaa@bF1J?]>'\r'_JE+V;5vCa.'08<,aTR]?R:SoAal'?J'\t'(8u:$P'\r'!.w'\x0b'I2[ozU$N5ea.<N3'\x0c'Rg'\x0b'1%U")
  Fatal error: exception Failure("TBD")
  TIMEOUT
