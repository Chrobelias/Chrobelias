regex-004-unsat-rotate-translate-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-rotate-translate-reverse.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "W'n\\'<'n\\'<t;")
  Fatal error: exception Failure("TBD")
  TIMEOUT
