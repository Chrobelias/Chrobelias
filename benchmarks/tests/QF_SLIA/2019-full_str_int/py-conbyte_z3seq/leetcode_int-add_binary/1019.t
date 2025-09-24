1019
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/2019-full_str_int/py-conbyte_z3seq/leetcode_int-add_binary/1019.smt2  || echo TIMEOUT
  Fatal error: exception Failure("expected term, in (bool.ite\n                   (str.prefixof \"-\"\n                    (str.at b (none.add (str.length b) (none.neg 8))))\n                   (none.neg\n                    (str.to_int\n                     (str.substr\n                      (str.at b (none.add (str.length b) (none.neg 8))) 1\n                      (none.sub\n                       (str.length\n                        (str.at b (none.add (str.length b) (none.neg 8)))) 1))))\n                   (str.to_int\n                    (str.at b (none.add (str.length b) (none.neg 8)))))")
  TIMEOUT
