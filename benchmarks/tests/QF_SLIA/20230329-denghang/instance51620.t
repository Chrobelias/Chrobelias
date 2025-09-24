instance51620
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance51620.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((regexp.+ (regexp.range \"1\" \"9\")),\n                   (regexp.* (regexp.range \"0\" \"9\"))))) as regex")
  TIMEOUT
