24
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/2019-full_str_int/py-conbyte_cvc4/lib_int-smtpd_parseargs/24.smt2  || echo TIMEOUT
  Fatal error: exception Failure("Expression (str.prefixof \"-\"\n            (str.substr \"localhost:8025\" (none.add 9 1)\n             (none.sub (str.length \"localhost:8025\") (none.add 9 1)))) can't be handled")
  TIMEOUT
