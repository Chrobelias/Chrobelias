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
  sat ; presimpl

  $ export CHRO_EIA=old
  $ timeout 2 Chro -dsimpl -stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  sat ; presimpl







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
  $ Chro -bound 0 -dsimpl -stop-after simpl test.smt2 || echo TIMEOUT | sed 's/[[:space:]]*$//'
  (assert (exists (it1) (= (+ (* 2 it1) (* 7 pow2(it2)) )  30) )
  )

$ export CHRO_DEBUG=1
  $ Chro -bound 0  -no-pre-simpl -dsimpl -stop-after simpl ../../benchmarks/heapsort.c.koat_2.smt2 | sed 's/[[:space:]]*$//'
  (assert (exists (it14)
          (and
            (exists (it11)
            (and
              (<= (* (- 1) it11)  -1)
              (<= (* (- 2) it11)  -1)
              (<= (* (- 2) it11)  0)
              (<= (* (- 1) it11)  0)
              (= it11  1)
              )
            (exists (it5)
            (and
              (<= it5  13)
              (<= (* (- 1) it5)  -13)
              (= it5  13)
              )
            (exists (it6)
            (and
              (exists (it152) (= (+ (* (- 14) it147) it152 (* (- 1) it6) )  0)
              )
              (exists (i2) (= (+ (* (- 1) i2) it6 )  12) )
              )
            (exists (it4)
            (and
              (exists (it153) (= (+ it153 (* (- 1) it4) )  0) )
              (<= (* (- 1) it4)  -1)
              )
            (exists (it2)
            (and
              (exists (it156) (= (+ it156 (* (- 1) it2) )  0) )
              (<= it2  0)
              )
            (exists (i5 it9) (= (+ (* (- 1) i5) it9 )  0) )
            (exists (i4 it8) (= (+ (* (- 1) i4) it8 )  0) )
            (exists (i3 it7) (= (+ (* (- 1) i3) it7 )  0) )
            (exists (it160) (= (+ (* (- 1) it14) it160 )  0) )
            (exists (it159) (= (+ it159 (* (- 2) pow2(it147)) )  -1) )
            (exists (it158) (= (+ it158 (* (- 1) pow2(it147)) )  -1) )
            (exists (it157) (= (+ it157 (* (- 2) pow2(it147)) )  -1) )
            (exists (it155) (= (+ it155 (* (- 2) pow2(it147)) )  -1) )
            (exists (it154) (= (+ it154 (* (- 2) pow2(it147)) )  -2) )
            (exists (it151) (= it151  13) )
            (exists (i9 it13) (= (+ (* (- 1) i9) it13 )  0) )
            (exists (i8 it12) (= (+ (* (- 1) i8) it12 )  0) )
            (exists (i6 it10) (= (+ (* (- 1) i6) it10 )  0) )
            (exists (i10) (= (+ (* (- 1) i10) it14 )  0) )
            (exists (i1) (= i1  1) )
            (<= (* (- 1) it14)  -1)
            (<= (+ (* (- 1) it14) pow2(it147) )  1)
            (<= (+ (* (- 1) it14) (* 2 pow2(it147)) )  1)
            (<= (* (- 1) it14)  -3)
            (<= (* (- 1) it14)  -1)
            (<= (* (- 1) it14)  -2)
            (<= (+ (* (- 1) it14) (* 2 pow2(it147)) )  2)
            (<= (* (- 1) it147)  -1)
            )
  )

  $ unset CHRO_DEBUG
  $ export CHRO_EIA=old
  $ Chro -bound 0 -no-pre-simpl -dsimpl -stop-after simpl ../../benchmarks/heapsort.c.koat_2.smt2
  (assert (exists (it14)
          (and
            (exists (it11)
            (and
              (<= (* (- 1) it11)  -1)
              (<= (* (- 2) it11)  -1)
              (<= (* (- 2) it11)  0)
              (<= (* (- 1) it11)  0)
              (= it11  1)
              )
            (exists (it5)
            (and
              (<= it5  13)
              (<= (* (- 1) it5)  -13)
              (= it5  13)
              )
            (exists (it6)
            (and
              (exists (it152) (= (+ (* (- 14) it147) it152 (* (- 1) it6) )  0)
              )
              (exists (i2) (= (+ (* (- 1) i2) it6 )  12) )
              )
            (exists (it4)
            (and
              (exists (it153) (= (+ it153 (* (- 1) it4) )  0) )
              (<= (* (- 1) it4)  -1)
              )
            (exists (it2)
            (and
              (exists (it156) (= (+ it156 (* (- 1) it2) )  0) )
              (<= it2  0)
              )
            (exists (i5 it9) (= (+ (* (- 1) i5) it9 )  0) )
            (exists (i4 it8) (= (+ (* (- 1) i4) it8 )  0) )
            (exists (i3 it7) (= (+ (* (- 1) i3) it7 )  0) )
            (exists (it160) (= (+ (* (- 1) it14) it160 )  0) )
            (exists (it159) (= (+ it159 (* (- 2) pow2(it147)) )  -1) )
            (exists (it158) (= (+ it158 (* (- 1) pow2(it147)) )  -1) )
            (exists (it157) (= (+ it157 (* (- 2) pow2(it147)) )  -1) )
            (exists (it155) (= (+ it155 (* (- 2) pow2(it147)) )  -1) )
            (exists (it154) (= (+ it154 (* (- 2) pow2(it147)) )  -2) )
            (exists (it151) (= it151  13) )
            (exists (i9 it13) (= (+ (* (- 1) i9) it13 )  0) )
            (exists (i8 it12) (= (+ (* (- 1) i8) it12 )  0) )
            (exists (i6 it10) (= (+ (* (- 1) i6) it10 )  0) )
            (exists (i10) (= (+ (* (- 1) i10) it14 )  0) )
            (exists (i1) (= i1  1) )
            (<= (* (- 1) it14)  -1)
            (<= (+ (* (- 1) it14) pow2(it147) )  1)
            (<= (+ (* (- 1) it14) (* 2 pow2(it147)) )  1)
            (<= (* (- 1) it14)  -3)
            (<= (* (- 1) it14)  -1)
            (<= (* (- 1) it14)  -2)
            (<= (+ (* (- 1) it14) (* 2 pow2(it147)) )  2)
            (<= (* (- 1) it147)  -1)
            )
  )

Run solver
  $ unset CHRO_EIA
  $ timeout 2  Chro  -no-pre-simpl ../../benchmarks/heapsort.c.koat_2.smt2
  sat ; underapprox1

