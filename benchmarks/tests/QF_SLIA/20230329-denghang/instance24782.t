instance24782
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance24782.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.+\n                     (regexp.union ((regexp.range \"A\" \"Z\"),\n                      (regexp.range \"0\" \"9\")))),\n                   (regexp.opt (str.to_re \"-\"))))) as regex")
  TIMEOUT
