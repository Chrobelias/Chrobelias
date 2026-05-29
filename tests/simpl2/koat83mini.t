TODO(Kakadu)
This test doesn't simplify (not True)
  $ export CHRO_DEBUG=1
  $ Chro --dsimpl koat83mini.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (not True)
  Alphabet with extra char: 0
  
  fixed-point
  
  unsat (presimpl int)
