  $ cp ../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_748.smt2 input.smt2

  $ export CHRO_OMIT_Z3_MODEL=1
  $ Chro -dsimpl -pre-simpl -stop-after pre-simpl input.smt2 | sed 's/[[:space:]]*$//'
  Interesting: it134 it57
  
  Expecting 4 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| it134->1 it57->1 |}
  sat (under I)


  $ unset CHRO_DEBUG
  $ OCAMLRUNPARAM='b=0' Chro -no-pre-simpl input.smt2
  sat (under I)
  $ OCAMLRUNPARAM='b=0' Chro input.smt2
  sat (under I)

