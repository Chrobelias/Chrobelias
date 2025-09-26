regex-005-unsat-rotate-reverse-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-rotate-reverse-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "5628Z:x[Vaaqa'\x0c'A)wu@TVqLy8=g+D' 'P")
  Fatal error: exception Failure("TBD")
  TIMEOUT
