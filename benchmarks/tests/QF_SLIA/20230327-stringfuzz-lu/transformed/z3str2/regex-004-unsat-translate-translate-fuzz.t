regex-004-unsat-translate-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-translate-translate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "XCp?tN?p:("Zj'Hb!!$TlEq:%<'\x0c'e4NbunT@@^\\_0'\t']'\t'#D}iKoN}*n&CWAsD_H1y;+xD\\y'Gjj-")
  Fatal error: exception Failure("TBD")
  TIMEOUT
