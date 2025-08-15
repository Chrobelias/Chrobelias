size09.koat_12
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size09.koat_12.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* 12 * (it15 ** 0) * it3) + (* 3 * it21) + (* -6 * it15 * it3) + (* -1 * it15) + (* -3 * it6) + (* 6 * (it15 ** 0)) + (* -6 * it15 * (it3 ** 0)) + (* -8 * (it15 ** 3))) = 0")
  TIMEOUT
