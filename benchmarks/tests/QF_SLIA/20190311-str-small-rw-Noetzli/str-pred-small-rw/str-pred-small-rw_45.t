str-pred-small-rw_45
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-pred-small-rw/str-pred-small-rw_45.smt2  || echo TIMEOUT
  Fatal error: exception Failure("expected term, in (bool.eq x (str.substr x 1 0))")
  TIMEOUT
