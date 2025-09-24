instance55088
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance55088.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union ((str.to_re \":\"),\n                   (regexp.union ((str.to_re \"a\"),\n                    (regexp.union ((str.to_re \"l\"),\n                     (regexp.union ((str.to_re \"n\"),\n                      (regexp.union ((str.to_re \"u\"),\n                       (regexp.union ((str.to_re \"m\"), (str.to_re \":\")))))))))))))) as regex")
  TIMEOUT
