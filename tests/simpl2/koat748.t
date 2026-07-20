  $ cp ../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_748.smt2 input.smt2

  $ export CHRO_DEBUG=1 CHRO_OMIT_Z3_MODEL=1
  $ Chro --dsimpl --stop-after pre-simpl input.smt2 | sed 's/[[:space:]]*$//'


  $ unset CHRO_DEBUG
  $ OCAMLRUNPARAM='b=0' Chro input.smt2
  sat (under int)
  $ OCAMLRUNPARAM='b=0' Chro input.smt2
  sat (under int)

