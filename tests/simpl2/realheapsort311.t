  $ cp ../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/realheapsort_step2.koat_311.smt2 input.smt2


  $ Chro -dsimpl -pre-simpl -stop-after simpl input.smt2 | sed 's/[[:space:]]*$//'
  Interesting: it273 it87
  
  Expecting 4 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| i2->0 i3->5 it273->1 it648->2 it649->2 it730->20 it87->1 |}
  sat (under I)
  $ timeout 2 Chro -pre-simpl input.smt2 || echo "timeout"
  sat (under I)

$ CHRO_DEBUG=1 Chro -dsimpl -no-pre-simpl -stop-after simpl input.smt2 | sed 's/[[:space:]]*$//'
