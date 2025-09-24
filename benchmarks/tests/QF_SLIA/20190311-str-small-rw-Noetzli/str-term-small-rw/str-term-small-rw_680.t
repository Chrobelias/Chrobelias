str-term-small-rw_680
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_680.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.replace y (str.replace \"B\" \"A\" y) x) as string")
  TIMEOUT
