5
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/2019-full_str_int/py-conbyte_cvc4/lib_int-datetime__parse_isoformat_date/5.smt2  || echo TIMEOUT
  Fatal error: exception Failure("expected term, in (bool.ite\n                   (str.prefixof \"-\" (str.substr dtstr 0 (none.sub 4 0)))\n                   (none.neg\n                    (str.to_int\n                     (str.substr (str.substr dtstr 0 (none.sub 4 0)) 1\n                      (none.sub\n                       (str.length (str.substr dtstr 0 (none.sub 4 0))) 1))))\n                   (str.to_int (str.substr dtstr 0 (none.sub 4 0))))")
  TIMEOUT
