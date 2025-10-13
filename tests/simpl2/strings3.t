  $ export CHRO_DEBUG=1
  $ cat strings3.smt2
  (set-logic QF_S)
  (declare-const x String)
  (declare-const y String)
  (assert (= (str.++ "999" x) (str.++ y x)))
  (check-sat)

  $ Chro -pre-simpl -dpresimpl -dsimpl -stop-after simpl strings3.smt2 -flat 0 -under3 -amin 0 -amax 1 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= (str.++ "999" x) (str.++ y x)))
  iter(2)= (= (str.++ "999" x) (str.++ y x))
  vars_for_under2:
  
  all as: 0 1
  
  iter(1)= (= (str.++ "999" x) (str.++ y x))
  (= (str.++ "999" x) (str.++ y x))
  Looking for SAT in 1 asts...
  Simplify step: (= (str.++ "999" x) (str.++ y x))
  Simplify step: (= (str.++ "999" x) (str.++ y x))
  Simplified expression: (= (str.++ "999" x) (str.++ y x))
  unknown
  ; Under2 resigns
  iter(1)= (and
             (= eeb6 (str.len x))
             (= eeb2 (str.len x))
             (= eeb6 eeb2)
             (= eeb5 (+ (* eeb7 (exp 10 eeb6)) eeb8))
             (= eeb8 (str.to.int x))
             (= eeb7 (str.to.int y))
             (= eeb2 eeb2)
             (= eeb1 (+ (* eeb3 (exp 10 eeb2)) eeb4))
             (= eeb4 (str.to.int x))
             (= eeb3 999)
             (= (str.from_int eeb1) (str.from_int eeb5)))
  Something ready to substitute:  eeb3 -> 999; eeb6 -> eeb2;
  iter(2)= (and
             (= eeb1 (+ eeb4 (* eeb3 (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb3 999)
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6))))
             (= eeb6 eeb2)
             (= eeb6 (str.len x))
             (= eeb7 (str.to.int y))
             (= eeb8 (str.to.int x))
             (= eeb1 eeb5))
  Something ready to substitute:  eeb1 ->s eeb5; eeb3 -> 999; eeb6 -> eeb2;
  iter(3)= (and
             (= eeb1 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb2))))
             (= eeb7 (str.to.int y))
             (= eeb8 (str.to.int x))
             (= eeb1 eeb5))
  iter(4)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb2))))
             (= eeb7 (str.to.int y))
             (= eeb8 (str.to.int x)))
  vars_for_under2: eeb7
  
  all as: 0 1
  
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (* 0 (exp 10 eeb2)) (* (exp 10 u9) (exp 10 eeb2))))
             (= eeb8 (str.to.int x))
             (= (+ (exp 10 u9) 0) (str.to.int y)))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (exp 10 (+ u9 eeb2))))
             (= eeb8 (str.to.int x))
             (= (exp 10 u9) (str.to.int y)))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (exp 10 (+ eeb2 u9))))
             (= eeb8 (str.to.int x))
             (= (exp 10 u9) (str.to.int y)))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (* 1 (exp 10 eeb2))
                     (* (exp 10 u10) (exp 10 eeb2))))
             (= eeb8 (str.to.int x))
             (= (+ (exp 10 u10) 1) (str.to.int y)))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (exp 10 eeb2) (exp 10 (+ u10 eeb2))))
             (= eeb8 (str.to.int x))
             (= (+ 1 (exp 10 u10)) (str.to.int y)))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (exp 10 eeb2) (exp 10 (+ eeb2 u10))))
             (= eeb8 (str.to.int x))
             (= (+ 1 (exp 10 u10)) (str.to.int y)))
  (= (str.++ "999" x) (str.++ y x))
  Looking for SAT in 2 asts...
  Simplify step: ((= eee11 (+ eeb2 u9)) & (= eeb2 (str.len x)) & (= eeb4 (str.to.int x)) & (= eeb5
  (+ eeb4 (* 999 (exp 10 eeb2)))) & (= eeb5 (+ eeb8 (exp 10 eee11))) & (= eeb8 (str.to.int x)) & (= (exp 10 u9) (str.to.int y)))
  Simplified expression: (and
                           (= eee11 (+ eeb2 u9))
                           (= eeb2 (str.len x))
                           (= eeb4 (str.to.int x))
                           (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
                           (= eeb5 (+ eeb8 (exp 10 eee11)))
                           (= eeb8 (str.to.int x))
                           (= (exp 10 u9) (str.to.int y)))
  iter(1)= (and
             (and
               (= (+ (* (- 1) u9) (* 1 eee11) (* (- 1) eeb2)) 0))
             (and
               (= (+ (* 1 eeb2) (* (- 1) %0)) 0)
               (= %1 (chrob.len x))
               (= (+ (* 1 (exp 10 %0)) (* (- 1) %1)) 1))
             (and
               (= (+ (* (- 1) x) (* 1 eeb4)) 0))
             (and
               (= (+ (* (- 999) (exp 10 eeb2)) (* 1 eeb5) (* (- 1) eeb4)) 0))
             (and
               (= (+ (* (- 1) (exp 10 eee11)) (* (- 1) eeb8) (* 1 eeb5)) 0))
             (and
               (= (+ (* (- 1) x) (* 1 eeb8)) 0))
             (and
               (= (+ (* 1 (exp 10 u9)) (* (- 1) y)) 0)))
  iter(2)= (and
             (= %1 (chrob.len x))
             (= (+ eeb2 (* (- 1) %0)) 0)
             (= (+ eeb4 (* (- 1) x)) 0)
             (= (+ eeb5 (* (- 999) (exp 10 eeb2)) (* (- 1) eeb4)) 0)
             (= (+ eeb5 (* (- 1) eeb8) (* (- 1) (exp 10 eee11))) 0)
             (= (+ eeb8 (* (- 1) x)) 0)
             (= (+ eee11 (* (- 1) eeb2) (* (- 1) u9)) 0)
             (= (+ (* (- 1) %1) (exp 10 %0)) 1)
             (= (+ (* (- 1) y) (exp 10 u9)) 0))
  Something ready to substitute:  eeb2 -> %0; eeb4 -> x; eeb5 -> (+ (*
                                                                    (* (- 999)
                                                                    (exp 10 %0))
                                                                    (- 1))
                                                                 (* (* (- 1) x)
                                                                 (- 1))); eeb8 ->
                                 x; y -> (exp 10 u9);
  iter(3)= (and
             (= %1 (chrob.len x))
             (= (+ eeb2 (* (- 1) %0)) 0)
             (= (+ eeb4 (* (- 1) x)) 0)
             (= (+ eeb5 (* (- 999) (exp 10 eeb2)) (* (- 1) eeb4)) 0)
             (= (+ eeb5 (* (- 1) eeb8) (* (- 1) (exp 10 eee11))) 0)
             (= (+ eeb8 (* (- 1) x)) 0)
             (= (+ eee11 (* (- 1) eeb2) (* (- 1) u9)) 0)
             (= (+ (* (- 1) %1) (exp 10 %0)) 1)
             (= (+ (* (- 1) y) (exp 10 u9)) 0))
  iter(4)= (and
             (= %1 (chrob.len x))
             (= (+ eee11 (* (- 1) %0) (* (- 1) u9)) 0)
             (= (+ (* (- 999) (exp 10 %0)) (* (- 1) x)
                (* (* (- 999) (exp 10 %0)) (- 1)) (* (* (- 1) x) (- 1))) 0)
             (= (+ (* (- 1) %1) (exp 10 %0)) 1)
             (= (+ (* (- 1) x) (* (- 1) (exp 10 eee11))
                (* (* (- 999) (exp 10 %0)) (- 1)) (* (* (- 1) x) (- 1))) 0))
  Something ready to substitute:  eeb2 -> %0; eeb4 -> x; eeb5 -> (+ (*
                                                                    (* (- 999)
                                                                    (exp 10 %0))
                                                                    (- 1))
                                                                 (* (* (- 1) x)
                                                                 (- 1))); eeb8 ->
                                 x; u9 -> (+ eee11 (* (- 1) %0)); y ->
                                 (exp 10 u9);
  iter(5)= (and
             (= %1 (chrob.len x))
             (= (+ eee11 (* (- 1) %0) (* (- 1) u9)) 0)
             (= (+ (* (- 1) %1) (exp 10 %0)) 1)
             (= (+ (* (- 1) (exp 10 eee11)) (* 999 (exp 10 %0))) 0))
  iter(6)= (and
             (= %1 (chrob.len x))
             (= (+ eee11 (* eee11 (- 1)) (* (- 1) %0) (* (* (- 1) %0) (- 1))) 0)
             (= (+ (* (- 1) %1) (exp 10 %0)) 1)
             (= (+ (* (- 1) (exp 10 eee11)) (* 999 (exp 10 %0))) 0))
  iter(7)= (and
             (= %1 (chrob.len x))
             (= (+ (* (- 1) %1) (exp 10 %0)) 1)
             (= (+ (* (- 1) (exp 10 eee11)) (* 999 (exp 10 %0))) 0))
  Simplify step: ((= %1 (chrob.len x)) & (= (+ (* (- 1) %1) (exp 10 %0)) 1) & (=
  (+ (* (- 1) (exp 10 eee11)) (* 999 (exp 10 %0))) 0))
  Simplified expression: (and
                           (= %1 (chrob.len x))
                           (= (+ (* (- 1) %1) (exp 10 %0)) 1)
                           (= (+ (* (- 1) (exp 10 eee11)) (* 999 (exp 10 %0))) 0))
  (assert (exists (%1)
          (and
            (exists (x) (= %1 (chrob.len x)))
            (= (+ (* (- 1) %1) pow2(%0) )  1)
            (= (+ (* 999 pow2(%0)) (* (- 1) pow2(eee11)) )  0)
            )
  )
  $ unset CHRO_DEBUG
  $ timeout 2 Chro -pre-simpl -dsimpl strings3.smt2 -flat 0 -under3 -amin 0 -amax 1
  unknown
  ; Under2 resigns
  (assert (exists (%1)
          (and
            (exists (x) (= %1 (chrob.len x)))
            (= (+ (* (- 1) %1) pow2(%0) )  1)
            (= (+ (* 999 pow2(%0)) (* (- 1) pow2(eee11)) )  0)
            )
  )
  (assert (exists (%3)
          (and
            (exists (y) (= (+ (* (- 1) y) pow2(u10) )  -1) )
            (exists (x) (= %3 (chrob.len x)))
            (= (+ (* (- 1) %2) eee12 (* (- 1) u10) )  0)
            (= (+ (* (- 1) %3) pow2(%2) )  1)
            (= (+ (* 998 pow2(%2)) (* (- 1) pow2(eee12)) )  0)
            )
  )
  (assert (<= (+ eee12 (* (- 1) pow2(eee12)) )  -1) )
  (assert (<= (+ (* (- 1) eee12) pow2(%2) )  0) )
  (assert (<= (+ %2 (* (- 1) pow2(%2)) )  -1) )
  (assert (<= (+ (* (- 1) %2) pow2(u10) )  0) )
  (assert (<= (+ u10 (* (- 1) pow2(u10)) )  -1) )
  
  (assert (<= (+ eee12 (* (- 1) pow2(eee12)) )  -1) )
  (assert (<= (+ (* (- 1) eee12) pow2(%2) )  0) )
  (assert (<= (+ (* (- 1) pow2(%2)) pow2(u10) )  0) )
  (assert (<= (+ %2 (* (- 1) pow2(u10)) )  0) )
  (assert (<= (+ (* (- 1) %2) u10 )  0) )
  
  (assert (<= (+ eee12 (* (- 1) pow2(eee12)) )  -1) )
  (assert (<= (+ (* (- 1) eee12) pow2(u10) )  0) )
  (assert (<= (+ u10 (* (- 1) pow2(u10)) )  -1) )
  (assert (<= (+ (* (- 1) u10) pow2(%2) )  0) )
  (assert (<= (+ %2 (* (- 1) pow2(%2)) )  -1) )
  
  (assert (<= (+ eee12 (* (- 1) pow2(eee12)) )  -1) )
  (assert (<= (+ (* (- 1) eee12) pow2(u10) )  0) )
  (assert (<= (+ pow2(%2) (* (- 1) pow2(u10)) )  0) )
  (assert (<= (+ u10 (* (- 1) pow2(%2)) )  0) )
  (assert (<= (+ %2 (* (- 1) u10) )  0) )
  
  (assert (<= (+ pow2(%2) (* (- 1) pow2(eee12)) )  0) )
  (assert (<= (+ eee12 (* (- 1) pow2(%2)) )  0) )
  (assert (<= (+ %2 (* (- 1) eee12) )  0) )
  (assert (<= (+ (* (- 1) %2) pow2(u10) )  0) )
  (assert (<= (+ u10 (* (- 1) pow2(u10)) )  -1) )
  
  (assert (<= (+ pow2(%2) (* (- 1) pow2(eee12)) )  0) )
  (assert (<= (+ eee12 (* (- 1) pow2(%2)) )  0) )
  (assert (<= (+ (* (- 1) eee12) pow2(u10) )  0) )
  (assert (<= (+ %2 (* (- 1) pow2(u10)) )  0) )
  (assert (<= (+ (* (- 1) %2) u10 )  0) )
  
  (assert (<= (+ pow2(%2) (* (- 1) pow2(eee12)) )  0) )
  (assert (<= (+ (* (- 1) pow2(%2)) pow2(u10) )  0) )
  (assert (<= (+ eee12 (* (- 1) pow2(u10)) )  0) )
  (assert (<= (+ %2 (* (- 1) eee12) )  0) )
  (assert (<= (+ (* (- 1) %2) u10 )  0) )
  
  (assert (<= (+ (* (- 1) pow2(eee12)) pow2(u10) )  0) )
  (assert (<= (+ eee12 (* (- 1) pow2(u10)) )  0) )
  (assert (<= (+ (* (- 1) eee12) u10 )  0) )
  (assert (<= (+ (* (- 1) u10) pow2(%2) )  0) )
  (assert (<= (+ %2 (* (- 1) pow2(%2)) )  -1) )
  
  (assert (<= (+ (* (- 1) pow2(eee12)) pow2(u10) )  0) )
  (assert (<= (+ eee12 (* (- 1) pow2(u10)) )  0) )
  (assert (<= (+ (* (- 1) eee12) pow2(%2) )  0) )
  (assert (<= (+ u10 (* (- 1) pow2(%2)) )  0) )
  (assert (<= (+ %2 (* (- 1) u10) )  0) )
  
  (assert (<= (+ (* (- 1) pow2(eee12)) pow2(u10) )  0) )
  (assert (<= (+ pow2(%2) (* (- 1) pow2(u10)) )  0) )
  (assert (<= (+ eee12 (* (- 1) pow2(%2)) )  0) )
  (assert (<= (+ (* (- 1) eee12) u10 )  0) )
  (assert (<= (+ %2 (* (- 1) u10) )  0) )
  
  (assert (<= (+ u10 (* (- 1) pow2(u10)) )  -1) )
  (assert (<= (+ (* (- 1) u10) pow2(eee12) )  0) )
  (assert (<= (+ eee12 (* (- 1) pow2(eee12)) )  -1) )
  (assert (<= (+ (* (- 1) eee12) pow2(%2) )  0) )
  (assert (<= (+ %2 (* (- 1) pow2(%2)) )  -1) )
  
  (assert (<= (+ u10 (* (- 1) pow2(u10)) )  -1) )
  (assert (<= (+ (* (- 1) u10) pow2(eee12) )  0) )
  (assert (<= (+ pow2(%2) (* (- 1) pow2(eee12)) )  0) )
  (assert (<= (+ eee12 (* (- 1) pow2(%2)) )  0) )
  (assert (<= (+ %2 (* (- 1) eee12) )  0) )
  
  (assert (<= (+ pow2(eee12) (* (- 1) pow2(u10)) )  0) )
  (assert (<= (+ u10 (* (- 1) pow2(eee12)) )  0) )
  (assert (<= (+ eee12 (* (- 1) u10) )  0) )
  (assert (<= (+ (* (- 1) eee12) pow2(%2) )  0) )
  (assert (<= (+ %2 (* (- 1) pow2(%2)) )  -1) )
  
  (assert (<= (+ pow2(eee12) (* (- 1) pow2(u10)) )  0) )
  (assert (<= (+ u10 (* (- 1) pow2(eee12)) )  0) )
  (assert (<= (+ (* (- 1) u10) pow2(%2) )  0) )
  (assert (<= (+ eee12 (* (- 1) pow2(%2)) )  0) )
  (assert (<= (+ %2 (* (- 1) eee12) )  0) )
  
  (assert (<= (+ pow2(eee12) (* (- 1) pow2(u10)) )  0) )
  (assert (<= (+ pow2(%2) (* (- 1) pow2(eee12)) )  0) )
  (assert (<= (+ u10 (* (- 1) pow2(%2)) )  0) )
  (assert (<= (+ eee12 (* (- 1) u10) )  0) )
  (assert (<= (+ %2 (* (- 1) eee12) )  0) )
  
  unknown
  ; Under3 resigns
