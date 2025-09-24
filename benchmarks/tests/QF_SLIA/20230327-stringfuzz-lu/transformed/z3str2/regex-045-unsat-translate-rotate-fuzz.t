regex-045-unsat-translate-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-045-unsat-translate-rotate-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "H")
  Fatal error: exception Failure("TBD")
  TIMEOUT
