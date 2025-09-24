instance57871
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance57871.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((regexp.range \"0\" \"9\"),\n                   (regexp.opt\n                    (regexp.union ((str.to_re \" \"),\n                     (regexp.union ((str.to_re \".\"), (str.to_re \"-\"))))))))) as regex")
  TIMEOUT
