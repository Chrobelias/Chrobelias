instance54938
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance54938.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union ((str.to_re \"h\"),\n                   (regexp.union ((str.to_re \"y\"),\n                    (regexp.union ((str.to_re \"p\"),\n                     (regexp.union ((str.to_re \"e\"),\n                      (regexp.union ((str.to_re \"n\"),\n                       (regexp.union ((str.to_re \"a\"),\n                        (regexp.union ((str.to_re \"t\"), (str.to_re \"d\")))))))))))))))) as regex")
  TIMEOUT
