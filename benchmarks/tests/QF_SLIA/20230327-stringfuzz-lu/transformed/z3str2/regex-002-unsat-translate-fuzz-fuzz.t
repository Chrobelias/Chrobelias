regex-002-unsat-translate-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-translate-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "nO28dZv'\r'Ps9*TJ!+g@{MsS'\x0c'Hibcb'\n'h|wc]-%}9P' 'Cj\\jw@wvwG$q<H["Pc5Y,1&")
  Fatal error: exception Failure("TBD")
  TIMEOUT
