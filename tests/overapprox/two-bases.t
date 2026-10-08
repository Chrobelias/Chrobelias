Powers of different bases with the same exponent get different variables in
the overapproximation. With one variable for 2^x and 3^x, z = 3^x - 2^x
became 0 and this formula was answered unsat; x = 4, z = 65 is a model.

  $ cat > two-bases.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun z () Int)
  > (assert (>= x 1))
  > (assert (= (mod z 7) 2))
  > (assert (= (+ (exp 2 x) z) (exp 3 x)))
  > (check-sat)
  > EOF

  $ Chro two-bases.smt2 | cut -d' ' -f1
  unknown
