  $ cat > test.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (<= (* x (- 0 5)) 13))
  > (assert (= (+ z y) 52))
  > (assert (> (+ (* x 5) (* (pow2 y) 8) (* z 7) ) 13))
  > (check-sat)
  > EOF
  $ Chro -dsimpl -stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  (assert (exists (z x)
          (and
            (<= (+ (* (- 5) x) (* (- 7) z) (* (- 8) pow2(y)) )  -14)
            (<= (* (- 5) x)  13)
            (= (+ y z )  52)
            )
  )
We can't do anything below, because y exists in two polarities
  $ cat > test.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (<= (* 5 y) 42))
  > (assert (<= (+ x (* (- 3) y) z) 0))
  > (assert (> (+ x (* 3 y)) 23))
  > (check-sat)
  > EOF
  $ Chro -dsimpl -stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  (assert (exists (x y)
          (and
            (<= (+ (* (- 1) x) (* (- 3) y) )  -24)
            (<= (* 5 y)  42)
            (exists (z) (<= (+ x (* (- 3) y) z )  0) )
            )
  )

Habermehl demo
  $ cat > Habermehl.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (<= (* 5 y) 42))
  > (assert (= (+ (pow2 z) x) 52))
  > (assert (<= (+ x (- 0 (* 3 y)) z ) 0))
  > (check-sat)
  > EOF
  $ Chro -dsimpl -stop-after simpl Habermehl.smt2 | sed 's/[[:space:]]*$//'
  (assert (exists (x) (and
                        (<= (+ x z )  24)
                        (= (+ x pow2(z) )  52)
                        )
  )

