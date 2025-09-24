regex-003-translate-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-translate-rotate-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "'\x0b',Q45H'\n'w}u66yQP_q8\\\\(obhk~gm'GW{!s#tT)CW-|'Yji(pi[:#r(?VF{'\\A.WzyTixTWpYi}?"evT=_f;'-TJ9Y,pYQA:g}e_q\\\\(L\\\\\\(N")
  Fatal error: exception Failure("TBD")
  TIMEOUT
