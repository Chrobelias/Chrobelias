regex-002-unsat-multiply-fuzz-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-multiply-fuzz-translate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "Wx?Te~`-1""g.%y=HK?n4PN'\x0c']k'\x0c'C<-8&.()n5&"!nkSK$`LAb&>''\x0b'At6!N/^af'\x0c']`'\x0c'0""K0'x>AY|0}p'\x0c']E0V'\x0c':'\x0c']E0''\x0c'}F"""")
  Fatal error: exception Failure("TBD")
  TIMEOUT
