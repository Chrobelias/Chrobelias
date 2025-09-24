instance46040
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance46040.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((str.to_re \"\\\\\\\\\"),\n                   (regexp.+ (str.to_re \"w\"))))) as regex")
  TIMEOUT
