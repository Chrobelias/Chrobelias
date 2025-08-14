size04.koat_180
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size04.koat_180.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* -6 * it553 * it117 * it549) + (* -3 * it552) + (* -6 * it117 * it499 * (it549 ** 2)) + (* -8 * (it553 ** 3) * (it117 ** 3)) + (* 12 * (it553 ** 2) * (it117 ** 2) * it549) + (* -8 * (it117 ** 3) * (it499 ** 3)) + (* 24 * it553 * (it117 ** 2) * it499 * it549) + (* 6 * (it117 ** 2) * (it499 ** 2)) + (* 12 * (it117 ** 2) * (it499 ** 2) * it549) + (* -24 * it553 * (it117 ** 3) * (it499 ** 2)) + (* 3 * it737) + (* 12 * it553 * (it117 ** 2) * it499) + (* -6 * it553 * it117 * (it549 ** 2)) + (* 6 * (it553 ** 2) * (it117 ** 2)) + (* -6 * it117 * it499 * it549) + (* -1 * it117 * it499) + (* -24 * (it553 ** 2) * (it117 ** 3) * it499) + (* -1 * it553 * it117)) = 0")
  TIMEOUT
