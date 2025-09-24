regex-005-unsat-fuzz-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-fuzz-fuzz-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "aa$16@gHq;E'\\n'M@R*`J<'\\r'}OkQ'\\x0c'Aj""=FLM?FmjaPxLZ'\\x0b'.u#}s'\\t'FKLe=QIIL<\\\\-|n'w8'\\n'3Z$?p<55^w*-59'\\r'U8CQP`Q'\\x0b'""ILJI'\\n'B<K}Q'\\t'WaNQe9P,""Pi""P]>_tc(O'\\x0c'B->x8;~.&fb")
  Fatal error: exception Failure("TBD")
  TIMEOUT
