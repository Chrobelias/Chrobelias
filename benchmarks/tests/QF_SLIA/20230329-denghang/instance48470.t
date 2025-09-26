instance48470
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance48470.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.union ((regexp.range \"A\" \"Z\"),\n                     (regexp.range \"a\" \"z\"))),\n                   (regexp.*\n                    (regexp.inter\n                     (regexp.diff re.allchar (regexp.range \"A\" \"Z\"))\n                     (regexp.diff re.allchar (regexp.range \"a\" \"z\"))))))) as regex")
  TIMEOUT
