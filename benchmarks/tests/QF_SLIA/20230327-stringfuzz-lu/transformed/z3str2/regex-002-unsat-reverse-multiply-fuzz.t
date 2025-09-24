regex-002-unsat-reverse-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-reverse-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aaaa9aaH,^Ef'\x0c';'\x0b',P_R7?&0'\t'R-9vQ(q'\t'&aaa$-aa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
