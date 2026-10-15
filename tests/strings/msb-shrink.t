`Nfa.shrink` used to widen a track of a label to "any" when the labels into
the same state carried all ten digits there. It compared those labels with
one already widened on other tracks, so it merged labels that did not cover
the result, and it let the padding letter in as well. On the MSB inequality
automaton for `to_int x <= 30 + L` this accepted `x = 36`, `L = 0`.

  $ cat > neg.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun L () Int)
  > (assert (str.in_re x (re.+ (str.to_re "36"))))
  > (assert (<= L 0))
  > (assert (<= (str.to_int x) (+ 30 L)))
  > (check-sat)
  > EOF
  $ Chro neg.smt2
  unsat (nfa)

The same automaton with `L = |x|`: unsat for 30 and 31, sat from 32 on.

  $ for c in 30 31 32; do
  >   cat > len$c.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (assert (str.in_re x (re.+ (str.to_re "36"))))
  > (assert (>= (str.to_int x) 0))
  > (assert (<= (str.to_int x) (+ $c (* 2 (str.len x)))))
  > (check-sat)
  > EOF
  >   Chro len$c.smt2
  > done
  unsat (nfa)
  unsat (nfa)
  sat (nfa)
  $ Chro --check-model len32.smt2
  sat (nfa)
