3
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/2019-full_str_int/py-conbyte_cvc4/lib_int-http_parse_request/3.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.substr\n                  (str.substr version\n                   (none.add (str.indexof version \"/\" 0) 1)\n                   (none.sub (str.length version)\n                    (none.add (str.indexof version \"/\" 0) 1))) 0\n                  (none.sub\n                   (str.indexof\n                    (str.substr version\n                     (none.add (str.indexof version \"/\" 0) 1)\n                     (none.sub (str.length version)\n                      (none.add (str.indexof version \"/\" 0) 1))) \".\" 0) 0)) as string")
  TIMEOUT
