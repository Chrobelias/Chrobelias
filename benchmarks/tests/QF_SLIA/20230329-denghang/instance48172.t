instance48172
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance48172.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((str.to_re \"\\\\\\\\\"),\n                   (regexp.++ ((regexp.+ (str.to_re \"S\")),\n                    (regexp.++ ((str.to_re \"\\\\\\\\\"),\n                     (regexp.+ (str.to_re \"s\"))))))))) as regex")
  TIMEOUT
