instance54158
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance54158.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union ((str.to_re \"b\"),\n                   (regexp.union ((str.to_re \"c\"), (str.to_re \"d\")))))) as regex")
  TIMEOUT
