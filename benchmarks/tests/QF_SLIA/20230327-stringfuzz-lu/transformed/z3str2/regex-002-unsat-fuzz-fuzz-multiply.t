regex-002-unsat-fuzz-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-fuzz-fuzz-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "nnEE00BBnnYYkkddRRMMVVnn[[~~LLsshh''\\\\xx00bb''[[==TT//pp~~kk$$FFllZZ~~##BBhh__wwJJHH))ii""""MM^^UU??bbkk''' '' '''QQHH66llbb[[ooddxxqqxxyy[[!!\\\\\\\\DD''\\\\rr''II||''\\\\rr''ppnnII}}%%ZZaahhAA~~44UU""""RR''' '' '''MM>>nn!!::QQ??==IIDDjj''!!HHaa##YYooGGllDD||99pp44dd,,''uu{{VVCCTT``ppss__//::IIkkKK++((JJ[[LLDD..^^GG$$++ddnnSSAAUU{{II''\\\\xx00bb''OO[[qqKK\\\\\\\\~~4433")
  Fatal error: exception Failure("TBD")
  TIMEOUT
