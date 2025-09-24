instance56659
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance56659.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.+\n                     (regexp.loop\n                      (regexp.union ((regexp.loop (str.to_re \"+\")),\n                       (regexp.loop (str.to_re \"0\")))))),\n                   (regexp.loop (str.to_re \"1\"))))) as regex")
  TIMEOUT
