a.03.koat_25
  $ export OCAMLRUNPARAM='b=0'
$ export CHRO_DEBUG=1
  $ timeout 5 Chro -bound 0 ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_25.smt2 -under2 -amin 0 -amax 11 || echo TIMEOUT
  timeout
  TIMEOUT
