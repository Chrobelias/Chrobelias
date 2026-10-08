  $ cat > chc-or.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun i1 () Int)
  > (declare-fun it21 () Int)
  > (declare-fun it22 () Int)
  > (declare-fun it23 () Int)
  > (declare-fun it27 () Int)
  > (declare-fun it28 () Int)
  > (declare-fun it29 () Int)
  > (declare-fun it30 () Int)
  > (declare-fun it17 () Int)
  > (assert (= (+ it23 (- 1)) 0))
  > (assert (and (>= (+ it21 (- 3)) 0)
  >      (>= (+ it27 (- 1)) 0)
  >      (>= (+ (* it21 (- 1)) 3) 0)
  >      (>= it22 0)
  >      (>= it23 0)
  >      (>= (+ (* it27 (- 1)) (* it22 (- 1)) 6) 0)))
  > (assert (= (+ (* (+ 0 it23) (exp 2 it27) (+ 0 (- 1))) (+ 0 it30)) (+ 0 0)))
  > (assert (let ((a!1 (<= (+ (+ (* it17 3) (* it30 (- 1))) (- 2)) 0))
  >       (a!2 (<= (+ (+ (* it17 (- 3)) it30) (- 2)) 0))
  >       (a!3 (> (+ (+ (* it17 3) (* it30 (- 1))) 1) 0))
  >       (a!5 (> (+ (+ (* it17 (- 3)) it30) 1) 0)))
  > (let ((a!4 (or (<= (+ (* it30 (- 1)) 1) 0) a!3)))
  >   (and (= (+ it28 (- 3)) 0)
  >        (<= (* it29 (- 1)) 0)
  >        (> (+ it29 (- 5)) 0)
  >        (<= (* it30 (- 1)) 0)
  >        a!1
  >        (= (+ (* it17 (- 3)) it30) 0)
  >        a!2
  >        a!4
  >        (or (<= (+ it30 1) 0) a!5)))))
  > (check-sat)
  > EOF

  $ Chro -no-parallel chc-or.smt2 | cut -d' ' -f1
  unsat

Disjunctions over powers whose exponents may be negative: the exponent split
rewrites the formula, and DPLL(T) on the split form used to enumerate
candidates for minutes.

  $ cat > split-or.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun u () Int)
  > (declare-fun y () Int)
  > (declare-fun v () Int)
  > (assert (= v (exp 2 u)))
  > (assert (or (or (and (not (= (mod x 5) 0)) (<= (+ (* 3 x) (* 2 v)) 9) (= v (exp 2 x))) (= y (exp 2 x))) (or (or (= (mod y 7) 5) (not (= v (exp 2 x))) (<= (+ (* (- 1) (exp 2 u)) (* (- 2) y)) 15)) (or (<= (+ (* (- 2) x) (* 2 v)) 26) (<= (+ (* 3 u) (* (- 1) (exp 2 x))) (- 3))) (or (= (exp 2 u) (+ u (- 1))) (<= (+ (* 3 v) (* 0 y)) 37))) (and (= y (exp 2 u)) (<= (+ (* (- 2) x) (* (- 2) u)) 31))))
  > (check-sat)
  > EOF

  $ timeout 10 Chro -no-parallel split-or.smt2 | cut -d' ' -f1
  sat

The dump and stop flags apply to the whole formula, not to a DPLL(T) candidate.

  $ cat > stop.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (assert (or (= x 1) (= x 7)))
  > (assert (or (= y 2) (= y 9)))
  > (assert (= (+ x y) 16))
  > (check-sat)
  > EOF

  $ Chro --stop-after presimpl --dpresimpl -bound -1 stop.smt2
  (and
    (= (+ (- 16) x y) 0)
    (or
      (= (+ (- 2) y) 0)
      (= (+ (- 9) y) 0))
    (or
      (= (+ (- 1) x) 0)
      (= (+ (- 7) x) 0)))

A disjunct whose automaton outgrows the size limit leaves the next one to be
checked.

  $ cat > big-or.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (or (and (= (mod x 97) 5) (= (mod y 89) 7) (= (mod z 83) 3) (= (+ x y z) 1000000))
  >             (and (= (mod x 3) 1) (>= x 0))))
  > (check-sat)
  > EOF

  $ CHRO_NFA_SIZE=300 Chro -bound -1 -no-model -no-dpll big-or.smt2
  sat (nfa)
