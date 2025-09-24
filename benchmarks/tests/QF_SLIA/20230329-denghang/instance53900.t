instance53900
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20230329-denghang/instance53900.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (regexp.diff re.allchar (str.to_re \"\\\\u{0a}\")) as regex")
  TIMEOUT
