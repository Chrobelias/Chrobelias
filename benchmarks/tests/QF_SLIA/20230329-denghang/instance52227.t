instance52227
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance52227.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union ((str.to_re \"/\"),\n                   (regexp.union ((str.to_re \"^\"),\n                    (regexp.union ((str.to_re \"S\"),\n                     (regexp.union ((str.to_re \"M\"),\n                      (regexp.union ((str.to_re \"T\"),\n                       (regexp.union ((str.to_re \"P\"),\n                        (regexp.union ((str.to_re \"$\"), (str.to_re \"/\")))))))))))))))) as regex")
  TIMEOUT
