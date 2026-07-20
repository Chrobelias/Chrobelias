  $ cp ../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/realheapsort_step2.koat_311.smt2 input.smt2


  $ CHRO_DEBUG=1 Chro --dsimpl --stop-after simpl input.smt2 | sed 's/[[:space:]]*$//'
  sat (under int)
  $ timeout 2 Chro input.smt2 || echo "timeout"
  sat (under int)

$ CHRO_DEBUG=1 Chro -dsimpl -no-pre-simpl -stop-after simpl input.smt2 | sed 's/[[:space:]]*$//'
