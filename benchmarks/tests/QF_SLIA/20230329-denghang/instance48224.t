instance48224
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance48224.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((regexp.range \"0\" \"9\"),\n                   (regexp.opt\n                    (regexp.union\n                     ((regexp.union ((str.to_re \"\\\\u{20}\"),\n                       (regexp.union ((str.to_re \"\\\\u{0b}\"),\n                        (regexp.union ((str.to_re \"\\\\u{0a}\"),\n                         (regexp.union ((str.to_re \"\\\\u{0d}\"),\n                          (regexp.union ((str.to_re \"\\\\u{09}\"),\n                           (str.to_re \"\\\\u{0c}\"))))))))))), (str.to_re \"-\"))))))) as regex")
  TIMEOUT
