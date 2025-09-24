regex-005-unsat-fuzz-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-fuzz-translate-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "YYY2q-:=~%Nz7?w;'\t'k:s?W}")
  Fatal error: exception Failure("TBD")
  TIMEOUT
