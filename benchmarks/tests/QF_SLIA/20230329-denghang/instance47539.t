instance47539
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance47539.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union\n                   ((regexp.++ ((str.to_re \"F\"),\n                     (regexp.++ ((str.to_re \"F\"),\n                      (regexp.++ ((str.to_re \"F\"), (str.to_re \"1\"))))))),\n                   (regexp.++ ((str.to_re \"F\"),\n                    (regexp.++ ((str.to_re \"F\"),\n                     (regexp.++ ((str.to_re \"F\"), (str.to_re \"3\")))))))))) as regex")
  TIMEOUT
