regex-006-multiply-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-006-multiply-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "8E-xp7QG9o<f.p$5A5x<||2j0_Qf&?r$%h-gaVRw)'\x0b'FxK)Q\\cKihfcd=\\XwGG>'\x0c'Pg~$U'\x0b'\\OSA%eN*TuNo#,W^P>' 'RVRs^Na4c3b-!](Jq[F*)<eX}t?KZ!|OD'Xxy}'\t'$=^X6'\t'FHp:C2O&]"'BK]d`-pPc(P*c>pQ]G+F7>x+")
  Fatal error: exception Failure("TBD")
  TIMEOUT
