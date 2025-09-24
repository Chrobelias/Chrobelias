str-term-small-rw_971
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_971.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.replace (str.replace x \"B\" x) \"B\" y) as string")
  TIMEOUT
