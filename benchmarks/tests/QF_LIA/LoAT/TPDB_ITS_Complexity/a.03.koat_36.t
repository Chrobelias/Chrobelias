a.03.koat_36
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_36.smt2 -under2 -amin 0 -amax 11 || echo TIMEOUT
  timeout
  TIMEOUT
