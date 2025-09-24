regex-006-multiply-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-006-multiply-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "a4`>U\\uP(!u$bYiyQ]bb.K"Nj'\r'4cc).^X6w|aaaY[b'\x0b'qvoD6%Q`$[S+^b/+F2z(w5;J6Z.m>RWJNQB,7#'\n'dc")
  Fatal error: exception Failure("TBD")
  TIMEOUT
