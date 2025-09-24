str-term-small-rw_481
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_481.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.replace x \"A\" (str.replace \"A\" \"B\" y)) as string")
  TIMEOUT
