24
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/2019-full_str_int/py-conbyte_z3seq/lib_int-datetime__parse_hh_mm_ss_ff/24.smt2  || echo TIMEOUT
  Fatal error: exception Failure("Expression (str.prefixof \"-\"\n            (str.substr tstr\n             (none.add\n              (none.add (none.add (none.add (none.add (none.add 0 2) 1) 2) 1)\n               2) 1)\n             (none.sub (str.length tstr)\n              (none.add\n               (none.add\n                (none.add (none.add (none.add (none.add 0 2) 1) 2) 1) 2) 1)))) can't be handled")
  TIMEOUT
