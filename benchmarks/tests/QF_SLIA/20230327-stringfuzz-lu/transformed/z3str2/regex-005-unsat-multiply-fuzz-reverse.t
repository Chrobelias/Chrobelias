regex-005-unsat-multiply-fuzz-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-multiply-fuzz-reverse.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "Ak`UFZM-J8aWF.I!{#cx+13F)-paa9/}s't\\'L'r\\'a*D^6r5p&!jQ?$g$a{Pn8mYG{]rKC'n\\'.P\\\\{")
  Fatal error: exception Failure("TBD")
  TIMEOUT
