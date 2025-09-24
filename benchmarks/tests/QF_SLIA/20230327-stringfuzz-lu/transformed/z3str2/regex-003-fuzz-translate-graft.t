regex-003-fuzz-translate-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-fuzz-translate-graft.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "Z9R'\\x0c'=:_`z@Ozlz2y'+z@L0IzGL1PIE*S6Q/Tz@'\\x0b'z'\\x0c'_))W#>")
  Fatal error: exception Failure("TBD")
  TIMEOUT
