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
