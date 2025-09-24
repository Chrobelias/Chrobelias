regex-005-unsat-multiply-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-multiply-fuzz-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "{{\\\\\\\\PP..''\\\\nn''CCKKrr]]{{GGYYmm88nnPP{{aa$$gg$$??QQjj!!&&pp55rr66^^DD**aa''\\\\rr''LL''\\\\tt''ss}}//99aaaapp--))FF3311++xxcc##{{!!II..FFWWaa88JJ--MMZZFFUU``kkAA")
  Fatal error: exception Failure("TBD")
  TIMEOUT
