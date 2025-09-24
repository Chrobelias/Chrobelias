regex-005-unsat-fuzz-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-fuzz-rotate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "a$?m6*l[)u.q_+c`UvU>rT\\L-/M\\=*no6+g~@vtM\\'\x0b'e*P;?'\x0b'v68cQn(o"EQJ'\n'[j??%|LFG.cd0x'\r'?_' '50GEH'\r'aE{F4}[eRhoU+b'\t'S#?Ic7cGszn@U(ot4+$:;N}tQ*%.guD'\t'nFTO&;T$9sh9Mfc<I2>gI'\x0c'e~N]CwsU~urYN6t2~t+1'crrI7!v#ZbGA6b!R&"[<")
  Fatal error: exception Failure("TBD")
  TIMEOUT
