instance57903
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance57903.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union ((regexp.range \"A\" \"Z\"),\n                   (str.to_re \"\\\\u{0a}\")))) as regex")
  TIMEOUT
