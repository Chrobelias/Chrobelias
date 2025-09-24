instance57976
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance57976.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union ((regexp.range \"a\" \"f\"),\n                   (regexp.union ((regexp.range \"0\" \"9\"), (str.to_re \"-\")))))) as regex")
  TIMEOUT
