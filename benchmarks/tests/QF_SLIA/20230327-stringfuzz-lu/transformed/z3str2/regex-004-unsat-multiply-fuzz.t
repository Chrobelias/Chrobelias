regex-004-unsat-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "Ry5n'\r'`WYbl!9/bb/|^}]k'\r'@csa3j?6!]7u+dyNDBYle")
  Fatal error: exception Failure("TBD")
  TIMEOUT
