instance54732
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance54732.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((regexp.range \"A\" \"Z\"),\n                   (regexp.* (regexp.range \"a\" \"z\"))))) as regex")
  TIMEOUT
