regex-016-fuzz-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-fuzz-rotate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "a8oReX<nVV(s>G~?Psu*uGek'\x0c'c_$o]Paz^gXeXad9%c+(?<$cUTl@Y0uj\\E@R;Dc+h<9>;NJQwV0d!kiLmHdC)dGq%WlM1;Q_{};<npb'\x0c'a2hc&Stu'\r')gstg"p'\r'[^y|AU~HR&B|'\x0b'$}m0UnM%FQKc6#4yFrjWw'\n'ifTxl)4Y' '*FRa7i88Nw#jY)")
  Fatal error: exception Failure("TBD")
  TIMEOUT
