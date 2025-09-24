str-term-small-rw_33
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_33.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.from_int (str.indexof x x 0)) as string")
  TIMEOUT
