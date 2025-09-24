instance49211
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance49211.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.++ ((str.to_re \"\\\\u{22}\"),\n                     (regexp.++\n                      ((regexp.*\n                        (regexp.diff re.allchar (str.to_re \"\\\\u{22}\"))),\n                      (str.to_re \"\\\\u{22}\"))))), (str.to_re \",\")))) as regex")
  TIMEOUT
