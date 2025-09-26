instance57927
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance57927.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union ((str.to_re \"-\"),\n                   (regexp.union ((str.to_re \"r\"),\n                    (regexp.union ((str.to_re \"w\"), (str.to_re \"x\")))))))) as regex")
  TIMEOUT
