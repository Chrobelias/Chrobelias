regex-018-rotate-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-018-rotate-multiply-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "122'\x0b'5jkm~wXD9lKS?t'oIf'\n'%KH[B")
  Fatal error: exception Failure("TBD")
  TIMEOUT
