1
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/2019-full_str_int/py-conbyte_cvc4/lib_int-datetime__parse_isoformat_date/1.smt2  || echo TIMEOUT
  Fatal error: exception Failure("Expression (str.prefixof \"-\" (str.substr dtstr 8 (none.sub 10 8))) can't be handled")
  TIMEOUT
