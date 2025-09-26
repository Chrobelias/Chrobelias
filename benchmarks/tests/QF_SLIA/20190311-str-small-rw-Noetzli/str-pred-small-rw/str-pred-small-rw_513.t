str-pred-small-rw_513
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-pred-small-rw/str-pred-small-rw_513.smt2  || echo TIMEOUT
  Fatal error: exception Failure("expected term, in (bool.eq \"\" (str.from_int 0))")
  TIMEOUT
