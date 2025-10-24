  $ cat > testS1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (<= (* x (- 0 5)) 13))
  > (assert (= (+ z y) 52))
  > (assert (> (+ (* x 5) (* (pow2 y) 8) (* z 7) ) 13))
  > (check-sat)
  > EOF
  $ timeout 2 Chro -no-over-approx -bound 0 -dsimpl -stop-after simpl testS1.smt2 | sed 's/[[:space:]]*$//'
  sat (under I)
We can't do anything below, because y exists in two polarities
  $ cat > testS2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (<= (* 5 y) 42))
  > (assert (<= (+ x (* (- 3) y) z) 0))
  > (assert (> (+ x (* 3 y)) 23))
  > (check-sat)
  > EOF
  $ timeout 2 Chro -bound 0 -dsimpl -stop-after simpl testS2.smt2 | sed 's/[[:space:]]*$//'
  sat (under I)

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
  $ Chro -bound 0 -dsimpl -stop-after simpl Habermehl.smt2 | sed 's/[[:space:]]*$//'
  (assert (exists (y)
          (and
            (exists (x)
            (and
              (= (+ x pow2(z) )  52)
              (<= (+ x (* (- 3) y) z )  0)
              )
            (<= y  8)
            )
  )

