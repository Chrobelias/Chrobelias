regex-002-unsat-reverse-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-reverse-rotate-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "|r6&waakHZpQ'\x0b'"#&xh~66)a")
  Fatal error: exception Failure("TBD")
  TIMEOUT
