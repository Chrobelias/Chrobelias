instance47142
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance47142.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((str.to_re \"D\"),\n                   (regexp.++ ((str.to_re \"7\"),\n                    (regexp.++ ((regexp.diff re.allchar (str.to_re \"\\\\n\")),\n                     (regexp.diff re.allchar (str.to_re \"\\\\n\"))))))))) as regex")
  TIMEOUT
