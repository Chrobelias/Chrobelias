size01.koat_105
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_105.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* -3 * it600) + (* -1 * it603) + (* 12 * (it603 ** 2) * it597) + (* 6 * (it603 ** 2)) + (* -6 * it603 * it597) + (* -8 * (it603 ** 3)) + (* 3 * it648) + (* -6 * it603 * (it597 ** 2))) = 0")
  TIMEOUT
