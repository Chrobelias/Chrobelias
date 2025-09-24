regex-003-multiply-fuzz-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-multiply-fuzz-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "So>c,0y>@!^1bwySoS' 'j4RRqu'\x0b'VJpA>cV>>c,0y>PxGqv'f\\fa>c,0S>_1#>cV>Za3o>cW>A3g-WP.*>cW>0u6Q-CH")
  Fatal error: exception Failure("TBD")
  TIMEOUT
