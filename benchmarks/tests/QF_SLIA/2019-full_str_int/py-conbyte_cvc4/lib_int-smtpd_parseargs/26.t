26
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/2019-full_str_int/py-conbyte_cvc4/lib_int-smtpd_parseargs/26.smt2  || echo TIMEOUT
  Fatal error: exception Failure("Expression (str.prefixof \"-\"\n            (str.substr arg1 (none.add (str.indexof arg1 \":\" 0) 1)\n             (none.sub (str.length arg1)\n              (none.add (str.indexof arg1 \":\" 0) 1)))) can't be handled")
  TIMEOUT
