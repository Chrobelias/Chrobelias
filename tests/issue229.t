Unsat cores from the basic simplifications (#229).

The example from the issue. The verdict was already `unsat` before, but the
simplifier now also reports *which* equations produced the contradiction: the
substitutions taken from `env` plus the constraint that is false after them.
The core feeds the blocking clauses of the DPLL driver.

  $ cat > core.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun w () Int)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (= w 7))
  > (assert (= x (+ y 1)))
  > (assert (= z (+ x 1)))
  > (assert (= w (+ z 1)))
  > (assert (< w 3))
  > (assert (= y 7))
  > (check-sat)
  > EOF

  $ Chro --info core.smt2
  unsat (presimpl int)

  $ CHRO_DEBUG=simpl Chro core.smt2 2>&1 | grep -A6 'unsat core'
    unsat core: (and
                (<= (+ (- 2) w) 0)
                (= (+ (- 7) w) 0))
  
  unsat (presimpl int)


A satisfiable problem produces no core.

  $ cat > no-core.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun w () Int)
  > (declare-fun y () Int)
  > (assert (= w 7))
  > (assert (= y 7))
  > (check-sat)
  > EOF

  $ CHRO_DEBUG=simpl Chro no-core.smt2 2>&1 | grep -c 'unsat core'
  0
  [1]
