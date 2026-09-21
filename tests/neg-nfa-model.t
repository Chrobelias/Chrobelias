The congruence plus the range pin the model to a single value, so the decode
is the only thing left for these to get wrong. `-bound -1` and `-no-over`
send them to the `nfa` stage, which is where the decode runs; `--check-model`
re-evaluates the printed model against the input.

  $ cat > m7.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-const x Int)
  > (assert (= (mod x 7) 3))
  > (assert (<= x (- 1)))
  > (assert (<= (- 5) x))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro -bound -1 -no-over --check-model m7.smt2
  sat (nfa)
  (
     (define-fun x () Int
      -4)
  )

Away from zero the stripped digits are worth more, and the wrong answer used
to land outside the asserted range as well.

  $ cat > m7far.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-const x Int)
  > (assert (= (mod x 7) 3))
  > (assert (<= x (- 8)))
  > (assert (<= (- 14) x))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro -bound -1 -no-over --check-model m7far.smt2
  sat (nfa)
  (
     (define-fun x () Int
      -11)
  )

A power-of-two modulus makes the whole magnitude zero digits.

  $ cat > m16.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-const x Int)
  > (assert (= (mod x 16) 8))
  > (assert (<= x (- 1)))
  > (assert (<= (- 16) x))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro -bound -1 -no-over --check-model m16.smt2
  sat (nfa)
  (
     (define-fun x () Int
      -8)
  )

Tracks are decoded one by one, so a word can be right on one variable and
wrong on the next: here `x` reads back as -4 either way, and only `y` used
to collapse to -1.

  $ cat > two.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-const x Int)
  > (declare-const y Int)
  > (assert (= (mod x 7) 3))
  > (assert (= (mod y 5) 2))
  > (assert (<= x (- 1)))
  > (assert (<= (- 5) x))
  > (assert (<= y (- 6)))
  > (assert (<= (- 12) y))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro -bound -1 -no-over --check-model two.smt2
  sat (nfa)
  (
     (define-fun x () Int
      -4)
     (define-fun y () Int
      -8)
  )

Only the model was ever wrong: the same range one short of a solution is
still unsat.

  $ cat > unsat.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-const x Int)
  > (assert (= (mod x 7) 3))
  > (assert (<= x (- 1)))
  > (assert (<= (- 3) x))
  > (check-sat)
  > EOF
  $ Chro -bound -1 -no-over -no-model unsat.smt2
  unsat (nfa)

A non-negative model keeps reading back the same: there the leading digits
the strip removed were not worth anything.

  $ cat > pos.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-const x Int)
  > (assert (= (mod x 7) 3))
  > (assert (<= 0 x))
  > (assert (<= x 10))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro -bound -1 -no-over --check-model pos.smt2
  sat (nfa)
  (
     (define-fun x () Int
      3)
  )
