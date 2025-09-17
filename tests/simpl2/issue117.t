
  $ Chro -no-over-approx -bound 0 -pre-simpl -dpresimpl -dsimpl issue117.smt2 -stop-after simpl | sed 's/[[:space:]]*$//'
  (and
    (= (exp 2 x) y)
    (= (exp 2 x) (* 2 z))
    (= (exp 2 x) (* 8 u))
    (= (exp 2 x) (* 32 v))
    (<= (+ (* (- 1) u) (* (- 1) v) (* (- 1) x) (* (- 1) y) (* (- 1) z)) (- 100)))
  (assert (exists (z y v u)
          (and
            (<= (+ (* (- 1) u) (* (- 1) v) (* (- 1) x) (* (- 1) y) (* (- 1) z)
                )
             -100)
            (= (+ (* (- 8) u) pow2(x) )  0)
            (= (+ (* (- 32) v) pow2(x) )  0)
            (= (+ (* (- 1) y) pow2(x) )  0)
            (= (+ (* (- 2) z) pow2(x) )  0)
            )
  )

