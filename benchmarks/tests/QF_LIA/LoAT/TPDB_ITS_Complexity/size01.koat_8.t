size01.koat_8
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_8.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* -1 * it48) + (* 12 * (it48 ** 0) * it16) + (* 6 * (it48 ** 0)) + (* -8 * (it48 ** 3)) + (* -3 * it19) + (* 3 * it54) + (* -6 * it48 * it16) + (* -6 * it48 * (it16 ** 0))) = 0")
  TIMEOUT
