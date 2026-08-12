Regression test: [v <> c] is lowered into a complement automaton taken over the
alphabet collected from the input.  When the same variable is also read
numerically ([str.to_int]) that alphabet has to contain every decimal digit,
otherwise the complement drops satisfying assignments and the solver answers
[unsat] on a satisfiable formula.

  $ cat > 1.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun s () String)
  > (assert (not (= s "")))
  > (assert (= (str.to_int s) 2))
  > (check-sat)
  > EOF

  $ Chro --no-parallel ./1.smt2
  sat (under int)

The same, with a non-empty constant on the right-hand side.

  $ cat > 2.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun s () String)
  > (assert (not (= s "-")))
  > (assert (= (str.to_int s) 7))
  > (check-sat)
  > EOF

  $ Chro --no-parallel ./2.smt2
  sat (presimpl int)

The py-conbyte idiom that first exposed this: every extracted character carries
a [y = ""] out-of-range branch, so the negated branch produced the broken
complement for each of them.

  $ cat > 3.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun s () String)
  > (assert (not (= (str.to_int (str.at s 0)) 0)))
  > (assert (not (= (str.to_int (str.at s 0)) (- 1))))
  > (assert (not (= (str.to_int (str.at s 1)) 0)))
  > (assert (not (= (str.to_int (str.at s 1)) (- 1))))
  > (assert (not (= (str.len s) 0)))
  > (check-sat)
  > EOF

  $ Chro --no-parallel ./3.smt2
  sat (under int)

The complement is also taken for negated regex memberships, so those need the
digit-complete alphabet as well: here the only constant is "-", and before the
fix the complement of [str.to_re "-"] contained no digit strings at all.

  $ cat > 4.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun s () String)
  > (assert (not (str.in_re s (str.to_re "-"))))
  > (assert (= (str.to_int s) 7))
  > (check-sat)
  > EOF

  $ Chro --no-parallel ./4.smt2
  sat (presimpl int)

Guard in the other direction: widening the alphabet must not invent models.
[str.to_int] never returns a negative number other than -1, so this stays
unsat.

  $ cat > 5.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun s () String)
  > (assert (not (= s "")))
  > (assert (= (str.to_int s) (- 5)))
  > (check-sat)
  > EOF

  $ Chro --no-parallel ./5.smt2
  unsat (presimpl int)
