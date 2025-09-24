regex-002-unsat-fuzz-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-fuzz-reverse.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "4M|b''b0x\\'V}4Y`aadqRaa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
