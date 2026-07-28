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

  $ export CHRO_DEBUG=simpl

  $ timeout 2 Chro --dsimpl --stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (= (+ it159 (* (- 2) (exp 2 (+ 1 it147)))) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        it159 -> (* 2 (exp 2 (+ 1 it147)));
  
  [+simpl]
    iter(3)= True
  [+simpl]
    fixed-point
  
  sat (presimpl int)

  $ export CHRO_EIA=old
  $ timeout 2 Chro --dsimpl --stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (= (+ it159 (* (- 2) (exp 2 (+ 1 it147)))) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        it159 -> (* 2 (exp 2 (+ 1 it147)));
  
  [+simpl]
    iter(3)= True
  [+simpl]
    fixed-point
  
  sat (presimpl int)

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
  $ export CHRO_DEBUG=simpl
  $ unset CHRO_EIA
  $ Chro -bound 0 --dsimpl --stop-after simpl test.smt2 || echo TIMEOUT | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (= (+ (- 15) it1 (* 7 (exp 2 (+ (- 1) it2)))) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        it1 -> (+ 15 (* (- 7) (exp 2 (+ (- 1) it2))));
        
  [+simpl]
    iter(3)= True
  [+simpl]
    fixed-point
  
  sat (presimpl int)

  $ export CHRO_DEBUG=simpl
  $ Chro -bound 0  --dsimpl --stop-after simpl ../../benchmarks/heapsort.c.koat_2.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= (+ (* (- 1) it14) it160) 0)
             (= (+ 1 (* (- 2) (exp 2 (+ (- 1) it147)) it11) it159
                (* (- 2) (exp 2 (+ (- 1) it147)))) 0)
             (= (+ 1 (* (- 1) (exp 2 (+ (- 1) it147)) it11) it158
                (* (- 1) (exp 2 (+ (- 1) it147)))) 0)
             (= (+ 1 (* (- 1) (exp 2 it147)) (* (- 1) it11 (exp 2 it147))
                it157) 0)
             (= (+ (* (- 1) it2) it156) 0)
             (= (+ 1 (* (- 2) (exp 2 (+ (- 1) it147)) it11) it155
                (* (- 2) (exp 2 (+ (- 1) it147)))) 0)
             (= (+ 2 it154 (* (- 2) (exp 2 (+ (- 1) it147)) it11)
                (* (- 2) (exp 2 (+ (- 1) it147)))) 0)
             (= (+ (* (- 1) it4) it153) 0)
             (= (+ (* (- 14) it147) it152 (* (- 1) it6)) 0)
             (= (+ it151 (* (- 1) it5)) 0)
             (<= (+ 1 (* (- 1) it147)) 0)
             (<= (* (- 1) it11) 0)
             (<= it2 0)
             (<= (+ (- 2) (* 2 it11 (exp 2 (+ (- 1) it147))) (* (- 1) it14)
                 (* 2 (exp 2 (+ (- 1) it147)))) 0)
             (<= (* (- 2) it11) 0)
             (<= (+ (* (- 1) it14) (* 2 it11)) 0)
             (<= (+ 1 (* (- 1) it4)) 0)
             (<= (+ 13 (* (- 1) it5)) 0)
             (<= (+ (* (- 1) it14) it11) 0)
             (<= (+ 1 (* (- 1) it14) (* 2 it11)) 0)
             (<= (+ (- 1) (* 2 it11 (exp 2 (+ (- 1) it147))) (* (- 1) it14)
                 (* 2 (exp 2 (+ (- 1) it147)))) 0)
             (<= (+ 1 (* (- 2) it11)) 0)
             (<= (+ 1 (* (- 1) it11)) 0)
             (<= (+ (- 1) (* it11 (exp 2 (+ (- 1) it147))) (* (- 1) it14)
                 (exp 2 (+ (- 1) it147))) 0)
             (<= (+ (- 13) it5) 0)
             (<= (+ 1 (* (- 1) it14)) 0)
             (= (+ it14 (* (- 1) i10)) 0)
             (= (+ it13 (* (- 1) i9)) 0)
             (= (+ (* (- 1) i8) it12) 0)
             (= (+ (- 1) it11) 0)
             (= (+ it10 (* (- 1) i6)) 0)
             (= (+ (* (- 1) i5) it9) 0)
             (= (+ (* (- 1) i4) it8) 0)
             (= (+ it7 (* (- 1) i3)) 0)
             (= (+ (- 12) (* (- 1) i2) it6) 0)
             (= (+ (- 13) it5) 0)
             (= (+ (- 1) i1) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        i1 -> 1;
        it10 -> i6;
        it11 -> 1;
        it12 -> i8;
        it13 -> i9;
        it14 -> i10;
        it151 -> it5;
        it152 -> (+ (* 14 it147) it6);
        it153 -> it4;
        it154 -> (+ (- 2) (* it11 (exp 2 it147)) (exp 2 it147));
        it155 -> (+ (- 1) (* it11 (exp 2 it147)) (exp 2 it147));
        it156 -> it2;
        it157 -> (+ (- 1) (* it11 (exp 2 it147)) (exp 2 it147));
        it158 -> (+ (- 1) (* it11 (exp 2 (+ (- 1) it147)))
                 (exp 2 (+ (- 1) it147)));
        it159 -> (+ (- 1) (* it11 (exp 2 it147)) (exp 2 it147));
        it160 -> it14;
        it6 -> (+ 12 i2);
        it7 -> i3;
        it8 -> i4;
        it9 -> i5;
  
  [+simpl]
    iter(2)= (and
             (= (+ (- 13) it5) 0)
             (= (+ (- 12) (* (- 1) i2) it6) 0)
             (= (+ (- 1) i1) 0)
             (= (+ (- 1) it11) 0)
             (= (+ 1 it155 (* (- 1) it11 (exp 2 it147))
                (* (- 1) (exp 2 it147))) 0)
             (= (+ 1 it157 (* (- 1) it11 (exp 2 it147))
                (* (- 1) (exp 2 it147))) 0)
             (= (+ 1 it158 (* (- 1) it11 (exp 2 (+ (- 1) it147)))
                (* (- 1) (exp 2 (+ (- 1) it147)))) 0)
             (= (+ 1 it159 (* (- 1) it11 (exp 2 it147))
                (* (- 1) (exp 2 it147))) 0)
             (= (+ 2 it154 (* (- 1) it11 (exp 2 it147))
                (* (- 1) (exp 2 it147))) 0)
             (= (+ it151 (* (- 1) it5)) 0)
             (= (+ it153 (* (- 1) it4)) 0)
             (= (+ it156 (* (- 1) it2)) 0)
             (= (+ (* (- 14) it147) it152 (* (- 1) it6)) 0)
             (= (+ (* (- 1) i10) it14) 0)
             (= (+ (* (- 1) i3) it7) 0)
             (= (+ (* (- 1) i4) it8) 0)
             (= (+ (* (- 1) i5) it9) 0)
             (= (+ (* (- 1) i6) it10) 0)
             (= (+ (* (- 1) i8) it12) 0)
             (= (+ (* (- 1) i9) it13) 0)
             (= (+ (* (- 1) it14) it160) 0)
             (<= it2 0)
             (<= (+ (- 13) it5) 0)
             (<= (+ (- 2) (* (- 1) it14) (* it11 (exp 2 it147)) (exp 2 it147)) 0)
             (<= (+ (- 1) (* (- 1) it14) (* it11 (exp 2 it147)) (exp 2 it147)) 0)
             (<= (+ (- 1) (* (- 1) it14) (* it11 (exp 2 (+ (- 1) it147)))
                 (exp 2 (+ (- 1) it147))) 0)
             (<= (+ 1 (* (- 2) it11)) 0)
             (<= (+ 1 (* (- 1) it11)) 0)
             (<= (+ 1 (* (- 1) it14)) 0)
             (<= (+ 1 (* (- 1) it14) (* 2 it11)) 0)
             (<= (+ 1 (* (- 1) it147)) 0)
             (<= (+ 1 (* (- 1) it4)) 0)
             (<= (+ 13 (* (- 1) it5)) 0)
             (<= (+ it11 (* (- 1) it14)) 0)
             (<= (+ (* (- 1) it14) (* 2 it11)) 0)
             (<= (* (- 2) it11) 0)
             (<= (* (- 1) it11) 0))
  [+simpl]
    iter(3)= (and
             (= (+ (- 13) it5) 0)
             (= (+ (* (- 1) i10) it14) 0)
             (= (+ (* 12 (- 1)) it6 (* i2 (- 1))) 0)
             (= (+ (* it11 (exp 2 it147)) (* (- 1) (exp 2 it147))) 0)
             (= (+ (* it11 (exp 2 (+ (- 1) it147))) (* (- 1) (exp 2 it147))
                (exp 2 (+ (- 1) it147))) 0)
             (<= it2 0)
             (<= (+ (- 13) it5) 0)
             (<= (+ (- 2) (* (- 1) i10) (* 2 (exp 2 it147))) 0)
             (<= (+ (- 1) (* (- 1) i10) (* 2 (exp 2 it147))) 0)
             (<= (+ (- 1) (* (- 1) i10) (* 2 (exp 2 (+ (- 1) it147)))) 0)
             (<= (+ 1 (* (- 1) i10)) 0)
             (<= (+ 1 (* (- 1) it147)) 0)
             (<= (+ 1 (* (- 1) it4)) 0)
             (<= (+ 2 (* (- 1) i10)) 0)
             (<= (+ 3 (* (- 1) i10)) 0)
             (<= (+ 13 (* (- 1) it5)) 0))
  [+simpl]
    iter(4)= (and
             (= (+ (- 13) it5) 0)
             (= (+ (* (- 1) (exp 2 it147)) (* 2 (exp 2 (+ (- 1) it147)))) 0)
             (<= it2 0)
             (<= (+ (- 2) (* (- 1) i10) (* 2 (exp 2 it147))) 0)
             (<= (+ (- 1) (* (- 1) i10) (* 2 (exp 2 it147))) 0)
             (<= (+ (- 1) (* (- 1) i10) (exp 2 it147)) 0)
             (<= (+ 1 (* (- 1) i10)) 0)
             (<= (+ 1 (* (- 1) it147)) 0)
             (<= (+ 1 (* (- 1) it4)) 0)
             (<= (+ 2 (* (- 1) i10)) 0)
             (<= (+ 3 (* (- 1) i10)) 0)
             (<= (+ 13 (* (- 1) it5)) 0))
  [+simpl]
    Something ready to substitute
        i1 -> 1;
        it10 -> i6;
        it11 -> 1;
        it12 -> i8;
        it13 -> i9;
        it14 -> i10;
        it151 -> it5;
        it152 -> (+ (* 14 it147) it6);
        it153 -> it4;
        it154 -> (+ (- 2) (* it11 (exp 2 it147)) (exp 2 it147));
        it155 -> (+ (- 1) (* it11 (exp 2 it147)) (exp 2 it147));
        it156 -> it2;
        it157 -> (+ (- 1) (* it11 (exp 2 it147)) (exp 2 it147));
        it158 -> (+ (- 1) (* it11 (exp 2 (+ (- 1) it147)))
                 (exp 2 (+ (- 1) it147)));
        it159 -> (+ (- 1) (* it11 (exp 2 it147)) (exp 2 it147));
        it160 -> it14;
        it5 -> 13;
        it6 -> (+ 12 i2);
        it7 -> i3;
        it8 -> i4;
        it9 -> i5;
  
  [+simpl]
    iter(5)= (and
             (= (+ (- 13) it5) 0)
             (<= it2 0)
             (<= (+ (- 2) (* (- 1) i10) (* 2 (exp 2 it147))) 0)
             (<= (+ (- 1) (* (- 1) i10) (* 2 (exp 2 it147))) 0)
             (<= (+ (- 1) (* (- 1) i10) (exp 2 it147)) 0)
             (<= (+ 1 (* (- 1) i10)) 0)
             (<= (+ 1 (* (- 1) it147)) 0)
             (<= (+ 1 (* (- 1) it4)) 0)
             (<= (+ 2 (* (- 1) i10)) 0)
             (<= (+ 3 (* (- 1) i10)) 0)
             (<= (+ 13 (* (- 1) it5)) 0))
  [+simpl]
    iter(6)= (and
             (<= it2 0)
             (<= (+ (- 2) (* (- 1) i10) (* 2 (exp 2 it147))) 0)
             (<= (+ (- 1) (* (- 1) i10) (* 2 (exp 2 it147))) 0)
             (<= (+ (- 1) (* (- 1) i10) (exp 2 it147)) 0)
             (<= (+ 1 (* (- 1) i10)) 0)
             (<= (+ 1 (* (- 1) it147)) 0)
             (<= (+ 1 (* (- 1) it4)) 0)
             (<= (+ 2 (* (- 1) i10)) 0)
             (<= (+ 3 (* (- 1) i10)) 0))
  [+simpl]
    fixed-point
  
  sat (under int)

  $ unset CHRO_DEBUG
  $ export CHRO_EIA=old
  $ Chro -bound 0 --dsimpl --stop-after simpl ../../benchmarks/heapsort.c.koat_2.smt2
  sat (under int)

Run solver
  $ unset CHRO_EIA
  $ timeout 2  Chro ../../benchmarks/heapsort.c.koat_2.smt2
  sat (under int)

  $ Chro --dsimpl ../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/realheapsort_step2.koat_617.smt2
  sat (presimpl int)
