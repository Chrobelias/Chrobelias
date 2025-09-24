instance51087
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance51087.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union ((str.to_re \"\\\\\\\\\"),\n                   (regexp.union ((str.to_re \"w\"),\n                    (regexp.union ((str.to_re \"\\\\\\\\\"), (str.to_re \"s\")))))))) as regex")
  TIMEOUT
