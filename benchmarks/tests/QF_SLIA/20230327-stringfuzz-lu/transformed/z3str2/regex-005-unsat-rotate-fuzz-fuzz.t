regex-005-unsat-rotate-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-rotate-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aa=#P4c2T`%[]gr(u-hXS"]f^aD=]T")
  Fatal error: exception Failure("TBD")
  TIMEOUT
