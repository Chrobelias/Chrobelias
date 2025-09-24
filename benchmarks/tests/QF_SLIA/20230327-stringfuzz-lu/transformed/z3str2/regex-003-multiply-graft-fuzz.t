regex-003-multiply-graft-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-multiply-graft-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "db>0E'\x0b'hf0'\x0b'u[x5Ds1KA3#j]_(lY6xddeAj]+Zbjb-4qYwu23_OEangr#$q[bG'C0@' 'PTDKY$k'\n'5ODBdv)&YjdUi2e")
  Fatal error: exception Failure("TBD")
  TIMEOUT
