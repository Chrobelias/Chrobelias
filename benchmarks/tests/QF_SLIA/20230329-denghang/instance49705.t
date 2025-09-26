instance49705
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance49705.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((str.to_re \"A\"),\n                   (regexp.++ ((str.to_re \"D\"), (str.to_re \"D\")))))) as regex")
  TIMEOUT
