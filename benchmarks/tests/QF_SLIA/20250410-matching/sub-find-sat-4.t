sub-find-sat-4
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/20250410-matching/sub-find-sat-4.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.replace a b c0) as string")
  TIMEOUT
