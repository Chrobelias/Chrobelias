instance56509
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance56509.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((str.to_re \",\"),\n                   (regexp.++ ((str.to_re \"\\\\u{22}\"),\n                    (regexp.++ ((str.to_re \"X\"),\n                     (regexp.++ ((str.to_re \"X\"),\n                      (regexp.++ ((str.to_re \"X\"),\n                       (regexp.++ ((regexp.+ (regexp.range \"0\" \"9\")),\n                        (str.to_re \"\\\\u{22}\")))))))))))))) as regex")
  TIMEOUT
