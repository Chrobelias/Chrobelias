regex-003-multiply-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-multiply-rotate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "ijXcd<Ob3V5glQAo'\x0c'_Kh90Ke<Gb'\r'('\r'7JpS0B.|+6X4GG`cdi(>!L7^`' 'q)jdEczd'\r'}`rNpee")
  Fatal error: exception Failure("TBD")
  TIMEOUT
