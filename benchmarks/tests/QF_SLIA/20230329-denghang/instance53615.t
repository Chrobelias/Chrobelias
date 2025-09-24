instance53615
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance53615.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((regexp.+ (regexp.range \"0\" \"9\")),\n                   (regexp.loop\n                    (regexp.++ ((str.to_re \".\"),\n                     (regexp.union ((regexp.+ (regexp.range \"0\" \"9\")),\n                      (str.to_re \"*\"))))))))) as regex")
  TIMEOUT
