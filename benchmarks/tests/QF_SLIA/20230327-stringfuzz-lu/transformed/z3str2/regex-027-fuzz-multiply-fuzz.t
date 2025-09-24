regex-027-fuzz-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-027-fuzz-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "eqK'\n'`Tpo4(F`N~~tk;o'\x0b'fI0M'\x0c'k$w"YUE&^(fg?")
  Fatal error: exception Failure("TBD")
  TIMEOUT
