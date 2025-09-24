regex-002-unsat-multiply-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-multiply-translate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "f'aR|4{ZG' 'yVafwj[bzr=NjlkVV"}nAJ&;F*xCYh)9T>Olj' 'Ww4\\1Le;'\x0c'")
  Fatal error: exception Failure("TBD")
  TIMEOUT
