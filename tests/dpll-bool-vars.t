  $ cat > bool-str.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun b () Bool)
  > (assert (or b (= x "a")))
  > (assert (not (= x "a")))
  > (check-sat)
  > EOF

  $ Chro -no-parallel bool-str.smt2 | cut -d' ' -f1
  sat

The Boolean variables stay out of the theory candidates: as atoms of the NFA
Solver they made every candidate unknown. The model takes b from the SAT model.

  $ cat > bool-exp.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun b () Bool)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (assert (>= x 1))
  > (assert (= y (exp 2 x)))
  > (assert (or b (> x 5)))
  > (assert (or (not b) (= (mod y 7) 2)))
  > (check-sat)
  > (get-model)
  > EOF

  $ Chro -bound -1 --check-model bool-exp.smt2
  sat (nfa)
  (
     (define-fun b () Bool
      true)
     (define-fun x () Int
      1)
     (define-fun y () Int
      2)
  )
