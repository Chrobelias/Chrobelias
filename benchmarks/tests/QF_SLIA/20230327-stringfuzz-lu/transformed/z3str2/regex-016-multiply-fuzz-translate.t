regex-016-multiply-fuzz-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-multiply-fuzz-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "L-2X!tG&3OV%0uOnd_kEdQOV%0&Oo'\n'O{7e27.nAu1e0mF|.'I'\x0b''\x0b'QW+w*/maJVV/L2OVKO'\n''\t')c0qhT|SROV%0uOva#0OVyOVVXW86""?4#+DpNzL7vGPOVKO}``50OVoO3")
  Fatal error: exception Failure("TBD")
  TIMEOUT
