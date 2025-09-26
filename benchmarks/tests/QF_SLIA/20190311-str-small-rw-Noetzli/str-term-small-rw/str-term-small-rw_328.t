str-term-small-rw_328
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_328.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.substr \"\" z (str.indexof x y 1)) as string")
  TIMEOUT
