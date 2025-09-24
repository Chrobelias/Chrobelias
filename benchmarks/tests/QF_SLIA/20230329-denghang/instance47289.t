instance47289
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance47289.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.loop\n                     (regexp.union ((regexp.range \"0\" \"9\"),\n                      (regexp.range \"a\" \"f\")))), (str.to_re \" \")))) as regex")
  TIMEOUT
