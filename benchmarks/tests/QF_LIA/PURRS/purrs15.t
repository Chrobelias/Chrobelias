purrs15
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs15.smt2 || echo TIMEOUT
  Fatal error: exception Failure("expected term, in (none.div_s 10 3)")
  TIMEOUT
