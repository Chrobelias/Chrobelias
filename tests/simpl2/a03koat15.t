  $ cp ../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_15.smt2 input.smt2
$ cat input.smt2
  $ Chro -dsimpl -pre-simpl -stop-after pre-simpl input.smt2 | sed 's/[[:space:]]*$//'
  unsat
