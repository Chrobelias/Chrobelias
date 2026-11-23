GaussQE: Gaussian quantifier elimination (--qelim)

--qelim runs SimplII.simplify_quantifiers, which eliminates existential
quantifiers over linear integer systems. For a bound variable x it picks an
equation a*x + tau = 0, multiplies every constraint by a, substitutes
a*x := -tau and turns the residue condition into a `divides` predicate; the
finite residue choices for slacks and unresolved variables become a DNF of
candidate branches.

A linear system with one bound variable and one free variable:

  $ cat > sat.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (assert (exists ((x0 Int))
  >   (and
  >     (= x0 55)
  >     (= (+ (* 4 x0) (* (- 1) x1)) 217)
  >   )))
  > (check-sat)
  > EOF

With --qelim the binder is projected away: x0 = 55 fixes x1 = 3, and the
`divides` branch is the residue alternative (4 | 217 - x1) that survives the
projection.

  $ Chro --qelim --dir sat.smt2
  sat (under int)

Without --qelim the existential binder is left in place:

  $ Chro --dir sat.smt2
  sat (under int)

The bound guard (-bqelim) skips elimination when the DNF would blow up: with
a bound of 0 no elimination fires, so the binder stays even with --qelim.

  $ Chro --qelim -bqelim 0 --dir sat.smt2
  sat (under int)

The same system is unsatisfiable when x1 is pinned to 4, since x0 = 55 forces
x1 = 3:

  $ cat > unsat.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (assert (exists ((x0 Int))
  >   (and
  >     (= x0 55)
  >     (= (+ (* 4 x0) (* (- 1) x1)) 217)
  >   )))
  > (assert (= x1 4))
  > (check-sat)
  > EOF

  $ Chro --qelim unsat.smt2
  unsat (nia)


  $ cat > sat.smt2 <<-EOF
  > (set-logic QF_LIA)
  > (declare-fun x0 () Int)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (declare-fun x3 () Int)
  > (declare-fun x4 () Int)
  > (declare-fun x5 () Int)
  > 
  > (assert (and
  >     (= x0 55)
  >     (= (+ (* 4 x0) (* (- 1) x1)) 217)
  >     (= (+ (* 2 x0) (* 3 x1) (* (- 5) x2) x3) 65)
  >     (= (+ x0 (* (- 2) x1) (* 4 x2) (* (- 3) x3) (* 2 x4)) 115)
  >     (= (+ (* 3 x0) x1 (* (- 1) x2) (* 2 x3) (* (- 4) x4) (* 5 x5)) 182)
  >     (= (+ (* (- 2) x0) (* 4 x1) (* 3 x2) (* (- 1) x3) (* 2 x4) (* (- 3) x5)) (- 86))
  > ))
  > 
  > (check-sat)
  > EOF

Without underprox is solver with just nfa
  $ Chro -bound -1 sat.smt2
  sat (nfa)

This time --free-elim removes all variables and Ir.simpl each branch
  $ Chro --free-elim -bound -1 sat.smt2
  sat (simpl)


A model for the eliminated variables: -bound -1 --free-elim

--free-elim runs GaussQE over the free variables. Every non-deterministic
branch also records the pivot equations it eliminated, so that once the NFA
solver picks a branch the eliminated variables are solved back from those
equations instead of staying at the model default 0.

Six equations in six unknowns, with the unique solution
(x0, x1, x2, x3, x4, x5) = (-2, 1, 3, 3, 3, -3):

  $ cat > lin.smt2 <<-EOF
  > (set-logic QF_LIA)
  > (declare-fun x0 () Int)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (declare-fun x3 () Int)
  > (declare-fun x4 () Int)
  > (declare-fun x5 () Int)
  > (assert (= (+ (* 5 x0) (* (- 8) x1) (* (- 8) x2) (* 4 x3) (* 8 x4) (* (- 7) x5)) 15))
  > (assert (= (+ (* 10 x0) (* (- 8) x1) (* 4 x2) (* 6 x3) (* 1 x4) (* 11 x5)) (- 28)))
  > (assert (= (+ (* 7 x0) (* 7 x1) (* 9 x2) (* (- 8) x3) (* 9 x4) (* 6 x5)) 5))
  > (assert (= (+ (* 11 x0) (* (- 8) x1) (* (- 1) x2) (* 9 x3) (* (- 3) x4) (* (- 2) x5)) (- 9)))
  > (assert (= (+ (* (- 9) x0) (* 9 x1) (* (- 5) x2) (* (- 10) x3) (* (- 9) x4) (* 10 x5)) (- 75)))
  > (assert (= (+ (* 8 x0) (* (- 7) x1) (* 11 x2) (* (- 6) x3) (* (- 2) x4) (* 11 x5)) (- 47)))
  > (check-sat)
  > EOF

