regex-045-unsat-multiply-multiply-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-045-unsat-multiply-multiply-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aaaaaaaabbbbbbbbcccccccc")
  Fatal error: exception Failure("TBD")
  TIMEOUT
