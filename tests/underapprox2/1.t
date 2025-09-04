  $ cat issue92.smt2
  (set-logic ALL)
  (declare-fun x () Int)
  (declare-fun y () Int)
  (declare-fun z () Int)
  
  (assert (>= z 5))
  (assert (>= x 37))
  (assert (= (* x (exp 2 z)) y))
  (assert (<= y 1184))
  (check-sat) ; z=5, x=2^5+5, y = (32+5)*32 = 1184

$ export CHRO_DEBUG=1
  $ timeout 120 /usr/bin/time -f "%U" Chro -no-over-approx -bound 0 -dsimpl -under2 -amin 5 -amax 5 issue92.smt2  | sed 's/[[:space:]]*$//'
  69.14
  (assert (exists (y)
          (and
            (<= (* (- 1) pow2(u1))  -32)
            (<= (* (- 1) z)  -5)
            (<= y  1184)
            (= (+ eee2 (* (- 1) u1) (* (- 1) z) )  0)
            (= (+ (* (- 1) y) pow2(eee2) (* 5 pow2(z)) )  0)
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
