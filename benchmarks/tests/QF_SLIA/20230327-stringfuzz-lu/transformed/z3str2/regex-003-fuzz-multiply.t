regex-003-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-fuzz-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "II99bbmm@@dd++||''\\\\rr''ZZ''22kk==--''\\\\xx00cc''AAxx11JJccoo((UU66qq%%??''\\\\tt''mm++aaaaggjjee")
  Fatal error: exception Failure("TBD")
  TIMEOUT
