regex-016-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "t\\]Wea~@}!'\x0c''\r'2k"ns1_nqza7U.uwWk3'9~2a#}lX:vmSF_Tmylk{x'\n'NYj{t'\t'FP>HSEv#ww*(cWPD:J-]B]"9'\n'g1x+' 'q2AVxSi~bZ]XlAA^/EC'\n'K}8`'\r'U:B")
  Fatal error: exception Failure("TBD")
  TIMEOUT
