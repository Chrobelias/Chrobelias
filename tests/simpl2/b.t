  $ cat > testS1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (= (+ z y) 52))
  > (assert (= (+ z x) 32))
  > (assert (< 111111 (+ (exp 2 x) (exp 2 y)) ))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over-approx -bound 0 -pre-simpl -dsimpl -stop-after pre-simpl testS1.smt2 | sed 's/[[:space:]]*$//'
  iteration 1
  ast(1) = (and
             (<= (+ 111111 1) (+ (exp 2 x) (exp 2 y)))
             (= (+ z x) 32)
             (= (+ z y) 52))
  Something ready to substitute:  z -> (+ 32 (* (- 1) x));
  iteration 2
  ast(2) = (and
             (= (+ x z) 32)
             (= (+ y z) 52)
             (<= (+ (* (- 1) (exp 2 x)) (* (- 1) (exp 2 y))) (- 111112)))
  iteration 3
  ast(3) = (and
             (= 0 0)
             (= (+ y (* (- 1) x)) 20)
             (<= (+ (* (- 1) (exp 2 x)) (* (- 1) (exp 2 y))) (- 111112)))
  iteration 4
  ast(4) = (and
             (= (+ y (* (- 1) x)) 20)
             (<= (+ (* (- 1) (exp 2 x)) (* (- 1) (exp 2 y))) (- 111112)))
  Fixpoint after 4 steps
