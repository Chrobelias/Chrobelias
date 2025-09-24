instance49949
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance49949.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union ((str.to_re \"c\"),\n                   (regexp.union ((str.to_re \"o\"),\n                    (regexp.union ((str.to_re \"m\"),\n                     (regexp.union ((str.to_re \"p\"),\n                      (regexp.union ((str.to_re \"u\"),\n                       (regexp.union ((str.to_re \"t\"),\n                        (regexp.union ((str.to_re \"e\"), (str.to_re \"r\")))))))))))))))) as regex")
  TIMEOUT
