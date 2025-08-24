  $ Chro -pre-simpl -dsimpl -stop-after pre-simpl test2exp.smt2 | sed 's/[[:space:]]*$//'
  iteration 1
  ast(1) = (and
             (<= (exp 2 (+ x y)) (exp 2 z)))
  iteration 2
  ast(2) = (<= (+ x y) z)
  Fixpoint after 2 steps
