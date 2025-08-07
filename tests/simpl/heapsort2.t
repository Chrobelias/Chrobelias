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
  $ Chro -dsimpl -stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  (assert (exists (it159) (= (+ it159 (* (- 4) pow2(it147)) )  0)
  )

  $ export CHRO_EIA=old
  $ Chro -dsimpl -stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  (assert (exists (it159) (= (+ it159 (* (- 2) pow2(691769754)) )  0)  )
  (assert (exists (it147) (= (+ it147 (* (- 1) [691769754]) )  -1)  )
  

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
  $ Chro -dsimpl -stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  (assert (exists (it1) (= (+ (* 2 it1) (* 7 pow2(it2)) )  30)
  )

$ export CHRO_DEBUG=1
  $ Chro -dsimpl -stop-after simpl ../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/heapsort.c.koat_2.smt2
  (assert (exists (it6 it160)
          (and
            (exists (it159) (= (+ it159 (* (- 2) pow2(it147)) )  -1) 
            (exists (it158) (= (+ it158 (* (- 1) pow2(it147)) )  -1) 
            (exists (it157) (= (+ it157 (* (- 2) pow2(it147)) )  -1) 
            (exists (it155) (= (+ it155 (* (- 2) pow2(it147)) )  -1) 
            (exists (it154) (= (+ it154 (* (- 2) pow2(it147)) )  -2) 
            (exists (it152) (= (+ (* (- 14) it147) it152 (* (- 1) it6) )  0) 
            (<= (+ (* (- 1) it160) pow2(it147) )  1)
            (<= (+ (* (- 1) it160) (* 2 pow2(it147)) )  1)
            (<= (* (- 1) it160)  -3)
            (exists (it4) (<= (* (- 1) it4)  -1) 
            (exists (it2) (<= it2  0) 
            (<= (* (- 1) it147)  -1)
            (exists (i2) (= (+ (* (- 1) i2) it6 )  12) 
            
  )

  $ unset CHRO_DEBUG
  $ export CHRO_EIA=old
  $ Chro -dsimpl -stop-after simpl ../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/heapsort.c.koat_2.smt2
  (assert (exists (it6 it160)
          (and
            (exists (it159)
            (= (+ it159 (* (- 2) pow2(1061553262)) (* (- 2) pow2(691769754)) )
             -1) 
            (= (+ it147 (* (- 1) [691769754]) )  1)
            (= (+ it147 (* (- 1) [1061553262]) )  1)
            (exists (it158)
            (= (+ it158 (* (- 1) pow2(344373510)) (* (- 1) pow2(616584865)) )
             -1) 
            (= (+ it147 (* (- 1) [344373510]) )  1)
            (= (+ it147 (* (- 1) [616584865]) )  1)
            (exists (it157) (= (+ it157 (* (- 2) pow2(it147)) )  -1) 
            (exists (it155)
            (= (+ it155 (* (- 2) pow2(2616996)) (* (- 2) pow2(582111861)) )
             -1) 
            (= (+ it147 (* (- 1) [2616996]) )  1)
            (= (+ it147 (* (- 1) [582111861]) )  1)
            (exists (it154)
            (= (+ it154 (* (- 2) pow2(403737495)) (* (- 2) pow2(786655037)) )
             -2) 
            (= (+ it147 (* (- 1) [403737495]) )  1)
            (= (+ it147 (* (- 1) [786655037]) )  1)
            (exists (it152) (= (+ (* (- 14) it147) it152 (* (- 1) it6) )  0) 
            (<= (+ (* (- 1) it160) pow2(234874283) pow2(861395434) )  1)
            (= (+ it147 (* (- 1) [234874283]) )  1)
            (= (+ it147 (* (- 1) [861395434]) )  1)
            (<= (+ (* (- 1) it160) (* 2 pow2(772162098)) (* 2 pow2(917958495))
                )
             1)
            (= (+ it147 (* (- 1) [772162098]) )  1)
            (= (+ it147 (* (- 1) [917958495]) )  1)
            (<= (* (- 1) it160)  -3)
            (exists (it4) (<= (* (- 1) it4)  -1) 
            (<= (+ (* (- 1) it160) (* 2 pow2(53725144)) (* 2 pow2(862765034)) )
             2)
            (= (+ it147 (* (- 1) [53725144]) )  1)
            (= (+ it147 (* (- 1) [862765034]) )  1)
            (exists (it2) (<= it2  0) 
            (<= (* (- 1) it147)  -1)
            (exists (i2) (= (+ (* (- 1) i2) it6 )  12) 
            
  )
Run solver
  $ unset CHRO_EIA
$ Chro ../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/heapsort.c.koat_2.smt2
