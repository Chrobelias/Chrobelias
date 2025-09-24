regex-002-unsat-reverse-reverse-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-reverse-reverse-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "a'z5a3%S/9'\n'a@aa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
