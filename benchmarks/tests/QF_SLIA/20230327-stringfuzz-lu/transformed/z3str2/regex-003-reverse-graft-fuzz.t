regex-003-reverse-graft-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-reverse-graft-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "/**)BBD.3\\aOIXce-Nbae{Uu%df8Uv[kzJ")
  Fatal error: exception Failure("TBD")
  TIMEOUT
