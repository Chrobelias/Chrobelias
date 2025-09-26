instance46826
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance46826.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.+\n                     (regexp.union ((regexp.range \"a\" \"z\"),\n                      (regexp.union ((regexp.range \"A\" \"Z\"),\n                       (str.to_re \"-\")))))),\n                   (regexp.++ ((str.to_re \"_\"),\n                    (regexp.opt (str.to_re \"_\"))))))) as regex")
  TIMEOUT
