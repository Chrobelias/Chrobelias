str-term-small-rw_43
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_43.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.from_int (str.indexof \"\" \"B\" z)) as string")
  TIMEOUT
