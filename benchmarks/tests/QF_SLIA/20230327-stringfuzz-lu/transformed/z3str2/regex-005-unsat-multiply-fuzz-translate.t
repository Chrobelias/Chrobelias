regex-005-unsat-multiply-fuzz-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-multiply-fuzz-translate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "pccbu?cq?Ar#~pOVw8qbp^)])'\t'*{Im'\r'5#6BnK^?c#?C?c`?"GU9^^'\r'&<Q31}>e' 'pI,uQd^8.&MiQt(PY")
  Fatal error: exception Failure("TBD")
  TIMEOUT
