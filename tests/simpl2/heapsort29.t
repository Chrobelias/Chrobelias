  $ cp ../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/heapsort.c.koat_29.smt2 input.smt2

  $ Chro -dsimpl -pre-simpl -stop-after pre-simpl input.smt2 | sed 's/[[:space:]]*$//'
  Interesting: it147
  
  Expecting 2 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| i10->6 i2->0 it147->1 it154->2 it155->3 it157->3 it158->1 it159->3
        it163->0 it168->27 it2->0 it4->1 |}
  sat (under I)


  $ unset CHRO_DEBUG
$ Chro -no-pre-simpl input.smt2
sat (underapprox2)
  $ Chro input.smt2
  sat (under I)

