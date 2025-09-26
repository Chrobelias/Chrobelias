regex-004-unsat-reverse-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-reverse-fuzz-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "ddhhVV88ppaaEEddbbaa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
