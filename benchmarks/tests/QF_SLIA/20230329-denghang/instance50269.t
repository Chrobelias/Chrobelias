instance50269
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance50269.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((str.to_re \"\\\\\\\\\"),\n                   (regexp.++ ((regexp.diff re.allchar (str.to_re \"\\\\n\")),\n                    (regexp.++ ((str.to_re \"\\\\\\\\\"),\n                     (regexp.+ (str.to_re \"d\"))))))))) as regex")
  TIMEOUT
