regex-003-rotate-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-rotate-rotate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "EO1NB7(@9'\n'qo'\n'?@kw!`'\x0b',A;abd''\x0c'DUZdpoj4f*}tQ' '")
  Fatal error: exception Failure("TBD")
  TIMEOUT
