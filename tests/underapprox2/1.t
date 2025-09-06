
  $ timeout 120 Chro -no-mini-in-semenov -no-over-approx -bound 0 -dsimpl -under2 -amin 1 -amax 1 issue92.smt2  | sed 's/[[:space:]]*$//'
  (assert (exists (y)
          (and
            (<= (* (- 1) pow2(u1))  -999)
            (<= (* (- 1) z)  -10)
            (<= y  1050000)
            (= (+ eee2 (* (- 1) u1) (* (- 1) z) )  0)
            (= (+ (* (- 1) y) pow2(eee2) pow2(z) )  0)
            )
  )
  (assert (<= (+ (* (- 1) eee2) pow2(u1) )  0) )
  (assert (<= (+ eee2 (* (- 1) pow2(eee2)) )  0) )
  (assert (<= (+ (* (- 1) u1) pow2(z) )  0) )
  (assert (<= (+ u1 (* (- 1) pow2(u1)) )  0) )
  (assert (<= (+ z (* (- 1) pow2(z)) )  0) )
  
  (assert (<= (+ (* (- 1) eee2) pow2(u1) )  0) )
  (assert (<= (+ eee2 (* (- 1) pow2(eee2)) )  0) )
  (assert (<= (+ (* (- 1) u1) z )  0) )
  (assert (<= (+ u1 (* (- 1) pow2(z)) )  0) )
  (assert (<= (+ (* (- 1) pow2(u1)) pow2(z) )  0) )
  
  (assert (<= (+ (* (- 1) eee2) pow2(z) )  0) )
  (assert (<= (+ eee2 (* (- 1) pow2(eee2)) )  0) )
  (assert (<= (+ u1 (* (- 1) pow2(u1)) )  0) )
  (assert (<= (+ (* (- 1) z) pow2(u1) )  0) )
  (assert (<= (+ z (* (- 1) pow2(z)) )  0) )
  
  (assert (<= (+ (* (- 1) eee2) pow2(z) )  0) )
  (assert (<= (+ eee2 (* (- 1) pow2(eee2)) )  0) )
  (assert (<= (+ u1 (* (- 1) z) )  0) )
  (assert (<= (+ z (* (- 1) pow2(u1)) )  0) )
  (assert (<= (+ pow2(u1) (* (- 1) pow2(z)) )  0) )
  
  (assert (<= (+ (* (- 1) eee2) u1 )  0) )
  (assert (<= (+ eee2 (* (- 1) pow2(u1)) )  0) )
  (assert (<= (+ (* (- 1) u1) pow2(z) )  0) )
  (assert (<= (+ z (* (- 1) pow2(z)) )  0) )
  (assert (<= (+ (* (- 1) pow2(eee2)) pow2(u1) )  0) )
  
  (assert (<= (+ (* (- 1) eee2) pow2(z) )  0) )
  (assert (<= (+ eee2 (* (- 1) pow2(u1)) )  0) )
  (assert (<= (+ (* (- 1) u1) z )  0) )
  (assert (<= (+ u1 (* (- 1) pow2(z)) )  0) )
  (assert (<= (+ (* (- 1) pow2(eee2)) pow2(u1) )  0) )
  
  (assert (<= (+ (* (- 1) eee2) u1 )  0) )
  (assert (<= (+ eee2 (* (- 1) pow2(z)) )  0) )
  (assert (<= (+ (* (- 1) u1) z )  0) )
  (assert (<= (+ (* (- 1) pow2(eee2)) pow2(u1) )  0) )
  (assert (<= (+ (* (- 1) pow2(u1)) pow2(z) )  0) )
  
  sat (under II)
