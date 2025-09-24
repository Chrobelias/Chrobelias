str-term-small-rw_164
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_164.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.substr x 0 (str.indexof \"A\" y 1)) as string")
  TIMEOUT
