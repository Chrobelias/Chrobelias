str-term-small-rw_93
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_93.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.at \"B\" (str.indexof x y 1)) as string")
  TIMEOUT
