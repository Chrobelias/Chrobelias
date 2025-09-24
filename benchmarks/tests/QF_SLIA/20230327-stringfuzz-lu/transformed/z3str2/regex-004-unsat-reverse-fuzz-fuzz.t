regex-004-unsat-reverse-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-reverse-fuzz-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "Cu>k+ush.V[h={k=#n38f777'\n'ujDr@==/vTBTEdb")
  Fatal error: exception Failure("TBD")
  TIMEOUT
