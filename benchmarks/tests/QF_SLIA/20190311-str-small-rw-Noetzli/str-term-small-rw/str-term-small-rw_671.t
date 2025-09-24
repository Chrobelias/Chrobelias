str-term-small-rw_671
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_671.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.replace y (str.replace y y x) \"B\") as string")
  TIMEOUT
