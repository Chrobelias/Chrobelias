regex-005-unsat-rotate-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-rotate-translate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "crR4"T]VJP&_TFL*J'' '' ''' ''i^WJ'\x0b'EoFMF:!-~'\n'Xj@M\\mmra5uQ.O' 'WI~'\x0c'&^pq--\\"' '+WGx3i|Qq0I7Rrc01Pw>9O6"]{.pd8OU?' 'yw")
  Fatal error: exception Failure("TBD")
  TIMEOUT
