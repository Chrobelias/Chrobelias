  $ cat > 1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (= (+ x (* (- 1) i2)) 2) )
  > (assert (= z (- 1) ))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over-approx -bound 0 -pre-simpl -dsimpl -stop-after pre-simpl 1.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= z (* (- 1) 1))
             (= (+ x (* (* (- 1) 1) i2)) 2))
  Something ready to substitute:  x -> (+ 2 i2); z -> (- 1);
  iter(2)= (and
             (= z (- 1))
             (= (+ x (* (- 1) i2)) 2))
  iter(3)= True
  sat ; presimpl


  $ cat > 2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (declare-fun v () Int)
  > (declare-fun t () Int)
  > (assert (= (+ (exp 2 x) (exp 2 y)) (+ (exp 2 z) (exp 2 v))) )
  > (assert (= (+ t (exp 2 x)) 1))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over-approx -bound -1 -pre-simpl -dsimpl -stop-after pre-simpl 2.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= (+ t (exp 2 x)) 1)
             (= (+ (exp 2 x) (exp 2 y)) (+ (exp 2 z) (exp 2 v))))
  iter(2)= (and
             (= (+ t (exp 2 x)) 1)
             (= (+ (* (- 1) (exp 2 v)) (* (- 1) (exp 2 z)) (exp 2 x) (exp 2 y)) 0))

  $ cat > 3.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (declare-fun v () Int)
  > (assert (= (+ (* x y z) (* y (exp 2 v))) 0) )
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over-approx -bound -1 -pre-simpl -dsimpl -stop-after pre-simpl 3.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= (+ (* x y z) (* y (exp 2 v))) 0))
  iter(2)= (= (+ (* x z) (exp 2 v)) 0)



