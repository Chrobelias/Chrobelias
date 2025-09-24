instance48025
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance48025.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.++\n                     ((regexp.*\n                       (regexp.union ((regexp.range \"a\" \"z\"),\n                        (regexp.range \"A\" \"Z\")))),\n                     (regexp.loop\n                      (regexp.union ((regexp.range \"a\" \"z\"),\n                       (regexp.range \"A\" \"Z\")))))),\n                   (regexp.++\n                    ((regexp.++ ((regexp.* (str.to_re \"0\")),\n                      (regexp.loop (str.to_re \"0\")))),\n                    (regexp.++ ((str.to_re \"\\\\\\\\\"),\n                     (regexp.+ (str.to_re \"d\"))))))))) as regex")
  TIMEOUT
