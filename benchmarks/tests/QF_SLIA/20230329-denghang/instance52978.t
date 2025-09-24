instance52978
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance52978.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union\n                   ((regexp.union ((regexp.range \"a\" \"z\"),\n                     (regexp.union ((regexp.range \"A\" \"Z\"),\n                      (regexp.union ((regexp.range \"0\" \"9\"),\n                       (str.to_re \"_\"))))))),\n                   (regexp.union ((str.to_re \".\"), (str.to_re \"-\")))))) as regex")
  TIMEOUT
