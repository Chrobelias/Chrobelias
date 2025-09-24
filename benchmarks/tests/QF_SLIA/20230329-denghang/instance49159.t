instance49159
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance49159.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((regexp.opt (str.to_re \":\")),\n                   (regexp.++\n                    ((regexp.++ ((str.to_re \"\\\\\\\\\"),\n                      (regexp.+ (str.to_re \"d\")))), (str.to_re \" \")))))) as regex")
  TIMEOUT
