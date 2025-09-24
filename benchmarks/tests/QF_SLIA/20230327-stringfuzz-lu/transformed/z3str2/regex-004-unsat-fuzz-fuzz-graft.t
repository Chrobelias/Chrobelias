regex-004-unsat-fuzz-fuzz-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-fuzz-fuzz-graft.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aJ+'\\x0b'v*$8d\\\\I'\\n'>bNd")
  Fatal error: exception Failure("TBD")
  TIMEOUT
