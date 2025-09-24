instance53583
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance53583.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.++ ((str.to_re \"\"),\n                     (regexp.loop (regexp.range \"0\" \"9\")))),\n                   (regexp.++ ((str.to_re \"\"),\n                    (regexp.++ ((regexp.opt (str.to_re \"\\\\u{0d}\")),\n                     (regexp.opt (str.to_re \"\\\\u{0a}\"))))))))) as regex")
  TIMEOUT
