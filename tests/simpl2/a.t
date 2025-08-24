  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl test1.smt2 | sed 's/[[:space:]]*$//'
  iteration 1
  ast(1) = (and
             (<= (+ 13 1) (+ (+ (* x 5) (* (exp 2 y) 8)) (* z 7)))
             (= (+ z y) 52)
             (<= (* x (+ 0 (* (- 1) 5))) 13))
  Something ready to substitute:  z -> (+ 52 (* (- 1) y));
  iteration 2
  ast(2) = (and
             (= (+ y z) 52)
             (<= (+ (* (- 8) (exp 2 y)) (* (- 7) z) (* (- 5) x)) (- 14))
             (<= (* (- 5) x) 13))
  iteration 3
  ast(3) = (and
             (= 0 0)
             (<= (+ (* (- 8) (exp 2 y)) (* (- 7) 52) (* (- 7) (* (- 1) y))
                 (* (- 5) x)) (- 14))
             (<= (* (- 5) x) 13))
  iteration 4
  ast(4) = (and
             (<= (+ (* (- 8) (exp 2 y)) (* (- 5) x) (* 7 y)) 350)
             (<= (* (- 5) x) 13))
  Fixpoint after 4 steps

  $ cat > testS1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (<= (* x (- 0 5)) 13))
  > (assert (= (+ z y) 52))
  > (assert (> (+ (* x 5) (* (pow2 y) 8) (* z 7) ) 13))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over-approx -bound 0 -pre-simpl -dsimpl -stop-after pre-simpl testS1.smt2 | sed 's/[[:space:]]*$//'
  iteration 1
  ast(1) = (and
             (<= (+ 13 1) (+ (+ (* x 5) (* (exp 2 y) 8)) (* z 7)))
             (= (+ z y) 52)
             (<= (* x (+ 0 (* (- 1) 5))) 13))
  Something ready to substitute:  z -> (+ 52 (* (- 1) y));
  iteration 2
  ast(2) = (and
             (= (+ y z) 52)
             (<= (+ (* (- 8) (exp 2 y)) (* (- 7) z) (* (- 5) x)) (- 14))
             (<= (* (- 5) x) 13))
  iteration 3
  ast(3) = (and
             (= 0 0)
             (<= (+ (* (- 8) (exp 2 y)) (* (- 7) 52) (* (- 7) (* (- 1) y))
                 (* (- 5) x)) (- 14))
             (<= (* (- 5) x) 13))
  iteration 4
  ast(4) = (and
             (<= (+ (* (- 8) (exp 2 y)) (* (- 5) x) (* 7 y)) 350)
             (<= (* (- 5) x) 13))
  Fixpoint after 4 steps
