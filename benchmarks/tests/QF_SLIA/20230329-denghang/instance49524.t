instance49524
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance49524.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union ((str.to_re \"p\"),\n                   (regexp.union ((str.to_re \"L\"), (str.to_re \" \")))))) as regex")
  TIMEOUT
