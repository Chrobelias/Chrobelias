regex-019-unsat-translate-reverse-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-019-unsat-translate-reverse-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "CL'\x0c'4'\x0c'<.R"w*W;?d"(\\Ln<P'\t'Kt'\x0b''\x0b'X+6Ns5bGCtkdHLEjU""'\r'TCC'\x0c'by'\t'M""""""BgZ@q'qG|YVr:")
  Fatal error: exception Failure("TBD")
  TIMEOUT
