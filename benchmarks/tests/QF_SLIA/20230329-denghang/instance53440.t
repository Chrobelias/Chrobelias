instance53440
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance53440.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union ((str.to_re \":\"),\n                   (regexp.union ((str.to_re \"s\"),\n                    (regexp.union ((str.to_re \"p\"),\n                     (regexp.union ((str.to_re \"a\"),\n                      (regexp.union ((str.to_re \"c\"), (str.to_re \"e\")))))))))))) as regex")
  TIMEOUT
