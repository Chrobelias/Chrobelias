regex-003-graft-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-graft-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "]iUO_{k4v\\wp(~}I+]Wg!!NV)44]|eaab;' 'I'\r'H/9lzoz$N'\n''\r'3Vx*38rd=pc'-5)'\x0b'ZlJMccdd/)z,*'\x0b'_o1z")
  Fatal error: exception Failure("TBD")
  TIMEOUT
