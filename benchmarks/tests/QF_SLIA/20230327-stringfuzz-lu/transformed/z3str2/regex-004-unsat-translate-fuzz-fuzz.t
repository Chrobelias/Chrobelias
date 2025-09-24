regex-004-unsat-translate-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-translate-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "ATe$(jTPh'\x0b'u73' '^VJ{P6mYX")
  Fatal error: exception Failure("TBD")
  TIMEOUT
