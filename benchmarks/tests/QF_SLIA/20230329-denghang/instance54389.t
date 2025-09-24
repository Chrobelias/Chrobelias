instance54389
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance54389.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((str.to_re \"<\"),\n                   (regexp.++ ((str.to_re \"b\"),\n                    (regexp.++ ((str.to_re \"r\"),\n                     (regexp.++ ((regexp.* (str.to_re \" \")),\n                      (regexp.++ ((regexp.opt (str.to_re \"/\")),\n                       (str.to_re \">\")))))))))))) as regex")
  TIMEOUT
