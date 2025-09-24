regex-043-multiply-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-043-multiply-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aF2JCi3n^&@GRK7i3Oaa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
