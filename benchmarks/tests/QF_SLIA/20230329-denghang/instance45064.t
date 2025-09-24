instance45064
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance45064.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop (regexp.diff re.allchar (str.to_re \"\\\\n\"))) as regex")
  TIMEOUT
