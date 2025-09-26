instance58173
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance58173.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.*\n                     (regexp.inter\n                      (regexp.diff re.allchar (str.to_re \"\\\\u{22}\"))\n                      (regexp.diff re.allchar (str.to_re \"\\\\u{0a}\")))),\n                   (str.to_re \"\\\\u{22}\")))) as regex")
  TIMEOUT
