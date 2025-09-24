instance49501
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance49501.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.+\n                     (regexp.inter (regexp.diff re.allchar (str.to_re \" \"))\n                      (regexp.diff re.allchar (str.to_re \"\\\\u{09}\")))),\n                   (regexp.+\n                    (regexp.union ((str.to_re \" \"), (str.to_re \"\\\\u{09}\"))))))) as regex")
  TIMEOUT
