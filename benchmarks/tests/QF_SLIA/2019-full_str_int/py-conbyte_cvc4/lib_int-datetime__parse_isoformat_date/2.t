2
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/2019-full_str_int/py-conbyte_cvc4/lib_int-datetime__parse_isoformat_date/2.smt2  || echo TIMEOUT
  Fatal error: exception Failure("expected term, in (bool.ite\n                   (str.prefixof \"-\" (str.substr dtstr 5 (none.sub 7 5)))\n                   (none.neg\n                    (str.to_int\n                     (str.substr (str.substr dtstr 5 (none.sub 7 5)) 1\n                      (none.sub\n                       (str.length (str.substr dtstr 5 (none.sub 7 5))) 1))))\n                   (str.to_int (str.substr dtstr 5 (none.sub 7 5))))")
  TIMEOUT
