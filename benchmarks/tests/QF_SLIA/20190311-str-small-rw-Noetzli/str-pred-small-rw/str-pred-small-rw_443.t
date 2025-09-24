str-pred-small-rw_443
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-pred-small-rw/str-pred-small-rw_443.smt2  || echo TIMEOUT
  Fatal error: exception Failure("expected term, in (bool.eq \"B\" (str.substr \"A\" 0 z))")
  TIMEOUT
