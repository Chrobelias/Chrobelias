str-term-small-rw_761
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_761.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.replace \"B\" x (str.++ (\"B\", x))) as string")
  TIMEOUT
