str-term-small-rw_867
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_867.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.replace \"\" (str.at x 0) y) as string")
  TIMEOUT
