regex-016-multiply-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-multiply-rotate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "6d7d-0c@TuL>;\\H'\n'nz0^b,N/s,T>F"/'/(PW4=b)M?HS.~ntGili2n@F'\r'J^~aab4'\t'EE+m&lZLBPcVLv?;Rj.i_]qc|>B|Po8Cb2v.' ''\x0b'119qj@'\t'7'\x0b''\x0c'YAINY&[X_#b{(ELhfdA&%0x`^TE")
  Fatal error: exception Failure("TBD")
  TIMEOUT
