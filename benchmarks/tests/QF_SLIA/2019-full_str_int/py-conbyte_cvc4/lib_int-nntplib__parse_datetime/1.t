1
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/2019-full_str_int/py-conbyte_cvc4/lib_int-nntplib__parse_datetime/1.smt2  || echo TIMEOUT
  Fatal error: exception Failure("Expression (str.prefixof \"-\"\n            (str.substr\n             (str.substr date_str 0\n              (none.sub (none.add (str.length date_str) (none.neg 6)) 0))\n             (none.add\n              (str.length\n               (str.substr date_str 0\n                (none.sub (none.add (str.length date_str) (none.neg 6)) 0)))\n              (none.neg 2))\n             (none.sub\n              (str.length\n               (str.substr date_str 0\n                (none.sub (none.add (str.length date_str) (none.neg 6)) 0)))\n              (none.add\n               (str.length\n                (str.substr date_str 0\n                 (none.sub (none.add (str.length date_str) (none.neg 6)) 0)))\n               (none.neg 2))))) can't be handled")
  TIMEOUT
