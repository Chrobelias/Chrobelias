regex-019-unsat-multiply-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-019-unsat-multiply-fuzz-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "jhWOEy5y-' 'O_fUQEU_OZ2:M=zj'\t'}$CGtJ<cWv"`O^@6nzT&7VI'\t'tmc4Z4'\t'[' '/Ok='\x0c'I5E8cW.\\L8yK]7' '"Exju~2;h1rPDYHs+}h#swj]' '"^"f!es%CIp:f\\`Qq")
  Fatal error: exception Failure("TBD")
  TIMEOUT
