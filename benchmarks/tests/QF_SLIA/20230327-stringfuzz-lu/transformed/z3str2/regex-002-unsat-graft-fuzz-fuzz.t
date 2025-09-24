regex-002-unsat-graft-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-graft-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "bufuk)y' '9l}<-WPS{Z'\t''\x0b'kc^grUyeqn:\\AVTj>=h3}a68uhv>WEaW'q$xM1AjImj73h)@"7['\x0b'gyn}3'\x0b'a")
  Fatal error: exception Failure("TBD")
  TIMEOUT
