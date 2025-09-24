regex-004-unsat-multiply-translate-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-multiply-translate-reverse.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "'b0x\\''b0x\\''r\\''r\\'bb'r\\''r\\'bb~~hh")
  Fatal error: exception Failure("TBD")
  TIMEOUT
