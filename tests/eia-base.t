Integer formulas whose exponentials share a base other than 2 must be decided
by automata in that base. The binary integer automata used to read
`(** 10 L)` as `2 ** L`, so `10 ** L <= 999` held up to L = 9.

  $ cat > base10.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-fun L () Int)
  > (assert (>= L 3))
  > (assert (<= (** 10 L) 999))
  > (check-sat)
  > EOF
  $ Chro base10.smt2
  unsat (nfa)
  $ Chro -lsb base10.smt2
  unsat (nfa)

  $ cat > base3.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-fun L () Int)
  > (assert (>= L 3))
  > (assert (<= (exp 3 L) 26))
  > (check-sat)
  > EOF
  $ Chro base3.smt2
  unsat (nfa)
  $ Chro -lsb base3.smt2
  unsat (nfa)

The opposite direction: no power of 2 is a multiple of 5, but 10 ** L is.

  $ cat > div5.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-fun L () Int)
  > (declare-fun y () Int)
  > (assert (>= L 60))
  > (assert (= (** 10 L) (* 5 y)))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro --check-model div5.smt2
  sat (nfa)
  (
     (define-fun L () Int
      60)
     (define-fun y () Int
      200000000000000000000000000000000000000000000000000000000000)
  )
  $ Chro -lsb div5.smt2 | head -1
  sat (nfa)

Base 2 still goes to the binary automata.

  $ cat > base2.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-fun L () Int)
  > (assert (>= L 3))
  > (assert (<= (** 2 L) 7))
  > (check-sat)
  > EOF
  $ Chro base2.smt2
  unsat (nfa)
