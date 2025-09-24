regex-003-graft-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-graft-translate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "K*x3Zf&XZ/;F!0~=V\\R]Uw6hZ:\\8")
  Fatal error: exception Failure("TBD")
  TIMEOUT
