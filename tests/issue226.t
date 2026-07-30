`ite` support (#226).

The example from the issue. On `main` this answers `unknown (nfa)`, because the
frontend had no way to translate `ite`; the DPLL driver lowers it to a
disjunction over the boolean skeleton instead.

  $ cat > ite.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun num1 () String)
  > (declare-fun num2 () String)
  > (assert (> (ite (> (str.len num1) (str.len num2)) (str.len num1) (str.len num2)) 10))
  > (check-sat)
  > EOF

  $ Chro --info ite.smt2
  sat (under int)

The same shape, but unsatisfiable: both branches are bounded below 10.

  $ cat > ite-unsat.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun num1 () String)
  > (declare-fun num2 () String)
  > (assert (<= (str.len num1) 3))
  > (assert (<= (str.len num2) 3))
  > (assert (> (ite (> (str.len num1) (str.len num2)) (str.len num1) (str.len num2)) 10))
  > (check-sat)
  > EOF

  $ Chro --info ite-unsat.smt2
  unsat (lengths)

`ite` over plain integers, picking each branch in turn.

  $ cat > ite-int.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun b () Int)
  > (declare-fun x () Int)
  > (assert (= x (ite (= b 1) 10 20)))
  > (assert (= x 10))
  > (check-sat)
  > EOF

  $ Chro --info ite-int.smt2
  sat (under int)

  $ cat > ite-int-other.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun b () Int)
  > (declare-fun x () Int)
  > (assert (= x (ite (= b 1) 10 20)))
  > (assert (= x 20))
  > (check-sat)
  > EOF

  $ Chro --info ite-int-other.smt2
  sat (under int)

Neither branch can produce 30, so this is unsat.

  $ cat > ite-int-unsat.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun b () Int)
  > (declare-fun x () Int)
  > (assert (= x (ite (= b 1) 10 20)))
  > (assert (= x 30))
  > (check-sat)
  > EOF

  $ Chro --info ite-int-unsat.smt2
  unsat (nia)
