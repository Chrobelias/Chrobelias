instance57626
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance57626.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.* (regexp.diff re.allchar (str.to_re \"\\\\n\")))) as regex")
  TIMEOUT
