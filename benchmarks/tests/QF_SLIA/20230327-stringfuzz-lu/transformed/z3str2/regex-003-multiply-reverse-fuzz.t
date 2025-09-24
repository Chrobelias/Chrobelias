regex-003-multiply-reverse-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-multiply-reverse-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "'\x0c'v{ed+ys'\t'U{4qeux'\x0c'-Ul,3W'\x0b'cd7n}+ax9@up!'\n'c'\n'r$3[:bF'\n'cnQ.'\t']Md:{Qp='\x0c'%o'\x0b'cBa,a,cw|'\x0c'JkDSesp({fZpa%{Pd>*]Gh~J'\r'xc")
  Fatal error: exception Failure("TBD")
  TIMEOUT
