regex-020-multiply-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-020-multiply-multiply-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "N5*b'\x0c';DWrHPaa'\x0b':tnU9kZ|ab2'\x0b'Gv/F0#uga")
  Fatal error: exception Failure("TBD")
  TIMEOUT
