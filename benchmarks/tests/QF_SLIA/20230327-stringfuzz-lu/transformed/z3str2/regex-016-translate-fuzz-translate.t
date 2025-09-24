regex-016-translate-fuzz-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-translate-fuzz-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x ">D&CP;L;`XKX'\t'0'\x0b';A,0y;!!ft.lRB;AT;;L;01&;A,0y;;A,0y;bx*a}13")
  Fatal error: exception Failure("TBD")
  TIMEOUT
