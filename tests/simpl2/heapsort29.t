  $ cp ../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/heapsort.c.koat_29.smt2 input.smt2

  $ export CHRO_DEBUG=1
  $ Chro --dsimpl  --stop-after pre-simpl input.smt2 | sed 's/[[:space:]]*$//'


  $ unset CHRO_DEBUG
$ Chro -no-pre-simpl input.smt2
sat (underapprox2)
  $ Chro input.smt2
  sat (under int)

