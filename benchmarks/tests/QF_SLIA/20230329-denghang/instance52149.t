instance52149
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance52149.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((str.to_re \":\"),\n                   (regexp.+\n                    (regexp.union ((regexp.range \"A\" \"Z\"),\n                     (regexp.union ((regexp.range \"a\" \"z\"),\n                      (regexp.range \"0\" \"9\"))))))))) as regex")
  TIMEOUT
