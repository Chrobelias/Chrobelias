regex-004-unsat-translate-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-translate-fuzz-multiply.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "AABBTTGGiiSSBBhh;;VVtt")
  Fatal error: exception Failure("TBD")
  TIMEOUT
