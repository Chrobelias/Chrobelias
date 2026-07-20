TODO(Kakadu)
This test doesn't simplify (not True)
  $ export CHRO_DEBUG=1
  $ Chro --dsimpl koat83mini.smt2 | sed 's/[[:space:]]*$//'
  unsat (presimpl int)
