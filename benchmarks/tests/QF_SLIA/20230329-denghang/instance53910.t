instance53910
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance53910.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.*\n                     (regexp.diff re.allchar (regexp.range \"a\" \"z\"))),\n                   (regexp.++ ((regexp.range \"a\" \"z\"),\n                    (regexp.*\n                     (regexp.diff re.allchar (regexp.range \"a\" \"z\")))))))) as regex")
  TIMEOUT
