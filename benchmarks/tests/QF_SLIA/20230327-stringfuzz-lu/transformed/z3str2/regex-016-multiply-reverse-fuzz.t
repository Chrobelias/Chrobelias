regex-016-multiply-reverse-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-multiply-reverse-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "3m!DQi{N#<f#BZ='\x0b'G{]x|XV@x3dBQi+Neyg7mlE%+SZ'\n'0*3=,hw*~\\'\x0b'3'\r'0n&' 'adba")
  Fatal error: exception Failure("TBD")
  TIMEOUT
