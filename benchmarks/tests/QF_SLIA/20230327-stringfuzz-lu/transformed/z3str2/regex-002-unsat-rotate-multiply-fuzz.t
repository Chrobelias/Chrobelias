regex-002-unsat-rotate-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-rotate-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "5kpCJI^aa?^O*k|aaaaa5}&\\+'\r'-}'\x0c'>7' ':NoXkZ=Caa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
