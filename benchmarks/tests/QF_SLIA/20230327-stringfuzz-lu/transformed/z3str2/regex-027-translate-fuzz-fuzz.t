regex-027-translate-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-027-translate-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "W0%]>mr*u'^~[KPz$l?pB7SXbixyRh_-")
  Fatal error: exception Failure("TBD")
  TIMEOUT
