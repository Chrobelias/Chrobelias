instance47032
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance47032.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((str.to_re \"<\"),\n                   (regexp.++ ((str.to_re \"b\"),\n                    (regexp.++ ((str.to_re \"r\"), (str.to_re \">\")))))))) as regex")
  TIMEOUT
