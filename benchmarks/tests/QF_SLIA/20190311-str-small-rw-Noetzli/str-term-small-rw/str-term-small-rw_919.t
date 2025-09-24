str-term-small-rw_919
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_919.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.replace (str.from_int z) \"B\" x) as string")
  TIMEOUT
