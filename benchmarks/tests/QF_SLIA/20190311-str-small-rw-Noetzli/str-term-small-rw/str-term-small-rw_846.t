str-term-small-rw_846
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_846.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.replace \"\" x (str.replace y x y)) as string")
  TIMEOUT
