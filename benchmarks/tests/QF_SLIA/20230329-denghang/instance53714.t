instance53714
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance53714.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union ((str.to_re \":\"),\n                   (regexp.union ((str.to_re \"d\"),\n                    (regexp.union ((str.to_re \"i\"),\n                     (regexp.union ((str.to_re \"g\"),\n                      (regexp.union ((str.to_re \"i\"),\n                       (regexp.union ((str.to_re \"t\"), (str.to_re \":\")))))))))))))) as regex")
  TIMEOUT
