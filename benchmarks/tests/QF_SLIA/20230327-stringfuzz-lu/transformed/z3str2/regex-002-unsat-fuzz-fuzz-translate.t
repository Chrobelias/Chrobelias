regex-002-unsat-fuzz-fuzz-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-fuzz-fuzz-translate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x ",}0Q,'\n'?BF'\x0b'@,'\t'H"<idg{0Vd'\t'>AMvH?tb+SH_QiT(;p\\lWW'\x0b''\r'D:V?dedfp6+V'\t'kB{.{K'\t'ngg!dg|dZOdg|dv,Z/ES' 'iwH4DWWFded'\x0b'^,njf:>Z!adnp' '_'\n'kr+!O9v4B$dL)@YAzv<TMjZ?J'X;'\t'"!y'\r'rt'B,owD)Zdg{0Vds'\t'.JggH43")
  Fatal error: exception Failure("TBD")
  TIMEOUT
