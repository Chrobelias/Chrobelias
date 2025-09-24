regex-004-unsat-fuzz-fuzz-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-fuzz-fuzz-translate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "OgV_'\n'e0H_Q'\t'z8d'\n''\n'U_'\n'Z_YH(d")
  Fatal error: exception Failure("TBD")
  TIMEOUT
