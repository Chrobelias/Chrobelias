str-term-small-rw_168
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_168.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.substr x 0 (str.indexof \"B\" x z)) as string")
  TIMEOUT
