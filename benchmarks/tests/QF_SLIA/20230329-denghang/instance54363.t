instance54363
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance54363.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((regexp.loop (regexp.range \"0\" \"9\")),\n                   (regexp.+ (regexp.diff re.allchar (regexp.range \"0\" \"9\")))))) as regex")
  TIMEOUT
