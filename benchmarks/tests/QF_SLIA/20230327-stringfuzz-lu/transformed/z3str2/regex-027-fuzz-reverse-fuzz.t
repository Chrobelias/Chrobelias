regex-027-fuzz-reverse-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-027-fuzz-reverse-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "pcboY/i)'\x0c'@GHR' 'z"xs-3$")
  Fatal error: exception Failure("TBD")
  TIMEOUT
