instance30657
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance30657.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.loop\n                  (regexp.++\n                   ((regexp.*\n                     (regexp.union ((str.to_re \"a\"),\n                      (regexp.union ((str.to_re \"i\"),\n                       (regexp.union ((str.to_re \"e\"),\n                        (regexp.union ((str.to_re \"o\"), (str.to_re \"u\")))))))))),\n                   (regexp.union ((str.to_re \"a\"),\n                    (regexp.union ((str.to_re \"i\"),\n                     (regexp.union ((str.to_re \"e\"),\n                      (regexp.union ((str.to_re \"o\"), (str.to_re \"u\")))))))))))) as regex")
  TIMEOUT
