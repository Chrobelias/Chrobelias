regex-016-fuzz-multiply-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-fuzz-multiply-translate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "@@ee88TTNN&&' '' '||WW@@BByypp__++""__oo}}MM{{"",,::'\x0b''\x0b'WW__11qqTTqq44uu")
  Fatal error: exception Failure("TBD")
  TIMEOUT
