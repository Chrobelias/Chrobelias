regex-019-unsat-translate-graft-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-019-unsat-translate-graft-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "b#16(eSOEqB"""""!1&}1DK`v/]zP)V`RNlvp=Qx#m8pG+#&"")
  Fatal error: exception Failure("TBD")
  TIMEOUT
