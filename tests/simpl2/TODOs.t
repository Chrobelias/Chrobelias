  $ export CHRO_DEBUG=1
  $ cat > TODO1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (assert (<= (+ (* 5 x1) x2) (* 6 x2) ))
  > (check-sat)
  > EOF
  $ Chro -pre-simpl -dsimpl -stop-after pre-simpl TODO1.smt2 | sed 's/[[:space:]]*$//'
  iteration 1
  ast(1) = (and
             (<= (+ (* 5 x1) x2) (* 6 x2)))
  iteration 2
  ast(2) = (<= (+ x2 (* 5 x1)) (* 6 x2))
  Fixpoint after 2 steps
Should be (<= x 2)
  $ cat > TODO2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (assert (<= (* 5 x1) 13))
  > (check-sat)
  > EOF
  $ Chro -pre-simpl -dsimpl -stop-after pre-simpl TODO2.smt2 | sed 's/[[:space:]]*$//'
  iteration 1
  ast(1) = (and
             (<= (* 5 x1) 13))
  iteration 2
  ast(2) = (<= (* 5 x1) 13)
  Fixpoint after 2 steps


  $ cat > TODO2.smt2 <<-EOF
  > (set-logic ALL)
  > (assert (= (+ 2 6) 8))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl TODO2.smt2 | sed 's/[[:space:]]*$//'
  iteration 1
  ast(1) = (and
             (= (+ 2 6) 8))
  iteration 2
  ast(2) = True
  Fixpoint after 2 steps


  $ cat > TODO2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (assert (<= (+ x1 (* (- 1) x1)) 8))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl TODO2.smt2 | sed 's/[[:space:]]*$//'
  iteration 1
  ast(1) = (and
             (<= (+ x1 (* (* (- 1) 1) x1)) 8))
  iteration 2
  ast(2) = True
  Fixpoint after 2 steps

  $ cat > i3.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun i3 () Int)
  > (declare-fun it1092 () Int)
  > (declare-fun it1094 () Int)
  > (declare-fun it1095 () Int)
  > (assert (= (+ (+ it1095 (* i3 (* (- 1) 2))) 2) 0))
  > (assert (= (+ (+ (* i3 (* (- 1) 1)) it1094) 1) 0))
  > (assert (= (+ (+ it1092 (* i3 (* (- 1) 1))) 1) 0))
  > (assert (<= 0 (+ i3 (* (- 1) 2))))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl i3.smt2 | sed 's/[[:space:]]*$//'
  iteration 1
  ast(1) = (and
             (<= 0 (+ i3 (* (* (- 1) 1) 2)))
             (= (+ (+ it1092 (* i3 (* (* (- 1) 1) 1))) 1) 0)
             (= (+ (+ (* i3 (* (* (- 1) 1) 1)) it1094) 1) 0)
             (= (+ (+ it1095 (* i3 (* (* (- 1) 1) 2))) 2) 0))
  iteration 2
  ast(2) = (and
             (= (+ it1092 (* (- 1) i3)) (- 1))
             (= (+ it1094 (* (- 1) i3)) (- 1))
             (= (+ it1095 (* (- 2) i3)) (- 2))
             (<= (* (- 1) i3) (- 2)))
  Something ready to substitute:  it1092 -> (+ (- 1) i3); it1094 -> (+ (- 1)
                                                                    i3); it1095 ->
                                 (+ (- 2) (* 2 i3));
  iteration 3
  ast(3) = (and
             (= (+ it1092 (* (- 1) i3)) (- 1))
             (= (+ it1094 (* (- 1) i3)) (- 1))
             (= (+ it1095 (* (- 2) i3)) (- 2))
             (<= (* (- 1) i3) (- 2)))
  iteration 4
  ast(4) = (and
             (= 0 0)
             (= (+ (* (- 2) i3) (* 2 i3)) 0)
             (<= (* (- 1) i3) (- 2)))
  iteration 5
  ast(5) = (and
             (= (+ (* (- 2) i3) (* 2 i3)) 0)
             (<= (* (- 1) i3) (- 2)))
  Fixpoint after 5 steps
Fold exps
  $ cat > i3.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun it134 () Int)
  > (declare-fun it1095 () Int)
  > (assert (<= (* (exp 2 (+ (- 1) it134)) (exp 2 it134)) 2))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl i3.smt2 | sed 's/[[:space:]]*$//'
  iteration 1
  ast(1) = (and
             (<= (* (exp 2 (+ (* (- 1) 1) it134)) (exp 2 it134)) 2))
  iteration 2
  ast(2) = (<= (* (exp 2 it134) (exp 2 (+ (- 1) it134))) 2)
  Fixpoint after 2 steps

  $ cat > i3.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun it134 () Int)
  > (declare-fun it1095 () Int)
  > (assert (<= (* (exp 2 (+ (- 1) it134)) (exp 2 it134)) 2))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl i3.smt2 | sed 's/[[:space:]]*$//'
  iteration 1
  ast(1) = (and
             (<= (* (exp 2 (+ (* (- 1) 1) it134)) (exp 2 it134)) 2))
  iteration 2
  ast(2) = (<= (* (exp 2 it134) (exp 2 (+ (- 1) it134))) 2)
  Fixpoint after 2 steps


$ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl hack1.smt2 | sed 's/[[:space:]]*$//'

  $ cat > it646.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun it646 () Int)
  > (assert (<= (+ it646
  >                (* (- 2) it646)
  >                (* (- 1) it646))
  >             (- 2)) )
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl it646.smt2 | sed 's/[[:space:]]*$//'
  iteration 1
  ast(1) = (and
             (<= (+ (+ it646 (* (* (- 1) 2) it646)) (* (* (- 1) 1) it646))
             (* (- 1) 2)))
  iteration 2
  ast(2) = (<= (+ it646 (* (- 2) it646) (* (- 1) it646)) (- 2))
  Fixpoint after 2 steps
