regex-004-unsat-multiply-translate-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-multiply-translate-translate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "'\x0c''\x0c'{{'\r''\r'-sl--sl-'\r''\r'-sl--sl--sV0'\r'--sV0'\r'-")
  Fatal error: exception Failure("TBD")
  TIMEOUT
