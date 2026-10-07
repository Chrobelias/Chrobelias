  $ cat > bool-exp.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (declare-fun b () Bool)
  > (assert (>= x 10))
  > (assert (= y (exp 2 x)))
  > (assert (<= z y))
  > (assert (not b))
  > (check-sat)
  > EOF

  $ Chro -no-parallel bool-exp.smt2 | cut -d' ' -f1
  unknown
