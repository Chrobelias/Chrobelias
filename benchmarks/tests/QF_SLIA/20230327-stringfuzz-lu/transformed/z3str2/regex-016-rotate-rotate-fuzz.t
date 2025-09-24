regex-016-rotate-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-rotate-rotate-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "bdAp:X@(xB]NR#'\x0b'"X82'\x0c'i.'\n'eD13")
  Fatal error: exception Failure("TBD")
  TIMEOUT
