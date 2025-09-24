415
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/2019-full_str_int/py-conbyte_z3str/lib_int-ipaddress__ip_int_from_string/415.smt2  || echo TIMEOUT
  Fatal error: exception Failure("expected term, in (bool.ite\n                   (str.prefixof \"-\"\n                    (str.at _EXTEND_VAR_1\n                     (none.add (none.add (none.add 0 1) 1) 1)))\n                   (none.neg\n                    (str.to_int\n                     (str.substr\n                      (str.at _EXTEND_VAR_1\n                       (none.add (none.add (none.add 0 1) 1) 1)) 1\n                      (none.sub\n                       (str.length\n                        (str.at _EXTEND_VAR_1\n                         (none.add (none.add (none.add 0 1) 1) 1))) 1))))\n                   (str.to_int\n                    (str.at _EXTEND_VAR_1\n                     (none.add (none.add (none.add 0 1) 1) 1))))")
  TIMEOUT
