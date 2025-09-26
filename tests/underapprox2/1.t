
  $ timeout 2 Chro -no-mini-in-semenov -no-over-approx -bound -1 -dsimpl -flat 0 -amin 0 -amax 0 -lsb issue92.smt2  | sed 's/[[:space:]]*$//'
  (assert (exists (z y)
          (and
            (<= (* (- 1) pow2(u1))  -1000)
            (<= (* (- 1) z)  -10)
            (<= y  1050000)
            (= (+ eee2 (* (- 1) u1) (* (- 1) z) )  0)
            (= (+ (* (- 1) y) pow2(eee2) )  0)
            )
  )
  (assert (<= (+ (* (- 1) eee2) pow2(u1) )  0) )
  (assert (<= (+ eee2 (* (- 1) pow2(eee2)) )  0) )
  (assert (<= (+ u1 (* (- 1) pow2(u1)) )  0) )
  
  (assert (<= (+ (* (- 1) eee2) u1 )  0) )
  (assert (<= (+ eee2 (* (- 1) pow2(u1)) )  0) )
  (assert (<= (+ (* (- 1) pow2(eee2)) pow2(u1) )  0) )
  
  sat (under II)
