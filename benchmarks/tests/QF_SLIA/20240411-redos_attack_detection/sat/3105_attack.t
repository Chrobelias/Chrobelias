3105_attack
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20240411-redos_attack_detection/sat/3105_attack.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle prefix as regex")
  TIMEOUT
