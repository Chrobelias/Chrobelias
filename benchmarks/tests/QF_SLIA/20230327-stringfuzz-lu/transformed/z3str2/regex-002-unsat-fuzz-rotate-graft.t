regex-002-unsat-fuzz-rotate-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-fuzz-rotate-graft.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aa$!PCZahAh'\\\\n'c<w'{c~9^Ga")
  Fatal error: exception Failure("TBD")
  TIMEOUT
