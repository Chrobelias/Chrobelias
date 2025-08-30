  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl test2exp.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (<= (exp 2 (+ x y)) (exp 2 z)))
  iter(2)= (<= (+ x y) z)
  iter(2.0)= (<= (+ x y) z)
  sat (underappox)
