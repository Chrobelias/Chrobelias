  $ cat > 1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun |_q_11| () Int)
  > (declare-fun |_c_12| () Int)
  > (assert (= (+ (* |_q_11| (exp 2 256)) |_c_12|) 0))
  > (assert (<= 0 |_c_12|))
  > (check-sat)
  > EOF

  $ Chro 1.smt2
  sat (under int)
