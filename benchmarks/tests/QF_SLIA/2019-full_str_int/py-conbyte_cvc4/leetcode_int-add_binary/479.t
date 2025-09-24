479
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/2019-full_str_int/py-conbyte_cvc4/leetcode_int-add_binary/479.smt2  || echo TIMEOUT
  Fatal error: exception Failure("expected term, in (bool.ite\n                   (str.prefixof \"-\"\n                    (str.at a (none.add (str.length a) (none.neg 4))))\n                   (none.neg\n                    (str.to_int\n                     (str.substr\n                      (str.at a (none.add (str.length a) (none.neg 4))) 1\n                      (none.sub\n                       (str.length\n                        (str.at a (none.add (str.length a) (none.neg 4)))) 1))))\n                   (str.to_int\n                    (str.at a (none.add (str.length a) (none.neg 4)))))")
  TIMEOUT
