  $ CHRO_DEBUG=1 Chro  --dsimpl --stop-after pre-simpl test2exp.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (<= (exp 2 (+ x y)) (exp 2 z))
  Alphabet with extra char: 0
  
  iter(2)= (<= (+ x y) z)
  fixed-point
  
