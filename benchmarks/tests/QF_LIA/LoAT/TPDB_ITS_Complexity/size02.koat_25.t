size02.koat_25
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size02.koat_25.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* -6 * (it16 ** 0) * it92) + (* -8 * (it92 ** 3)) + (* 6 * (it92 ** 0)) + (* 3 * it98) + (* -3 * it19) + (* -6 * it16 * it92) + (* 12 * it16 * (it92 ** 0)) + (* -1 * it92)) = 0")
  TIMEOUT
