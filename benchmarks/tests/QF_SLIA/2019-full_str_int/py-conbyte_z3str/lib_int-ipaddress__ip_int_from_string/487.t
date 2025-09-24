487
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/2019-full_str_int/py-conbyte_z3str/lib_int-ipaddress__ip_int_from_string/487.smt2  || echo TIMEOUT
  Fatal error: exception Failure("Expression (str.contains \"0123456789ABCDEFabcdef\"\n            (str.at _EXTEND_VAR_1 (none.add 0 1))) can't be handled")
  TIMEOUT
