str-pred-small-rw_525
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-pred-small-rw/str-pred-small-rw_525.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (bool.eq \"\" (str.at \"B\" z)) as string")
  TIMEOUT
