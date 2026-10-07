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
