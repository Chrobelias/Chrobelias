regex-005-unsat-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "XH'\x0b'OAR!CAha+5>7v[_T+a7'\t'fZ")
  Fatal error: exception Failure("TBD")
  TIMEOUT
