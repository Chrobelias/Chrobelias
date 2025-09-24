instance18816
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance18816.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.+\n                     (regexp.union ((str.to_re \" \"),\n                      (regexp.union ((str.to_re \"\\\\u{0b}\"),\n                       (regexp.union ((str.to_re \"\\\\u{0a}\"),\n                        (regexp.union ((str.to_re \"\\\\u{0d}\"),\n                         (regexp.union ((str.to_re \"\\\\u{09}\"),\n                          (str.to_re \"\\\\u{0c}\")))))))))))),\n                   (regexp.++ ((str.to_re \"g\"),\n                    (regexp.++ ((str.to_re \"<\"),\n                     (regexp.++ ((str.to_re \"1\"), (str.to_re \">\")))))))))) as regex")
  TIMEOUT
