instance48946
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance48946.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++ ((regexp.range \"0\" \"9\"),\n                   (regexp.*\n                    (regexp.inter\n                     (regexp.diff re.allchar (regexp.range \"a\" \"z\"))\n                     (regexp.inter\n                      (regexp.diff re.allchar (regexp.range \"A\" \"Z\"))\n                      (regexp.inter\n                       (regexp.diff re.allchar (regexp.range \"0\" \"9\"))\n                       (regexp.diff re.allchar (str.to_re \"_\"))))))))) as regex")
  TIMEOUT
