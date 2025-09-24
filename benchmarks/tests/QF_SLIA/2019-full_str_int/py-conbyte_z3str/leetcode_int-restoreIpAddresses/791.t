791
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/2019-full_str_int/py-conbyte_z3str/leetcode_int-restoreIpAddresses/791.smt2  || echo TIMEOUT
  Fatal error: exception Failure("expected term, in (bool.ite\n                   (str.prefixof \"-\"\n                    (str.substr s 0 (none.sub (none.add 1 1) 0)))\n                   (none.neg\n                    (str.to_int\n                     (str.substr (str.substr s 0 (none.sub (none.add 1 1) 0))\n                      1\n                      (none.sub\n                       (str.length\n                        (str.substr s 0 (none.sub (none.add 1 1) 0))) 1))))\n                   (str.to_int (str.substr s 0 (none.sub (none.add 1 1) 0))))")
  TIMEOUT
