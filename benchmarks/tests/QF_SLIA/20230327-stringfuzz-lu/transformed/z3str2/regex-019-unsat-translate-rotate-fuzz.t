regex-019-unsat-translate-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-019-unsat-translate-rotate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x ".xehV%vQly[Y5>"@,H@SlSDmb{z'\x0b'm"Kl"",S2"f+;s}e_>/ww6p=="-'\n'EH4SmfG)?A"i.yG/'\r'N'\r'NZPJ1a")
  Fatal error: exception Failure("TBD")
  TIMEOUT
