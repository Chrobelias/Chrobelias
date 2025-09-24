regex-006-translate-translate-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-006-translate-translate-translate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "bPm-PPm}P=L0&Pm}PbPm-PPm}P=L0&Pm}P")
  Fatal error: exception Failure("TBD")
  TIMEOUT
