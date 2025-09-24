regex-003-reverse-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-reverse-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "CUjJ(eA@v"V1iS<' '(xU+'\r'.,Lf:mwm)' 'A@+l-*qO80'\n'9yYke@'\n'TwP8?k}w'\r'|N@aW(4F_[y,]'\x0b'E~tlJ-\\I~-S' 'V}\\|#{Lxc}fTm`,ClZ@0ZvvSW7/Yxy`")
  Fatal error: exception Failure("TBD")
  TIMEOUT
