size01.koat_24
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_24.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* 3 * it170) + (* -1 * it83) + (* 12 * (it83 ** 0) * it134) + (* -6 * it83 * it134) + (* 6 * (it83 ** 0)) + (* -3 * it137) + (* -8 * (it83 ** 3)) + (* -6 * it83 * (it134 ** 0))) = 0")
  TIMEOUT
