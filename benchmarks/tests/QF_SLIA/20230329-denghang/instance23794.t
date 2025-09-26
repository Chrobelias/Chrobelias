instance23794
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance23794.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.*\n                     (regexp.diff re.allchar (regexp.range \"A\" \"Z\"))),\n                   (regexp.range \"A\" \"Z\")))) as regex")
  TIMEOUT
