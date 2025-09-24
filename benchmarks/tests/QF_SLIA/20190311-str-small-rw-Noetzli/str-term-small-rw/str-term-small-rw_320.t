str-term-small-rw_320
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_320.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.substr \"B\" (str.indexof \"\" x 0) z) as string")
  TIMEOUT
