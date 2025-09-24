str-term-small-rw_757
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_757.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.replace \"B\" x (str.at x 0)) as string")
  TIMEOUT
