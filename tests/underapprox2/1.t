
  $ timeout 2 Chro -no-mini-in-semenov -no-over-approx -bound -1 -dsimpl -under2 -amin 1 -amax 1 issue92.smt2  | sed 's/[[:space:]]*$//'
  (assert (exists (y)
          (and
            (<= (* (- 1) pow2(u1))  -999)
            (<= (* (- 1) z)  -10)
            (<= y  1050000)
            (= (+ eee2 (* (- 1) u1) (* (- 1) z) )  0)
            (= (+ (* (- 1) y) pow2(eee2) pow2(z) )  0)
            )
  )
  timeout
