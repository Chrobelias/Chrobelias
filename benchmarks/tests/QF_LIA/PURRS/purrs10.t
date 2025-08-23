purrs10
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs10.smt2 || echo TIMEOUT
  Fatal error: exception Failure("expected term, in (none.div_s (exp (none.neg 1), n) (exp 2, n))")
  TIMEOUT
