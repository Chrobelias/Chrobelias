instance49173
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance49173.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((str.to_re \"P\"),\n                   (regexp.++ ((str.to_re \"H\"), (str.to_re \"P\")))))) as regex")
  TIMEOUT
