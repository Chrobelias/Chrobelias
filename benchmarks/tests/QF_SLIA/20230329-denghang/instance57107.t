instance57107
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance57107.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.union ((str.to_re \" \"),\n                     (regexp.union ((str.to_re \"\\\\u{0b}\"),\n                      (regexp.union ((str.to_re \"\\\\u{0a}\"),\n                       (regexp.union ((str.to_re \"\\\\u{0d}\"),\n                        (regexp.union ((str.to_re \"\\\\u{09}\"),\n                         (str.to_re \"\\\\u{0c}\"))))))))))),\n                   (regexp.loop\n                    (regexp.union ((regexp.range \"0\" \"9\"),\n                     (regexp.union ((regexp.range \"A\" \"F\"),\n                      (regexp.union ((str.to_re \"-\"),\n                       (regexp.range \"a\" \"f\"))))))))))) as regex")
  TIMEOUT
