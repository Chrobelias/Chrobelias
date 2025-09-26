instance51437
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance51437.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.*\n                     (regexp.inter\n                      (regexp.diff re.allchar (str.to_re \"\\\\u{22}\"))\n                      (regexp.diff re.allchar (str.to_re \"\\\\u{27}\")))),\n                   (regexp.union ((str.to_re \"\\\\u{22}\"),\n                    (str.to_re \"\\\\u{27}\")))))) as regex")
  TIMEOUT
