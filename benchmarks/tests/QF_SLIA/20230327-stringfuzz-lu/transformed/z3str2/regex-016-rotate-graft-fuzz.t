regex-016-rotate-graft-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-rotate-graft-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "azZ&I+S'{dcn?bH'\x0b'o}-:\\y~P")
  Fatal error: exception Failure("TBD")
  TIMEOUT
