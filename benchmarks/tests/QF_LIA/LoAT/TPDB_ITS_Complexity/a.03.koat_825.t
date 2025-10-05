a.03.koat_825
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_825.smt2 || echo TIMEOUT
  sat ; underapprox1
