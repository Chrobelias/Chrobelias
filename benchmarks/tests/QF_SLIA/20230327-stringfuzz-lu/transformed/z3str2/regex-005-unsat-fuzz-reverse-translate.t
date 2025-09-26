regex-005-unsat-fuzz-reverse-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-fuzz-reverse-translate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "_h>9yX!E|oXE]wwEd;d_,{uRx__")
  Fatal error: exception Failure("TBD")
  TIMEOUT
