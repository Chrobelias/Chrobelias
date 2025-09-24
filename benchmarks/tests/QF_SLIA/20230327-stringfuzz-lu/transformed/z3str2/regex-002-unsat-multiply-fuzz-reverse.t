regex-002-unsat-multiply-fuzz-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-multiply-fuzz-reverse.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "aaa~o'b0x\\'Y'c0x\\'fo0Ol)z_b0gaa0'r\\'GLiIuC6Q)>bz,h)er+gWnjCa,5jJ`Z,8D|V'n\\'uN4jXgp{<[Zvaa1Dr!*yX_P")
  Fatal error: exception Failure("TBD")
  TIMEOUT
