
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
Should be (<= x1 (* 2 x2))
  $ cat > TODO2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (assert (<= (* 5 x1) (* 10 x2) ))
  > (check-sat)
  > EOF
  $ Chro -pre-simpl -dsimpl -stop-after pre-simpl TODO2.smt2 | sed 's/[[:space:]]*$//'
  iteration 1
  ast(1) = (and
             (<= (* 5 x1) (* 10 x2)))
  iteration 2
  ast(2) = (<= (* 5 x1) (* 10 x2))
  Fixpoint after 2 steps
