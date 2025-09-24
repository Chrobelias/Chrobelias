regex-003-graft-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-graft-rotate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "T:j0Dkb2R770l-rd>'\x0c'c'CJ'\n'7")
  Fatal error: exception Failure("TBD")
  TIMEOUT
