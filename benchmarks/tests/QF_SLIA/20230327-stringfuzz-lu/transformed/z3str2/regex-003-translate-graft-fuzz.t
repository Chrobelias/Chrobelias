regex-003-translate-graft-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-translate-graft-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "\\\\&,hBJ+9>M2|SwR%i#Zrgi?u\\0b11ez]IPT'\r'F*%1;jJ?ok]~q#38nSnD6?7v'rM/G@8O9=_*\\(\\\\(Jm'\n';")
  Fatal error: exception Failure("TBD")
  TIMEOUT
