instance55592
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance55592.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union ((str.to_re \"A\"),\n                   (regexp.union ((str.to_re \"B\"),\n                    (regexp.union ((str.to_re \"C\"),\n                     (regexp.union ((str.to_re \"D\"),\n                      (regexp.union ((str.to_re \"E\"),\n                       (regexp.union ((str.to_re \"F\"), (str.to_re \"G\")))))))))))))) as regex")
  TIMEOUT
