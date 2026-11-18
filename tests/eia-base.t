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

Models in base 3 are read as base-3 digits, and negative values as the 2's
complement (digit d becomes 2 - d). Read as decimal, y would be 11 instead of
4 and -89 instead of -5. `-bound -1 -no-over` keeps these off the earlier
stages, so the automata decide them.

  $ cat > base3-odd.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (assert (>= x 0))
  > (assert (= (** 3 x) (+ (* 2 y) 1)))
  > (assert (>= y 4))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro --check-model -bound -1 -no-over base3-odd.smt2
  sat (nfa)
  (
     (define-fun x () Int
      2)
     (define-fun y () Int
      4)
  )

  $ cat > base3-neg.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (assert (>= x 2))
  > (assert (<= (+ (** 3 x) (* 2 y)) 0))
  > (assert (>= (+ (** 3 x) (* 2 y)) (- 1)))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro --check-model -bound -1 -no-over base3-neg.smt2
  sat (nfa)
  (
     (define-fun x () Int
      2)
     (define-fun y () Int
      -5)
  )

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
