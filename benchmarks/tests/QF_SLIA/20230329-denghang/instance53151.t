instance53151
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance53151.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.union ((regexp.range \"A\" \"z\"),\n                   (regexp.union ((str.to_re \"\\\\u{20}\"),\n                    (regexp.union ((str.to_re \"\\\\u{0b}\"),\n                     (regexp.union ((str.to_re \"\\\\u{0a}\"),\n                      (regexp.union ((str.to_re \"\\\\u{0d}\"),\n                       (regexp.union ((str.to_re \"\\\\u{09}\"),\n                        (str.to_re \"\\\\u{0c}\")))))))))))))) as regex")
  TIMEOUT
