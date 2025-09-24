regex-003-fuzz-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-fuzz-graft.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "I9bm@d+|'\\r'Z'2k=-'\\x0c'Ax1Jco(U6q%?'\\t'm+aagje")
  Fatal error: exception Failure("TBD")
  TIMEOUT
