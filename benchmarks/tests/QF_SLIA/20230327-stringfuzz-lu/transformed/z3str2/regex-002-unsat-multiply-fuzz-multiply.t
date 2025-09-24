regex-002-unsat-multiply-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-multiply-fuzz-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "PP__XXyy**!!rrDD11aaaavvZZ[[<<{{ppggXXjj44NNuu''\\\\nn''VV||DD88,,ZZ``JJjj55,,aaCCjjnnWWgg++rree))hh,,zzbb>>))QQ66CCuuIIiiLLGG''\\\\rr''00aaaagg00bb__zz))llOO00ooff''\\\\xx00cc''YY''\\\\xx00bb''oo~~aaaaaa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
