regex-004-unsat-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-translate-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "6MMZ'\x0c'?XKdi'\x0b'Fg{|UhrCN_y'\n''\n'8'\x0b''|'\\fRTDo/g' 'B"-30b")
  Fatal error: exception Failure("TBD")
  TIMEOUT
