str-term-small-rw_108
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_108.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.at (str.at x z) 0) as string")
  TIMEOUT
