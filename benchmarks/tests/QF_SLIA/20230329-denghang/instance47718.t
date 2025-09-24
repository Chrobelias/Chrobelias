instance47718
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance47718.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.union ((str.to_re \"K\"), (str.to_re \"R\"))),\n                   (regexp.* (str.to_re \"-\"))))) as regex")
  TIMEOUT
