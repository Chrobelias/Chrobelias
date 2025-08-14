MysteriousProgram.jar-obl-12.smt2_512
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Termination/MysteriousProgram.jar-obl-12.smt2_512.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented 0 <= (+ it127 + (* -1 * it1871 * (+ -1 + it996)) + (* -1 * it1872) + (* -1 * (+ -1 + it996) * it375) + (* -1 * it375))")
  TIMEOUT
