instance56750
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance56750.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((regexp.* (str.to_re \"\\\\u{0a}\")),\n                   (regexp.* (regexp.diff re.allchar (str.to_re \"\\\\n\")))))) as regex")
  TIMEOUT
