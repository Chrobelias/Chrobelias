Under `--neg-exp` a simple power `b ** x` (constant base, variable exponent)
gets a case split on the sign of x. The negative branch multiplies the
affected atoms through by b^(-x) -- the member carrying `b ** x` loses that
factor, every other member gains `b ** t` -- with a fresh t = -x solved over
t >= 1 and x restored through x + t = 0. This is the exact rational
semantics of b^x: multiplying an (in)equality by b^t > 0 preserves it.

  $ cat > negexp1.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const x Int)
  > (assert (= (* 1000 (** 2 x)) 500))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro --neg-exp negexp1.smt2
  sat (under int)
  (
     (define-fun x () Int
      -1)
  )

The nonnegative branch is untouched, so positive solutions keep working
under the flag.

  $ cat > negexp2.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const x Int)
  > (assert (= (* 4 (** 2 x)) 8))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro --neg-exp negexp2.smt2
  sat (under int)
  (
     (define-fun x () Int
      1)
  )

Neither branch admits a solution here: 3 * 2^x = 500 needs 2^x = 500/3.

  $ cat > negexp3.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const x Int)
  > (assert (= (* 3 (** 2 x)) 500))
  > (check-sat)
  > EOF
  $ Chro --neg-exp -no-model negexp3.smt2
  unsat (over)

Inequalities are multiplied through as well (by a positive factor, so the
direction is kept): 100 * 2^x <= 25 forces x <= -2.

  $ cat > negexp4.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const x Int)
  > (assert (<= (* 100 (** 2 x)) 25))
  > (assert (<= (- 2) x))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro --neg-exp negexp4.smt2
  sat (under int)
  (
     (define-fun x () Int
      -2)
  )

Without the flag the standard's truncated-division semantics applies
(2^x = 0 for x < 0, and 1000 * 0 is never 500), so the same instance is
unsatisfiable -- the two semantics genuinely diverge here.

  $ Chro -q -no-model negexp1.smt2
  unsat (over)
  no-model mode
