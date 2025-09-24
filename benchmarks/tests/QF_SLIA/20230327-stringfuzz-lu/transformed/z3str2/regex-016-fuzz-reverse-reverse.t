regex-016-fuzz-reverse-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-fuzz-reverse-reverse.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "a{8o+suVbaE$!dC)dG(q:).AUbd1non4;")
  Fatal error: exception Failure("TBD")
  TIMEOUT
