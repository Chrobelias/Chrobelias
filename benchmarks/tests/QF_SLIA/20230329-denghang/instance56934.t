instance56934
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance56934.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.union\n                     ((regexp.union\n                       ((regexp.++ ((str.to_re \"25\"),\n                         (regexp.range \"0\" \"5\"))),\n                       (regexp.++ ((regexp.opt (regexp.range \"0\" \"2\")),\n                        (regexp.++ ((regexp.opt (regexp.range \"0\" \"4\")),\n                         (regexp.range \"0\" \"9\"))))))),\n                     (regexp.++ ((regexp.opt (regexp.range \"0\" \"1\")),\n                      (regexp.++ ((regexp.opt (regexp.range \"0\" \"9\")),\n                       (regexp.range \"0\" \"9\"))))))), (str.to_re \".\")))) as regex")
  TIMEOUT
