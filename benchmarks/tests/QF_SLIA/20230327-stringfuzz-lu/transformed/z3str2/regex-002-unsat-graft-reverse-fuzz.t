regex-002-unsat-graft-reverse-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-graft-reverse-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aW3*Ep&aa!u'\x0c''\x0b'Ea")
  Fatal error: exception Failure("TBD")
  TIMEOUT
