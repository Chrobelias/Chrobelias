  $ cat > xor_sat.smt2 <<-SMT
  > (set-logic ALL)
  > (declare-const x Int)
  > (declare-const y Int)
  > (assert (xor (> x 1) (> y 2)))
  > (assert (> x 5))
  > (check-sat)
  > (get-model)
  > SMT
  $ Chro --check-model xor_sat.smt2
  sat (under int)
  (
     (define-fun x () Int
      6)
     (define-fun y () Int
      0)
  )

  $ cat > xor_unsat.smt2 <<-SMT
  > (set-logic ALL)
  > (declare-const x Int)
  > (assert (xor (> x 1) (> x 1)))
  > (check-sat)
  > SMT
  $ Chro --check-model xor_unsat.smt2
  unsat (nia)
