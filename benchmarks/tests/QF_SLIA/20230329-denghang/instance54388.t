instance54388
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance54388.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((regexp.range \"0\" \"9\"),\n                   (regexp.loop\n                    (regexp.union ((str.to_re \" \"),\n                     (regexp.union ((str.to_re \"\\\\u{0b}\"),\n                      (regexp.union ((str.to_re \"\\\\u{0a}\"),\n                       (regexp.union ((str.to_re \"\\\\u{0d}\"),\n                        (regexp.union ((str.to_re \"\\\\u{09}\"),\n                         (str.to_re \"\\\\u{0c}\"))))))))))))))) as regex")
  TIMEOUT
