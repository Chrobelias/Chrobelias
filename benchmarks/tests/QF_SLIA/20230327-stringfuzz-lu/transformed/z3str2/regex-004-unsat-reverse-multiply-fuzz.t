regex-004-unsat-reverse-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-reverse-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "((}w{S6d+k9a|JPhY,3uOkZ'\r'wxg:`P;HVci'_bccV1*W>bLbwMi3pu")
  Fatal error: exception Failure("TBD")
  TIMEOUT
