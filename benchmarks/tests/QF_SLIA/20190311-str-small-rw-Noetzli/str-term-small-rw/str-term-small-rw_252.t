str-term-small-rw_252
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_252.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.substr x (none.sub 0 z) z) as string")
  TIMEOUT
