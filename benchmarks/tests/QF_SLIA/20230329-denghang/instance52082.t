instance52082
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance52082.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.+ (regexp.diff re.allchar (str.to_re \"\\\\n\"))),\n                   (regexp.++\n                    ((regexp.*\n                      (regexp.union ((str.to_re \" \"),\n                       (regexp.union ((str.to_re \"\\\\u{0b}\"),\n                        (regexp.union ((str.to_re \"\\\\u{0a}\"),\n                         (regexp.union ((str.to_re \"\\\\u{0d}\"),\n                          (regexp.union ((str.to_re \"\\\\u{09}\"),\n                           (str.to_re \"\\\\u{0c}\")))))))))))),\n                    (regexp.* (str.to_re \"\\\\u{0a}\"))))))) as regex")
  TIMEOUT
