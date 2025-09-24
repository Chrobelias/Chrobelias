regex-003-multiply-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-multiply-translate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "ImPff^^' '[b3PXyF0}t'\r'druz'G8pn7E0Cb6P`p]@yPeJ+"Wl'\r'U' 'o6fj'\x0c'|2F_")
  Fatal error: exception Failure("TBD")
  TIMEOUT
