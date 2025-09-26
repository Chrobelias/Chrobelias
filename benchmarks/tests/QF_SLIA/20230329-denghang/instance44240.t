instance44240
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance44240.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((regexp.* (regexp.range \"0\" \"9\")),\n                   (regexp.opt\n                    (regexp.++ ((regexp.+ (str.to_re \".\")),\n                     (regexp.+ (regexp.range \"0\" \"9\")))))))) as regex")
  TIMEOUT
