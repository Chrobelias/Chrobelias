regex-019-unsat-reverse-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-019-unsat-reverse-multiply-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "MEV}~.'\n'W_Q..:qtQ3oQf.")
  Fatal error: exception Failure("TBD")
  TIMEOUT
