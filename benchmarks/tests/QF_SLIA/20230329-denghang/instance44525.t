instance44525
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance44525.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union ((regexp.range \"A\" \"Z\"),\n                   (regexp.range \"a\" \"z\")))) as regex")
  TIMEOUT
