TODO(Kakadu)
This test doesn't simplify (not True)
  $ export CHRO_DEBUG=simpl
  $ Chro --dsimpl koat83mini.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (not True)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    fixed-point
  
  unsat (presimpl int)
