instance54088
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance54088.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union ((str.to_re \"A\"),\n                   (regexp.union ((str.to_re \"T\"),\n                    (regexp.union ((str.to_re \"G\"),\n                     (regexp.union ((str.to_re \"C\"), (str.to_re \"N\")))))))))) as regex")
  TIMEOUT
