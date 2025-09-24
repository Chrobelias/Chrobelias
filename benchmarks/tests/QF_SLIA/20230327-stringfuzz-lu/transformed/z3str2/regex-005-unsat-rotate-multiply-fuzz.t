regex-005-unsat-rotate-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-rotate-multiply-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aaaatq7n3y9D5!=kk?jh_AaaaaPi$E|ztTa]")
  Fatal error: exception Failure("TBD")
  TIMEOUT
