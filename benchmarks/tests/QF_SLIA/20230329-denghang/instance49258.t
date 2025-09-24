instance49258
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance49258.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union\n                   ((regexp.++ ((str.to_re \"\\\\\\\\\"), (str.to_re \"w\"))),\n                   (str.to_re \"W\")))) as regex")
  TIMEOUT
