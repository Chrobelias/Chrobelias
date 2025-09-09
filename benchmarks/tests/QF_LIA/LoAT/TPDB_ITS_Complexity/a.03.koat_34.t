a.03.koat_34
  $ export OCAMLRUNPARAM='b=0'
-under2 -amin 0 -amax 11
$ export CHRO_DEBUG=1
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_34.smt2 -bound 0 || echo TIMEOUT
  unsat
