instance50121
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance50121.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union ((str.to_re \"A\"),\n                   (regexp.union ((str.to_re \"D\"), (str.to_re \"M\")))))) as regex")
  TIMEOUT
