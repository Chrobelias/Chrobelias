  $ cp koat36mini.smt2 input.smt2

$ export CHRO_DEBUG=1
  $ timeout 2 Chro -dsimpl -pre-simpl input.smt2 -bound 0 -under2 -amin 0 -amax 11 | sed 's/[[:space:]]*$//'
  (assert (exists (it64 it57 it21 it19)
          (and
            (<= pow2(u1)  1)
            (= (+ (* 2 it64) (* (- 2) pow2(u1)) )  -2)
            (= (+ eee13 (* (- 1) it57) (* (- 1) u1) )  0)
            (= (+ it64 (* (- 2) pow2(eee13)) )  0)
            (exists (it23 i4) (= (+ (* (- 1) i4) it19 it23 )  -1) )
            (exists (it88) (<= it88  -1) )
            (exists (it60) (= (+ (* (- 1) it21) (* (- 1) it57) it60 )  0) )
            (exists (i2) (= (+ (* (- 1) i2) (* (- 3) it19) it21 )  2) )
            )
  )
  timeout
