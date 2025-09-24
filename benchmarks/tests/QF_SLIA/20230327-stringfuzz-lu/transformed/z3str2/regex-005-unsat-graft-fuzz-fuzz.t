regex-005-unsat-graft-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-graft-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "~c0rTD){nBRYHD<ONsO]jC,&~u{X$/"jz88'\n'VGIM$5<aSDp3w' '+'\r'/'\r'3]'\n'3BCfL2"XV*.^7nw[~bd,@,' 'f'\n'qoH?bz:NGn12]at'\t'0\\%&P\\a' 'j'\x0c'.{J4I<*x-G]yN'\r'aK'U^Z'\t'>N' 'vf4^0zDsA*n=5z62C.T}/@AIe/"^7~]b1b:'\r'qv6aQ1WWWj;hLuk'\x0c'6fJ"1e0#\\rPQf`~LQIT'\t''\r'N}lV1~?m!g@L0w3")
  Fatal error: exception Failure("TBD")
  TIMEOUT
