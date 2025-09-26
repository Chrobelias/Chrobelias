regex-020-translate-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-020-translate-rotate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "qzm1CTg@_5aw'A:X_4;.<.\\gm]M^Q=Gj'")
  Fatal error: exception Failure("TBD")
  TIMEOUT
