regex-004-unsat-multiply-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-multiply-fuzz-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "xx77CC44__dd((NNQQJJVVddrrKK||YYIIuuLLQQ''\\\\xx00bb''JJMM<<ll""""""""vvttVVmmqq''YYXXXXWWAADDFF[[dd''\\\\nn''yy!!::||ee__TTww66CCccdddd44''tt11qq55")
  Fatal error: exception Failure("TBD")
  TIMEOUT
