instance51103
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance51103.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union ((str.to_re \"\\\\u{22}\"),\n                   (str.to_re \"\\\\u{27}\")))) as regex")
  TIMEOUT
