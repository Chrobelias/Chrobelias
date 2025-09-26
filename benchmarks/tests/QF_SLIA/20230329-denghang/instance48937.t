instance48937
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance48937.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((str.to_re \"\\\\\\\\\"),\n                   (regexp.++ ((regexp.+ (str.to_re \"w\")),\n                    (regexp.opt\n                     (regexp.++ ((str.to_re \"\\\\\\\\\"),\n                      (regexp.+ (str.to_re \"s\")))))))))) as regex")
  TIMEOUT
