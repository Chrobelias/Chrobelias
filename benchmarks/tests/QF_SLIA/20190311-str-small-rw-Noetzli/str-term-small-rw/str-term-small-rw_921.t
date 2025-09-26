str-term-small-rw_921
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-term-small-rw/str-term-small-rw_921.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.replace (str.at x 0) \"B\" \"A\") as string")
  TIMEOUT
