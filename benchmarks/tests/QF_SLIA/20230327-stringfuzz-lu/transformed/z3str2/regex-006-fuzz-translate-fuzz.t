regex-006-fuzz-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-006-fuzz-translate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "'*4t2H'\x0b''\x0c'=7GSSeM+b'PEX\\4m_GTx0>:EO")
  Fatal error: exception Failure("TBD")
  TIMEOUT
