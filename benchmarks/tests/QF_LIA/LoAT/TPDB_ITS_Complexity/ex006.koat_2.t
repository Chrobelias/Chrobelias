ex006.koat_2
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/ex006.koat_2.smt2 || echo TIMEOUT
  sat ; underapprox1
