str-term-small-rw_61
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_61.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.at x (str.indexof \"A\" x 1)) as string")
  TIMEOUT