Without the elimination the NFA solver has to intersect six binary tracks and
gives up:

  $ Chro -bound -1 lin.smt2
  unknown (too big nfa during the computations)

With --free-elim every branch of the elimination becomes `true`, so the same
system is decided at the `simpl` stage:

  $ Chro -bound -1 --free-elim lin.smt2
  sat (simpl)

Nothing is left for a model then: the `true` branch never reaches the solver,
so no pivot value is recovered for it. Restricting x0 to 0 contradicts
x0 = -2 instead:

  $ cat > lin-unsat.smt2 <<-EOF
  > (set-logic QF_LIA)
  > (declare-fun x0 () Int)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (declare-fun x3 () Int)
  > (declare-fun x4 () Int)
  > (declare-fun x5 () Int)
  > (assert (= (+ (* 5 x0) (* (- 8) x1) (* (- 8) x2) (* 4 x3) (* 8 x4) (* (- 7) x5)) 15))
  > (assert (= (+ (* 10 x0) (* (- 8) x1) (* 4 x2) (* 6 x3) (* 1 x4) (* 11 x5)) (- 28)))
  > (assert (= (+ (* 7 x0) (* 7 x1) (* 9 x2) (* (- 8) x3) (* 9 x4) (* 6 x5)) 5))
  > (assert (= (+ (* 11 x0) (* (- 8) x1) (* (- 1) x2) (* 9 x3) (* (- 3) x4) (* (- 2) x5)) (- 9)))
  > (assert (= (+ (* (- 9) x0) (* 9 x1) (* (- 5) x2) (* (- 10) x3) (* (- 9) x4) (* 10 x5)) (- 75)))
  > (assert (= (+ (* 8 x0) (* (- 7) x1) (* 11 x2) (* (- 6) x3) (* (- 2) x4) (* 11 x5)) (- 47)))
  > (assert (= x0 0))
  > (check-sat)
  > EOF

  $ Chro -bound -1 --free-elim lin-unsat.smt2
  unsat (over)

The exponential case leaves a variable in the formula, so a model is recovered.
y >= 0, x = 2^y, 2z + y = 7, 3t + x = 14, t + z = 4 have the unique solution
x = 8, y = 3, z = 2, t = 2: y = 3 forces z = 2 and t = 2, and 2^3 = 8.

  $ cat > exp.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (set-option :produce-models true)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (declare-fun t () Int)
  > (assert (>= y 0))
  > (assert (= x (** 2 y)))
  > (assert (= (+ (* 2 z) y) 7))
  > (assert (= (+ (* 3 t) x) 14))
  > (assert (= (+ t z) 4))
  > (check-sat)
  > (get-model)
  > EOF

  $ Chro -bound -1 exp.smt2
  sat (nfa)
  (
     (define-fun t () Int
      2)
     (define-fun x () Int
      8)
     (define-fun y () Int
      3)
     (define-fun z () Int
      2)
  )

--free-elim eliminates z and t. z does not occur in what is left of the
formula, so its value comes from its pivot 2z + y = 7 with y read from the
model: z = (7 - 3)/2 = 2.

  $ Chro -bound -1 --free-elim exp.smt2
  sat (nfa)
  (
     (define-fun t () Int
      2)
     (define-fun x () Int
      8)
     (define-fun y () Int
      3)
     (define-fun z () Int
      2)
  )

With y = 4 there is no solution: 2^4 = 16 makes t = (14 - 16)/3 non-integral.

  $ cat > exp-unsat.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (set-option :produce-models true)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (declare-fun t () Int)
  > (assert (>= y 0))
  > (assert (= x (** 2 y)))
  > (assert (= (+ (* 2 z) y) 7))
  > (assert (= (+ (* 3 t) x) 14))
  > (assert (= (+ t z) 4))
  > (assert (= y 4))
  > (check-sat)
  > EOF

  $ Chro -bound -1 --free-elim exp-unsat.smt2
  unsat (over)


The same two systems under a binder: --qelim

