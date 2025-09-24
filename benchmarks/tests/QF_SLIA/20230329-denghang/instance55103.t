instance55103
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance55103.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.union\n                     ((regexp.union\n                       ((regexp.++ ((str.to_re \"25\"),\n                         (regexp.range \"0\" \"5\"))),\n                       (regexp.++ ((str.to_re \"2\"),\n                        (regexp.++ ((regexp.range \"0\" \"4\"),\n                         (regexp.range \"0\" \"9\"))))))),\n                     (regexp.++ ((regexp.opt (str.to_re \"01\")),\n                      (regexp.++ ((regexp.range \"0\" \"9\"),\n                       (regexp.opt (regexp.range \"0\" \"9\")))))))),\n                   (str.to_re \".\")))) as regex")
  TIMEOUT
