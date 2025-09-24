regex-003-fuzz-graft-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-fuzz-graft-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "hE9ytS!hrk1pY'3B;7]>pQt;>'\x0c'vP5KTLd&rhlv>9B8)f' 'vx/Q(4Rx+HQ}OUIIZ$d4pJ)r&{+'\n'!sGjw' 'ch[Hcb_@<h'\r'MtR3|e7KC$xRta11),x/8'KY,fn)2g|Bti:SM"*QCx_|d`N'\x0c'u'\t'xd=-7r'#,F"xOtf;jKR?c~O5\\!'\x0c'j&gP#r}?%>WjOjQZVK' '' '+'\t'0Z~\\Nisd")
  Fatal error: exception Failure("TBD")
  TIMEOUT
