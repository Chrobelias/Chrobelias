  $ cat > 1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun |_q_11| () Int)
  > (declare-fun |_c_12| () Int)
  > (assert (= (+ (* |_q_11| (exp 2 256)) |_c_12|) 0))
  > (assert (<= 0 |_c_12|))
  > (check-sat)
  > EOF

  $ Chro 1.smt2
  sat (nia)

  $ cat > 2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun a () Int)
  > (declare-fun b () Int)
  > (declare-fun c () Int)
  > (assert (= (+ (* a (exp 2 100)) (* b (exp 2 50)) c) 0))
  > (assert (<= 0 c))
  > (check-sat)
  > EOF

  $ Chro 2.smt2
  sat (under int)

  $ cat > 3.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun q () Int)
  > (declare-fun c () Int)
  > (assert (= (- c (* q (exp 2 100))) 0))
  > (assert (<= 0 c))
  > (check-sat)
  > EOF

  $ Chro 3.smt2
  sat (under int)

  $ cat > 4.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun b () Int)
  > (assert (= x (ite (= b 1) (exp 2 100) 0)))
  > (check-sat)
  > EOF

  $ Chro 4.smt2
  sat (under int)

  $ cat > 5.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun t () Int)
  > (declare-fun b () Int)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun q () Int)
  > (declare-fun c () Int)
  > (declare-fun q2 () Int)
  > (declare-fun c2 () Int)
  > (assert (= (+ q c) (ite (= b 1) x y)))
  > (assert (= (+ (* q2 (exp 2 256)) c2) t))
  > (check-sat)
  > EOF

  $ Chro 5.smt2
  sat (under int)
