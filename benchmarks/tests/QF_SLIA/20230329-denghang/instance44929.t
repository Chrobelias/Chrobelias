instance44929
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance44929.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((regexp.range \"6\" \"8\"),\n                   (regexp.*\n                    (regexp.union ((regexp.range \"0\" \"5\"),\n                     (regexp.union ((str.to_re \",\"), (str.to_re \"9\"))))))))) as regex")
  TIMEOUT
