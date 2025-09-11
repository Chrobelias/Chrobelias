  $ cat > 1.smt2 <<-EOF
  > (set-logic LIA)
  > (assert (forall ((x Int)) (exists ((y Int)) (or (= x (* 3 y)) (= x (+ (* 3 y) 1)) (= x (+ (* 3 y) 2))))))
  > (check-sat) ; sat
  > EOF
  $ z3 1.smt2