--qelim is the same GaussQE applied to the atoms of an `exists` instead of to
the free variables. The same six equations, bound:

  $ cat > qlin.smt2 <<-EOF
  > (set-logic QF_LIA)
  > (assert (exists ((x0 Int) (x1 Int) (x2 Int) (x3 Int) (x4 Int) (x5 Int))
  >   (and
  >     (= (+ (* 5 x0) (* (- 8) x1) (* (- 8) x2) (* 4 x3) (* 8 x4) (* (- 7) x5)) 15)
  >     (= (+ (* 10 x0) (* (- 8) x1) (* 4 x2) (* 6 x3) (* 1 x4) (* 11 x5)) (- 28))
  >     (= (+ (* 7 x0) (* 7 x1) (* 9 x2) (* (- 8) x3) (* 9 x4) (* 6 x5)) 5)
  >     (= (+ (* 11 x0) (* (- 8) x1) (* (- 1) x2) (* 9 x3) (* (- 3) x4) (* (- 2) x5)) (- 9))
  >     (= (+ (* (- 9) x0) (* 9 x1) (* (- 5) x2) (* (- 10) x3) (* (- 9) x4) (* 10 x5)) (- 75))
  >     (= (+ (* 8 x0) (* (- 7) x1) (* 11 x2) (* (- 6) x3) (* (- 2) x4) (* 11 x5)) (- 47))
  >   )))
  > (check-sat)
  > EOF

With -bound -1 the under-approximation is off; of the two runs below only the
second one eliminates the binder.

  $ Chro --qelim qlin.smt2
  sat (under int)

  $ Chro -bound -1 qlin.smt2
  sat (nfa)

  $ Chro -bound -1 --qelim qlin.smt2
  sat (simpl)

x0 = 0 contradicts the solution again:

  $ cat > qlin-unsat.smt2 <<-EOF
  > (set-logic QF_LIA)
  > (assert (exists ((x0 Int) (x1 Int) (x2 Int) (x3 Int) (x4 Int) (x5 Int))
  >   (and
  >     (= (+ (* 5 x0) (* (- 8) x1) (* (- 8) x2) (* 4 x3) (* 8 x4) (* (- 7) x5)) 15)
  >     (= (+ (* 10 x0) (* (- 8) x1) (* 4 x2) (* 6 x3) (* 1 x4) (* 11 x5)) (- 28))
  >     (= (+ (* 7 x0) (* 7 x1) (* 9 x2) (* (- 8) x3) (* 9 x4) (* 6 x5)) 5)
  >     (= (+ (* 11 x0) (* (- 8) x1) (* (- 1) x2) (* 9 x3) (* (- 3) x4) (* (- 2) x5)) (- 9))
  >     (= (+ (* (- 9) x0) (* 9 x1) (* (- 5) x2) (* (- 10) x3) (* (- 9) x4) (* 10 x5)) (- 75))
  >     (= (+ (* 8 x0) (* (- 7) x1) (* 11 x2) (* (- 6) x3) (* (- 2) x4) (* 11 x5)) (- 47))
  >     (= x0 0)
  >   )))
  > (check-sat)
  > EOF

  $ Chro --qelim qlin-unsat.smt2
  unsat (nia)

The exponential system with z and t bound; z and t are bound and so are not
part of the model, x = 8 and y = 3 are:

  $ cat > qexp.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (set-option :produce-models true)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (assert (>= y 0))
  > (assert (= x (** 2 y)))
  > (assert (exists ((z Int) (t Int))
  >   (and (= (+ (* 2 z) y) 7)
  >        (= (+ (* 3 t) x) 14)
  >        (= (+ t z) 4))))
  > (check-sat)
  > (get-model)
  > EOF

  $ Chro --qelim qexp.smt2
  sat (under int)
  (
     (define-fun x () Int
      8)
     (define-fun y () Int
      3)
  )

  $ Chro -bound -1 --qelim qexp.smt2
  sat (nfa)
  (
     (define-fun x () Int
      8)
     (define-fun y () Int
      3)
  )

With y = 4 there is no solution:

  $ cat > qexp-unsat.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (set-option :produce-models true)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (assert (>= y 0))
  > (assert (= x (** 2 y)))
  > (assert (exists ((z Int) (t Int))
  >   (and (= (+ (* 2 z) y) 7)
  >        (= (+ (* 3 t) x) 14)
  >        (= (+ t z) 4))))
  > (assert (= y 4))
  > (check-sat)
  > EOF

  $ Chro --qelim qexp-unsat.smt2
  unsat (nia)
