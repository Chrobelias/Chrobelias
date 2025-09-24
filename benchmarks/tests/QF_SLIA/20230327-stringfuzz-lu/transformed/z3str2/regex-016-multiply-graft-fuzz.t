regex-016-multiply-graft-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-multiply-graft-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aabcdda'\n'sfy@zNkKV8)g`sk_cdeFz0}'\r''\x0c'F["12'\r'yT<V'\x0b''\n'cOrjQ*|dR'\n'")
  Fatal error: exception Failure("TBD")
  TIMEOUT
