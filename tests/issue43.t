DPLL(T) driver (#43).

A boolean skeleton is handed to Z3, and each satisfying assignment is checked
against the theory; refuted assignments come back as blocking clauses instead
of the whole disjunction being expanded eagerly.

  $ cat > dpll.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun num1 () String)
  > (declare-fun num2 () String)
  > (assert (> (ite (> (str.len num1) (str.len num2)) (str.len num1) (str.len num2)) 10))
  > (check-sat)
  > EOF

The `ite` becomes a disjunction, and every atom of it becomes a propositional
literal `(P $n)` of the skeleton. The two branch guards are negations of each
other, and the skeleton shares one literal for them rather than allocating a
fifth: the second occurrence comes out as `(not (P $2))`.

  $ CHRO_DEBUG=DPLL Chro dpll.smt2 2>&1 | grep -A9 'Into Z3 added'
    Into Z3 added: (and
                   (P $0)
                   (or
                     (and
                       (P $1)
                       (P $2))
                     (and
                       (P $3)
                       (not (P $2)))))
  [+DPLL]

A disjunction whose branches are all refuted by the theory.

  $ cat > dpll-unsat.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (or (= x 1) (= x 2)))
  > (assert (>= x 3))
  > (check-sat)
  > EOF

  $ Chro --info dpll-unsat.smt2
  unsat (nia)

Only the second branch survives the theory check, so the problem is sat.

  $ cat > dpll-sat.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (or (= x 1) (= x 5)))
  > (assert (>= x 3))
  > (check-sat)
  > EOF

  $ Chro --info dpll-sat.smt2
  sat (under int)
