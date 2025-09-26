regex-003-reverse-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-reverse-fuzz-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "d}iP+l6}HgQLxmFrDfE]H~`")
  Fatal error: exception Failure("TBD")
  TIMEOUT
