When the most significant part of a power is longer than -huge, model
generation reads the model from the word built so far. That word contains
all digits of the terms up to the successor of the power; the coordinates
of the larger terms are truncated and must not be substituted. With
-huge 100 each system below used to give "no short model", although its
variable x has a short model.

The term 5x + 5 lies between 5x and 2**(5x): its leading digit can be above
the word built so far, which then reads 4 for it.

  $ cat > truncated-linear.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-fun x () Int)
  > (assert (>= x 0))
  > (assert (= (mod (+ (* 5 (exp 2 (+ 5 (* 5 x)))) (- (exp 2 (exp 2 (* 5 x))))) 18) 16))
  > (check-sat)
  > (get-model)
  > EOF

  $ Chro -no-parallel -huge 100 truncated-linear.smt2
  sat (nfa)
  (
     (define-fun x () Int
      51)
  )

The variable introduced for 2**(6x + 2) is equal to this power and is ordered
below it, but its leading digit is not in the word built so far either.

  $ cat > tied-power.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-fun x () Int)
  > (assert (>= x 17))
  > (assert (= (mod (exp 2 (exp 2 (+ 2 (* 6 x)))) 19) 16))
  > (check-sat)
  > (get-model)
  > EOF

  $ Chro -no-parallel -huge 100 tied-power.smt2
  sat (nfa)
  (
     (define-fun x () Int
      87381)
  )

Here all coordinates are complete, but 2**(9x + 3) is not evaluated, because
its exponent exceeds -huge; its equality with the variable introduced for it
becomes an equality over this power alone, which gives no value of x.

  $ cat > unevaluated-power.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-fun x () Int)
  > (assert (>= x 11))
  > (assert (<= x 20))
  > (assert (= (mod (+ (* (- 5) x) (- (exp 2 (* 5 x))) (- (exp 2 (exp 2 (+ 3 (* 9 x)))))) 32) 21))
  > (check-sat)
  > (get-model)
  > EOF

  $ Chro -no-parallel -huge 100 unevaluated-power.smt2
  sat (nfa)
  (
     (define-fun x () Int
      15)
  )
