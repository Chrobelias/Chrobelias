instance46221
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance46221.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.+\n                     (regexp.inter\n                      (regexp.diff re.allchar (regexp.range \"a\" \"z\"))\n                      (regexp.inter\n                       (regexp.diff re.allchar (regexp.range \"A\" \"Z\"))\n                       (regexp.inter\n                        (regexp.diff re.allchar (regexp.range \"0\" \"9\"))\n                        (regexp.diff re.allchar (str.to_re \"_\")))))),\n                   (regexp.+\n                    (regexp.union ((regexp.range \"a\" \"z\"),\n                     (regexp.union ((regexp.range \"A\" \"Z\"),\n                      (regexp.union ((regexp.range \"0\" \"9\"),\n                       (str.to_re \"_\"))))))))))) as regex")
  TIMEOUT
