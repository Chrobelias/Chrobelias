instance57298
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance57298.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union ((regexp.range \"A\" \"H\"),\n                   (regexp.union ((regexp.range \"J\" \"N\"),\n                    (regexp.union ((str.to_re \"P\"),\n                     (regexp.union ((regexp.range \"R\" \"Z\"),\n                      (regexp.range \"0\" \"9\")))))))))) as regex")
  TIMEOUT
