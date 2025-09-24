regex-006-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-006-translate-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "x~Bxw>' '^_cj8HIAB9rg9,0-{'LYE\\q&0MiI)lD!gx0tg0p|AJi1)")
  Fatal error: exception Failure("TBD")
  TIMEOUT
