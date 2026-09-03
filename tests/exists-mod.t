An existentially quantified variable which occurs linearly in a single
equation is a divisibility in disguise: `(exists ((x Int)) (= y (* 2 x)))` is
`y = 0 (mod 2)`. The pre-simplification keeps the quantifier; the fold into a
congruence happens at the IR level (`Ir.exists_to_div`, running after
`antiprenex` has shrunk each quantifier to its minimal scope), where it
replaces an unbounded quantified automaton track plus a projection with the
small direct `NfaCollection.mod_eq` automaton.

  $ cat > divides.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun y () Int)
  > (assert (exists ((x Int)) (= y (* 2 x))))
  > (check-sat)
  > EOF
  $ Chro --dpresimpl --stop-after presimpl divides.smt2
  (exists (x) (= (+ (* (- 2) x) y) 0))

The congruence is what constrains the rest of the formula, so a model has to
respect it. Here y is pinned between 10 and 13, hence y = 12.

  $ cat > model.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun y () Int)
  > (assert (exists ((x Int)) (= y (* 6 x))))
  > (assert (<= 10 y))
  > (assert (<= y 13))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro --dpresimpl --stop-after presimpl model.smt2
  (and
    (<= (+ (- 13) y) 0)
    (<= (+ 10 (* (- 1) y)) 0)
    (exists (x) (= (+ (* (- 6) x) y) 0)))
  $ Chro --info -no-over -bound -1 model.smt2
  sat (nfa)
  (
     (define-fun y () Int
      12)
  )

Without a multiple of 6 in the range the same formula is unsat.

  $ cat > unsat.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun y () Int)
  > (assert (exists ((x Int)) (= y (* 6 x))))
  > (assert (<= 13 y))
  > (assert (<= y 17))
  > (check-sat)
  > EOF
  $ Chro --info -no-over -bound -1 unsat.smt2
  unsat (nfa)

Each binder is handled on its own, and one whose coefficient is invertible
disappears completely instead of turning into a modulo 1.

  $ cat > many.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (exists ((x Int) (w Int) (v Int))
  >   (and (= y (* 4 x)) (= z (+ (* 6 w) 1)) (= (+ y z) (+ v 2)))))
  > (check-sat)
  > EOF
  $ Chro --dpresimpl --stop-after presimpl many.smt2
  (exists (x w v) (and
                    (= (+ (- 2) (* (- 1) v) y z) 0)
                    (= (+ (- 1) (* (- 6) w) z) 0)
                    (= (+ (* (- 4) x) y) 0)))

Shapes the rewrite has to leave alone: a variable used more than once, one
under an exponent, and a binder below a negation (that is a universal
quantifier, not an existential one).

  $ cat > kept.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun y () Int)
  > (assert (exists ((x Int)) (and (= y (* 2 x)) (<= x 5))))
  > (check-sat)
  > EOF
  $ Chro --dpresimpl --stop-after presimpl kept.smt2
  (exists (x) (and
                (= (+ (* (- 2) x) y) 0)
                (<= (+ (- 5) x) 0)))

  $ cat > pow.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun y () Int)
  > (assert (exists ((x Int)) (= y (* 2 (pow2 x)))))
  > (check-sat)
  > EOF
  $ Chro --dpresimpl --stop-after presimpl pow.smt2
  (exists (x) (= (+ y (* (- 2) (exp 2 x))) 0))

A negated binder still gets the usual lowering of the whole `mod`, so the
answers stay the same as without the rewrite: y = 4 is even, y = 5 is not.

  $ cat > neg.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun y () Int)
  > (assert (not (exists ((x Int)) (= y (* 2 x)))))
  > (assert (= y 4))
  > (check-sat)
  > EOF
  $ Chro --info -no-over -bound -1 neg.smt2
  unsat (nfa)

  $ cat > neg2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun y () Int)
  > (assert (not (exists ((x Int)) (= y (* 2 x)))))
  > (assert (= y 5))
  > (check-sat)
  > EOF
  $ Chro --info -no-over -bound -1 neg2.smt2
  sat (nfa)

The congruence the rewrite produces has the quantified variable on the other
side, so its polynomial comes out negated: `2^y = 6 (mod 10)` is stated as
`-2^y = -6 (mod 10)`. The exponential machinery reads a congruence back as an
AST `mod`, which only ever yields a residue in `[0, m)`, so the residue has to
be reduced on the way out. Here x = 2, y = 4 and 2^4 = 16 = 6 + 10.

  $ cat > exp.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (assert (= (exp 2 x) y))
  > (assert (exists ((k Int)) (= (+ 6 (* 10 k)) (exp 2 y))))
  > (check-sat)
  > EOF
  $ Chro --dpresimpl --stop-after presimpl exp.smt2
  (and
    (= (+ (* (- 1) y) (exp 2 x)) 0)
    (exists (k) (= (+ 6 (* 10 k) (* (- 1) (exp 2 y))) 0)))
  $ Chro --info -bound -1 exp.smt2
  sat (nfa)

Lowering a `mod` leaves the quotient and the remainder as free variables of the
formula -- they are internal, no model is reported for them, so the formula is
implicitly their existential closure, and the quotient is eliminable in exactly
the same way. A nested `mod` is not a congruence (6 does not divide 109, so
`t mod 109 = 0 (mod 6)` says nothing about `t mod 6`) and has to be lowered;
what is left is `%r1 = x (mod 109)` together with `6 | %r1`, without either
quotient track.

  $ cat > nested.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= (mod (mod x 109) 6) 0))
  > (assert (<= 0 x))
  > (check-sat)
  > EOF
  $ Chro --dpresimpl --stop-after presimpl nested.smt2
  (and
    (divides 6 %r1)
    (divides 109 (+ (* (- 1) %r1) x))
    (<= (+ (- 108) %r1) 0)
    (<= (* (- 1) %r1) 0)
    (<= (* (- 1) x) 0))

The verdicts stay put: 218 = 2 * 109 is divisible by 109 so its residue is 0,
while 219 leaves 1, which 6 does not divide.

  $ cat > nested-sat.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= (mod (mod x 109) 6) 0))
  > (assert (<= 218 x))
  > (assert (<= x 218))
  > (check-sat)
  > EOF
  $ Chro --info -no-over -bound -1 nested-sat.smt2
  sat (nfa)

  $ cat > nested-unsat.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= (mod (mod x 109) 6) 0))
  > (assert (<= 219 x))
  > (assert (<= x 219))
  > (check-sat)
  > EOF
  $ Chro --info -no-over -bound -1 nested-unsat.smt2
  unsat (nfa)
