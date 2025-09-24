regex-005-unsat-multiply-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-multiply-rotate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aaBCtFfaaiaGG/+*j;|M!P?b+'a+'\r'@' '\\N(]wHOZaa>g)Yo5u('\t'v[J")
  Fatal error: exception Failure("TBD")
  TIMEOUT
