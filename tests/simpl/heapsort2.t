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
  sat (underapprox2)

  $ export CHRO_EIA=old
  $ timeout 2 Chro -dsimpl -stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  sat (underapprox2)







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
  $ Chro -bound 0  -no-pre-simpl -dsimpl -stop-after simpl ../../benchmarks/heapsort.c.koat_2.smt2 | sed 's/[[:space:]]*$//'
  (assert (exists (it6 it4 it2 it5 it11 it14)
          (and
            (<= (* (- 1) it5)  -13)
            (<= (* (- 1) it14)  -3)
            (<= (* (- 1) it14)  -2)
            (<= (* (- 2) it11)  -1)
            (<= (* (- 1) it11)  -1)
            (<= (* (- 1) it14)  -1)
            (<= (* (- 1) it147)  -1)
            (<= (* (- 1) it4)  -1)
            (<= (* (- 2) it11)  0)
            (<= (* (- 1) it11)  0)
            (<= it2  0)
            (<= (+ (* (- 1) it14) pow2(it147) )  1)
            (<= (+ (* (- 1) it14) (* 2 pow2(it147)) )  1)
            (<= (+ (* (- 1) it14) (* 2 pow2(it147)) )  2)
            (<= it5  13)
            (= it11  1)
            (= it5  13)
            (exists (i10) (= (+ (* (- 1) i10) it14 )  0) )
            (exists (i1) (= i1  1) )
            (exists (i2) (= (+ (* (- 1) i2) it6 )  12) )
            (exists (it10 i6) (= (+ (* (- 1) i6) it10 )  0) )
            (exists (it12 i8) (= (+ (* (- 1) i8) it12 )  0) )
            (exists (it13 i9) (= (+ (* (- 1) i9) it13 )  0) )
            (exists (it154) (= (+ it154 (* (- 2) pow2(it147)) )  -2) )
            (exists (it155) (= (+ it155 (* (- 2) pow2(it147)) )  -1) )
            (exists (it158) (= (+ it158 (* (- 1) pow2(it147)) )  -1) )
            (exists (it160) (= (+ (* (- 1) it14) it160 )  0) )
            (exists (it152) (= (+ (* (- 14) it147) it152 (* (- 1) it6) )  0) )
            (exists (it156) (= (+ it156 (* (- 1) it2) )  0) )
            (exists (it153) (= (+ it153 (* (- 1) it4) )  0) )
            (exists (it151) (= it151  13) )
            (exists (it7 i3) (= (+ (* (- 1) i3) it7 )  0) )
            (exists (it8 i4) (= (+ (* (- 1) i4) it8 )  0) )
            (exists (it9 i5) (= (+ (* (- 1) i5) it9 )  0) )
            )
  )

  $ unset CHRO_DEBUG
  $ export CHRO_EIA=old
  $ Chro -bound 0 -no-pre-simpl -dsimpl -stop-after simpl ../../benchmarks/heapsort.c.koat_2.smt2
  (assert (exists (it6 it4 it2 it5 it11 it14)
          (and
            (<= (* (- 1) it5)  -13)
            (<= (* (- 1) it14)  -3)
            (<= (* (- 1) it14)  -2)
            (<= (* (- 2) it11)  -1)
            (<= (* (- 1) it11)  -1)
            (<= (* (- 1) it14)  -1)
            (<= (* (- 1) it147)  -1)
            (<= (* (- 1) it4)  -1)
            (<= (* (- 2) it11)  0)
            (<= (* (- 1) it11)  0)
            (<= it2  0)
            (<= (+ (* (- 1) it14) pow2(it147) )  1)
            (<= (+ (* (- 1) it14) (* 2 pow2(it147)) )  1)
            (<= (+ (* (- 1) it14) (* 2 pow2(it147)) )  2)
            (<= it5  13)
            (= it11  1)
            (= it5  13)
            (exists (i10) (= (+ (* (- 1) i10) it14 )  0) )
            (exists (i1) (= i1  1) )
            (exists (i2) (= (+ (* (- 1) i2) it6 )  12) )
            (exists (it10 i6) (= (+ (* (- 1) i6) it10 )  0) )
            (exists (it12 i8) (= (+ (* (- 1) i8) it12 )  0) )
            (exists (it13 i9) (= (+ (* (- 1) i9) it13 )  0) )
            (exists (it154) (= (+ it154 (* (- 2) pow2(it147)) )  -2) )
            (exists (it155) (= (+ it155 (* (- 2) pow2(it147)) )  -1) )
            (exists (it158) (= (+ it158 (* (- 1) pow2(it147)) )  -1) )
            (exists (it160) (= (+ (* (- 1) it14) it160 )  0) )
            (exists (it152) (= (+ (* (- 14) it147) it152 (* (- 1) it6) )  0) )
            (exists (it156) (= (+ it156 (* (- 1) it2) )  0) )
            (exists (it153) (= (+ it153 (* (- 1) it4) )  0) )
            (exists (it151) (= it151  13) )
            (exists (it7 i3) (= (+ (* (- 1) i3) it7 )  0) )
            (exists (it8 i4) (= (+ (* (- 1) i4) it8 )  0) )
            (exists (it9 i5) (= (+ (* (- 1) i5) it9 )  0) )
            )
  )

Run solver
  $ unset CHRO_EIA
  $ Chro  -no-pre-simpl ../../benchmarks/heapsort.c.koat_2.smt2
  sat (underapprox2)

