regex-003-rotate-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-rotate-fuzz-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "oIinJgU'\x0b'Xf"<?T7h<]jhak'\n'Bzo[22v?mrH6[Nb>CbkWv3'go'\t'7iNLe'\x0c'N3Ju'j'\x0b'f,m0=!*\\*=`&p01=@DM~Mh'\\n`{]WCmWr|(lyUlCB`GK#|!<)'^~Vm2WRT~G*e")
  Fatal error: exception Failure("TBD")
  TIMEOUT
