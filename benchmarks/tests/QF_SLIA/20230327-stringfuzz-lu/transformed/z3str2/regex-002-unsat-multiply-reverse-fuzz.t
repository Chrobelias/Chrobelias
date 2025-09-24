regex-002-unsat-multiply-reverse-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-multiply-reverse-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "KwP7/bhBn'\n'lz.o'\x0c''\t'ra.aaaaayNYVywi")
  Fatal error: exception Failure("TBD")
  TIMEOUT
