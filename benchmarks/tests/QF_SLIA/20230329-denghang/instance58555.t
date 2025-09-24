instance58555
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance58555.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((str.to_re \" \"),\n                   (regexp.+ (regexp.range \"0\" \"9\"))))) as regex")
  TIMEOUT
