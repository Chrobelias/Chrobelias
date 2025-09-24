instance57679
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance57679.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.*\n                     (regexp.diff re.allchar (regexp.range \"0\" \"9\"))),\n                   (regexp.range \"0\" \"9\")))) as regex")
  TIMEOUT
