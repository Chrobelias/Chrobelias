regex-016-graft-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-graft-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aacQM4/JTNct(hk4pO!i<Np' '=Eq?sd>Cnd@9a2$$'\t':W)OUul@hf,?Rfk'\r'DU92<[,NVy}&Tq|d%sL=;eh{@_;UN")
  Fatal error: exception Failure("TBD")
  TIMEOUT
