str-term-small-rw_106
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_106.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.at (str.at x 1) 0) as string")
  TIMEOUT
