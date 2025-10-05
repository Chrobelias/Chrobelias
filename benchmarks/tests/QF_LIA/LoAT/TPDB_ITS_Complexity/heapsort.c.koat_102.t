heapsort.c.koat_102
  $ export OCAMLRUNPARAM='b=0'
$ export CHRO_DEBUG=1

  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/heapsort.c.koat_102.smt2 || echo TIMEOUT
  sat ; underapprox1
