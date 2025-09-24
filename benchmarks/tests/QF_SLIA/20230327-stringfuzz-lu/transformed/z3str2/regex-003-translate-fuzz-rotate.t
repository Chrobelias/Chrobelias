regex-003-translate-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-translate-fuzz-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "\\\\\\\\N'0|+|'\\r'`S!<1Ji=1dT\\\\3kmckEq'\\n'""hOzEO{'R9*&""(")
  Fatal error: exception Failure("TBD")
  TIMEOUT
