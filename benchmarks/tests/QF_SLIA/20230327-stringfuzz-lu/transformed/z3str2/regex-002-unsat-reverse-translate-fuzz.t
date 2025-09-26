regex-002-unsat-reverse-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-reverse-translate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "J]E_-\\pNx6#]Ud`8%2<Mn+&s='X\\>|z")
  Fatal error: exception Failure("TBD")
  TIMEOUT
