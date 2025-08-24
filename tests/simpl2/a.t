  $ cat > test.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (<= (* x (- 0 5)) 13))
  > (assert (= (+ z y) 52))
  > (assert (> (+ (* x 5) (* (pow2 y) 8) (* z 7) ) 13))
  > (check-sat)
  > EOF
  $ Chro -dsimpl -stop-after simpl2 test.smt2 | sed 's/[[:space:]]*$//'
