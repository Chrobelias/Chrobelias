
$ export CHRO_DEBUG=1
-amin 0 -amax 0
  $ timeout 2 Chro -no-over-approx -bound -1 -dsimpl -flat 0  -lsb issue92.smt2  | sed 's/[[:space:]]*$//'
  (assert (exists (z)
          (and
            (exists (y)
            (and
              (= (+ (* (- 1) y) pow2(eee1) )  0)
              (<= y  1050000)
              )
            (= (+ eee1 (* (- 1) u0) (* (- 1) z) )  0)
            (<= (* (- 1) u0)  0)
            (<= (* (- 1) z)  -10)
            (<= (* (- 1) pow2(u0))  -1000)
            )
  )
  (assert (<= (+ eee1 (* (- 1) pow2(eee1)) )  -1) )
  (assert (<= (+ (* (- 1) eee1) pow2(u0) )  0) )
  (assert (<= (+ u0 (* (- 1) pow2(u0)) )  -1) )
  
  (assert (<= (+ (* (- 1) pow2(eee1)) pow2(u0) )  0) )
  (assert (<= (+ eee1 (* (- 1) pow2(u0)) )  0) )
  (assert (<= (+ (* (- 1) eee1) u0 )  0) )
  
  (assert (= (* (- 1) z)  -10) )
  (assert (= (* (- 1) y)  -1048576) )
  (assert (<= y  1050000) )
  (assert (<= (* (- 1) z)  -10) )
  
  sat ; under II
