instance57306
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance57306.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((regexp.* (str.to_re \"B\")), (str.to_re \"A\")))) as regex")
  TIMEOUT
