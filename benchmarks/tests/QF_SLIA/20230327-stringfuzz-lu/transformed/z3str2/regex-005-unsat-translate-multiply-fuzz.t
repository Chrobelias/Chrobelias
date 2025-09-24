regex-005-unsat-translate-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-translate-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "VVSp5'\x0c'' 'h/?B'\n'XVGynjo!VVVh-EH.@!t?muTfsu!jVV`"ufK.RIalM_eT,V2!B-FD)V[1]sY0lEP'\r'")
  Fatal error: exception Failure("TBD")
  TIMEOUT
