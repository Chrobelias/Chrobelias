regex-003-translate-reverse-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-translate-reverse-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "uiM2wYrAU7s(\\\\r~<qd`Wensl(Qd=(8H\\]'bfTPlf'\x0b'B0\\QiYG1f/F'R\\3:b'\r'.,2wv{z^4\\\\Z=?(8")
  Fatal error: exception Failure("TBD")
  TIMEOUT
