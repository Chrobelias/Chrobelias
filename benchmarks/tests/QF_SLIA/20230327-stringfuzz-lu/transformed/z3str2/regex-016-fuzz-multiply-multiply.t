regex-016-fuzz-multiply-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-fuzz-multiply-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "aaaa{{{{8888oooo++++ssssuuuuVVVVbbbbaaaaEEEE$$$$!!!!ddddCCCC))))ddddGGGG((((qqqq::::))))....AAAAUUUUbbbbdddd1111nnnnoooonnnn4444;;;;")
  Fatal error: exception Failure("TBD")
  TIMEOUT
