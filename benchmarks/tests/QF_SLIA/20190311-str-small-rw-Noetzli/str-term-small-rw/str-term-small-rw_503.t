str-term-small-rw_503
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_503.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.replace x \"B\" (str.replace \"B\" y y)) as string")
  TIMEOUT
