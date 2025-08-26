  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl test3rec.smt2 | sed 's/[[:space:]]*$//'
  iteration 1
  ast(1) = (and
             (= (+ y x) 13)
             (= (+ x y) 13))
  Something ready to substitute:  y -> (+ 13 (* (- 1) x));
  iteration 2
  ast(2) = (= (+ x y) 13)
  iteration 3
  ast(3) = (= 0 0)
  iteration 4
  ast(4) = True
  Fixpoint after 4 steps

  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl test4rec.smt2 | sed 's/[[:space:]]*$//'
  iteration 1
  ast(1) = (and
             (= (+ z x) 10000)
             (= (+ y z) 100)
             (= (+ x y) 1))
  Something ready to substitute:  x -> (+ 1 (* (- 1) y)); z -> (+ 10000
                                                               (* (- 1) x));
  iteration 2
  ast(2) = (and
             (= (+ x y) 1)
             (= (+ x z) 10000)
             (= (+ y z) 100))
  iteration 3
  ast(3) = (and
             (= 0 0)
             (= (+ y (* (- 1) x)) (- 9900))
             (= (+ (* (- 1) x) (* (- 1) y)) (- 1)))
  iteration 4
  ast(4) = (and
             (= (+ y (* (- 1) 1) (* (- 1) (* (- 1) y))) (- 9900))
             (= (+ (* (- 1) y) (* (- 1) 1) (* (- 1) (* (- 1) y))) (- 1)))
  iteration 5
  ast(5) = (and
             (= 0 0)
             (= (+ y y) (- 9899)))
  iteration 6
  ast(6) = (and
             (= (+ y y) (- 9899)))
  iteration 7
  ast(7) = (= (+ y y) (- 9899))
  Fixpoint after 7 steps
