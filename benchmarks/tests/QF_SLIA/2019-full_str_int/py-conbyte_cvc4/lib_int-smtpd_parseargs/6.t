6
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/2019-full_str_int/py-conbyte_cvc4/lib_int-smtpd_parseargs/6.smt2  || echo TIMEOUT
  Not implemented comparison:
  	(= %3 (str.len arg1))
  	(= %5 (str.len arg2))
  Fatal error: exception File "lib/Simpl_alpha.ml", line 50, characters 6-12: Assertion failed
  TIMEOUT
