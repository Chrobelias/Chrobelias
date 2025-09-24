regex-016-rotate-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-rotate-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "8Q)kqiyIU^@sfb/mx&FyhRS2cE.tt'\n'0(Ev'\n'p_!DhAF3dt\\JOK\\g0iWnQN^,aBJQ~'\r'`'\t'P^Ga)LrvRQW-ZvTXGT1k$'\t'<1z-R)_['\t't+hcLp(ve2e!Rd'\x0c'8' 'G4<AeO@0Tyb|a;,pc583a!'\t'sIl'\x0c'@3E6)N%qQb2'\t'nURu`|3")
  Fatal error: exception Failure("TBD")
  TIMEOUT
