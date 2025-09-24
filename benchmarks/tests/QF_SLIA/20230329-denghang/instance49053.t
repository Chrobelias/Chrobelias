instance49053
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance49053.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.union ((regexp.range \"a\" \"z\"),\n                     (regexp.range \"A\" \"Z\"))),\n                   (regexp.union ((str.to_re \" \"),\n                    (regexp.union ((str.to_re \"\\\\u{0b}\"),\n                     (regexp.union ((str.to_re \"\\\\u{0a}\"),\n                      (regexp.union ((str.to_re \"\\\\u{0d}\"),\n                       (regexp.union ((str.to_re \"\\\\u{09}\"),\n                        (str.to_re \"\\\\u{0c}\")))))))))))))) as regex")
  TIMEOUT
