purrs12
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs12.smt2 || echo TIMEOUT
  Fatal error: exception Failure("expected term, in (none.div_s 1 8)")
  TIMEOUT
