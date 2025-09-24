regex-020-fuzz-graft-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-020-fuzz-graft-graft.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "c~GY*TE")
  Fatal error: exception Failure("TBD")
  TIMEOUT
