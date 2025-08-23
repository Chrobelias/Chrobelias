  $ cat > test.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun it11 () Int)
  > (declare-fun it147 () Int)
  > (declare-fun it159 () Int)
  > (assert
  >   (= (+ it159
  >         (* (exp 2 (+ 1 it147)) (- 2))
  >         )
  >      0))
  > (check-sat)
  > EOF
$ export OCAMLRUNPARAM='b=0'
$ export CHRO_DEBUG=1

  $ unset CHRO_EIA=
  $ timeout 2 Chro -dsimpl -stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  (assert (exists (it159) (= (+ it159 (* (- 4) pow2(it147)) )  0) )
  )

  $ export CHRO_EIA=old
  $ timeout 2 Chro -dsimpl -stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  (assert (exists (it147) (= (+ (* (- 1)  %0) it147 )  -1) ) )
  (assert (exists (it159) (= (+ it159 (* (- 2) pow2( %0)) )  0) ) )
  






  $ cat > test.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun it1 () Int)
  > (declare-fun it2 () Int)
  > (assert
  >   (= (+ it1
  >         (* (exp 2 (- it2 1)) 7)
  >         )
  >      15))
  > (check-sat)
  > EOF
$ export CHRO_DEBUG=1
  $ unset CHRO_EIA
  $ Chro -bound 0 -dsimpl -stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  (assert (exists (it1) (= (+ (* 2 it1) (* 7 pow2(it2)) )  30) )
  )

$ export CHRO_DEBUG=1
  $ Chro -bound 0 -dsimpl -stop-after simpl ../../benchmarks/heapsort.c.koat_2.smt2 | sed 's/[[:space:]]*$//'
  (assert (exists (it6 it160)
          (and
            (<= (* (- 1) it160)  -3)
            (<= (* (- 1) it147)  -1)
            (<= (+ (* (- 1) it160) pow2(it147) )  1)
            (<= (+ (* (- 1) it160) (* 2 pow2(it147)) )  1)
            (exists (it4) (<= (* (- 1) it4)  -1) )
            (exists (it2) (<= it2  0) )
            (exists (it154) (= (+ it154 (* (- 2) pow2(it147)) )  -2) )
            (exists (it155) (= (+ it155 (* (- 2) pow2(it147)) )  -1) )
            (exists (it158) (= (+ it158 (* (- 1) pow2(it147)) )  -1) )
            (exists (it152) (= (+ (* (- 14) it147) it152 (* (- 1) it6) )  0) )
            (exists (i2) (= (+ (* (- 1) i2) it6 )  12) )
            )
  )

  $ unset CHRO_DEBUG
  $ export CHRO_EIA=old
  $ Chro -bound 0 -dsimpl -stop-after simpl ../../benchmarks/heapsort.c.koat_2.smt2
  (assert (exists (it6 it160)
          (and
            (<= (* (- 1) it160)  -3)
            (<= (* (- 1) it147)  -1)
            (<= (+ (* (- 1) it160) (* 2 pow2( %10)) (* 2 pow2( %11)) )  1)
            (<= (+ (* (- 1) it160) pow2( %8) pow2( %9) )  1)
            (<= (+ (* (- 1) it160) (* 2 pow2( %12)) (* 2 pow2( %13)) )  2)
            (= (+ (* (- 1)  %0) it147 )  1)
            (= (+ (* (- 1)  %1) it147 )  1)
            (= (+ (* (- 1)  %10) it147 )  1)
            (= (+ (* (- 1)  %11) it147 )  1)
            (= (+ (* (- 1)  %12) it147 )  1)
            (= (+ (* (- 1)  %13) it147 )  1)
            (= (+ (* (- 1)  %2) it147 )  1)
            (= (+ (* (- 1)  %3) it147 )  1)
            (= (+ (* (- 1)  %4) it147 )  1)
            (= (+ (* (- 1)  %5) it147 )  1)
            (= (+ (* (- 1)  %6) it147 )  1)
            (= (+ (* (- 1)  %7) it147 )  1)
            (= (+ (* (- 1)  %8) it147 )  1)
            (= (+ (* (- 1)  %9) it147 )  1)
            (exists (it4) (<= (* (- 1) it4)  -1) )
            (exists (it2) (<= it2  0) )
            (exists (it154)
            (= (+ it154 (* (- 2) pow2( %6)) (* (- 2) pow2( %7)) )  -2) )
            (exists (it159)
            (= (+ it159 (* (- 2) pow2( %0)) (* (- 2) pow2( %1)) )  -1) )
            (exists (it158)
            (= (+ it158 (* (- 1) pow2( %2)) (* (- 1) pow2( %3)) )  -1) )
            (exists (it155)
            (= (+ it155 (* (- 2) pow2( %4)) (* (- 2) pow2( %5)) )  -1) )
            (exists (it157) (= (+ it157 (* (- 2) pow2(it147)) )  -1) )
            (exists (it152) (= (+ (* (- 14) it147) it152 (* (- 1) it6) )  0) )
            (exists (i2) (= (+ (* (- 1) i2) it6 )  12) )
            )
  )

Run solver
  $ unset CHRO_EIA
  $ Chro ../../benchmarks/heapsort.c.koat_2.smt2
  sat

