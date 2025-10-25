
  $ timeout 2 Chro -no-over-approx -bound -1 -dsimpl -flat 0 -amin 0 -amax 0 -lsb issue92.smt2  | sed 's/[[:space:]]*$//'
  (assert (exists (z)
          (and
            (exists (y)
            (and
              (= (+ (* (- 1) y) pow2(eee2) )  0)
              (<= y  1050000)
              )
  
            (= (+ eee2 (* (- 1) u1) (* (- 1) z) )  0)
            (<= (* (- 1) z)  -10)
            (<= (* (- 1) pow2(u1))  -1000)
            )
  )
  (assert (<= (+ eee2 (* (- 1) pow2(eee2)) )  -1) )
  (assert (<= (+ (* (- 1) eee2) pow2(u1) )  0) )
  (assert (<= (+ u1 (* (- 1) pow2(u1)) )  -1) )
  
  (assert (<= (+ (* (- 1) pow2(eee2)) pow2(u1) )  0) )
  (assert (<= (+ eee2 (* (- 1) pow2(u1)) )  0) )
  (assert (<= (+ (* (- 1) eee2) u1 )  0) )
  
  (assert (= (* (- 1) z)  -10) )
  (assert (= (* (- 1) y)  -1048576) )
  (assert (<= y  1050000) )
  (assert (<= (* (- 1) z)  -10) )
  
  sat (under II)
