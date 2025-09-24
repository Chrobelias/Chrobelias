regex-002-unsat-translate-fuzz-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-translate-fuzz-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "'\n'&|5$^Tp"CPJJ'\x0c'tC'\r't")
  Fatal error: exception Failure("TBD")
  TIMEOUT
