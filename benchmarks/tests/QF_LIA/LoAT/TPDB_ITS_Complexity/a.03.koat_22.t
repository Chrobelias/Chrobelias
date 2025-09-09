a.03.koat_22
  $ export OCAMLRUNPARAM='b=0'
$ export CHRO_DEBUG=1
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_22.smt2 || echo TIMEOUT
  unsat
