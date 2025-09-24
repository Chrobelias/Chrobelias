regex-004-unsat-multiply-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-multiply-translate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "E2>1]&<W'ltjsA2z<X2X[c<7>~'HU6h{pSgP;r'rXS<@&Nx'\x0c'vOCn|DznnJ<d9YbnCR'\t'' '9Uxm?(r2E,r>]:+a/FrF{-+&$QV&p''Qc)_Ufj5\\7>'\r'3gaj~wj}Oe\\b'\\x'")
  Fatal error: exception Failure("TBD")
  TIMEOUT
