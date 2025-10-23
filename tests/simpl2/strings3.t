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
             (= %1 (str.from_int eeb5))
             (= %0 (str.from_int eeb1))
             (= eeb6 eeb2)
             (= eeb5 (+ (* eeb7 (exp 10 eeb6)) eeb8))
             (= eeb8 (str.to.int x))
             (= eeb7 999)
             (= eeb2 eeb2)
             (= eeb1 (+ (* eeb3 (exp 10 eeb2)) eeb4))
             (= eeb4 (str.to.int x))
             (= eeb3 (str.to.int y))
             (= %1 %0))
  Something ready to substitute
        %1 -> %0
        eeb6 -> eeb2
        eeb7 -> 999
  
  iter(2)= (and
             (= %0 (str.from_int eeb1))
             (= %1 %0)
             (= %1 (str.from_int eeb5))
             (= eeb1 (+ eeb4 (* eeb3 (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb3 (str.to.int y))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6))))
             (= eeb6 eeb2)
             (= eeb6 (str.len x))
             (= eeb7 999)
             (= eeb8 (str.to.int x)))
  iter(3)= (and
             (= %0 (str.from_int eeb1))
             (= %0 (str.from_int eeb5))
             (= eeb1 (+ eeb4 (* eeb3 (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb3 (str.to.int y))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* 999 (exp 10 eeb2))))
             (= eeb8 (str.to.int x)))
  vars_for_under2: eeb3
  
  all as: 0 1
  
  iter(1)= (and
             (= %0 (str.from_int eeb1))
             (= %0 (str.from_int eeb5))
             (= eeb1 (+ eeb4 (* 0 (exp 10 eeb2)) (* (exp 10 u9) (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* 999 (exp 10 eeb2))))
             (= eeb8 (str.to.int x))
             (= (+ (exp 10 u9) 0) (str.to.int y)))
  iter(2)= (and
             (= %0 (str.from_int eeb1))
             (= %0 (str.from_int eeb5))
             (= eeb1 (+ eeb4 (exp 10 (+ u9 eeb2))))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* 999 (exp 10 eeb2))))
             (= eeb8 (str.to.int x))
             (= (exp 10 u9) (str.to.int y)))
  iter(3)= (and
             (= %0 (str.from_int eeb1))
             (= %0 (str.from_int eeb5))
             (= eeb1 (+ eeb4 (exp 10 (+ eeb2 u9))))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* 999 (exp 10 eeb2))))
             (= eeb8 (str.to.int x))
             (= (exp 10 u9) (str.to.int y)))
  iter(1)= (and
             (= %0 (str.from_int eeb1))
             (= %0 (str.from_int eeb5))
             (= eeb1 (+ eeb4 (* 1 (exp 10 eeb2))
                     (* (exp 10 u10) (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* 999 (exp 10 eeb2))))
             (= eeb8 (str.to.int x))
             (= (+ (exp 10 u10) 1) (str.to.int y)))
  iter(2)= (and
             (= %0 (str.from_int eeb1))
             (= %0 (str.from_int eeb5))
             (= eeb1 (+ eeb4 (exp 10 eeb2) (exp 10 (+ u10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* 999 (exp 10 eeb2))))
             (= eeb8 (str.to.int x))
             (= (+ 1 (exp 10 u10)) (str.to.int y)))
  iter(3)= (and
             (= %0 (str.from_int eeb1))
             (= %0 (str.from_int eeb5))
             (= eeb1 (+ eeb4 (exp 10 eeb2) (exp 10 (+ eeb2 u10))))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* 999 (exp 10 eeb2))))
             (= eeb8 (str.to.int x))
             (= (+ 1 (exp 10 u10)) (str.to.int y)))
  (= (str.++ "999" x) (str.++ y x))
  Looking for SAT in 2 asts...
  Simplify step: ((= eee11 (+ eeb2 u9)) & (= %0 (str.from_int eeb1)) &
  (= %0 (str.from_int eeb5)) & (= eeb1 (+ eeb4 (exp 10 eee11))) & (= eeb2 (str.len x)) &
  (= eeb4 (str.to.int x)) & (= eeb5 (+ eeb8 (* 999 (exp 10 eeb2)))) & (= eeb8 (str.to.int x)) &
  (= (exp 10 u9) (str.to.int y)))
  Simplified expression: (and
                           (= eee11 (+ eeb2 u9))
                           (= %0 (str.from_int eeb1))
                           (= %0 (str.from_int eeb5))
                           (= eeb1 (+ eeb4 (exp 10 eee11)))
                           (= eeb2 (str.len x))
                           (= eeb4 (str.to.int x))
                           (= eeb5 (+ eeb8 (* 999 (exp 10 eeb2))))
                           (= eeb8 (str.to.int x))
                           (= (exp 10 u9) (str.to.int y)))
  iter(1)= (and
             (and
               (= (+ (* (- 1) u9) (* 1 eee11) (* (- 1) eeb2)) 0))
             (and
               (= (+ (* (- 1) eeb1) (* 1 %0)) 0))
             (and
               (= (+ (* (- 1) eeb5) (* 1 %0)) 0))
             (and
               (= (+ (* (- 1) (exp 10 eee11)) (* (- 1) eeb4) (* 1 eeb1)) 0))
             (and
               (= (+ (* 1 eeb2) (* (- 1) %2)) 0)
               (= %3 (chrob.len x))
               (= (+ (* 1 (exp 10 %2)) (* (- 1) %3)) 1))
             (and
               (= eeb4 (str.to.int x)))
             (and
               (= (+ (* (- 999) (exp 10 eeb2)) (* (- 1) eeb8) (* 1 eeb5)) 0))
             (and
               (= eeb8 (str.to.int x)))
             (and
               (= (+ (* 1 (exp 10 u9)) (* (- 1) y)) 0)))
  iter(2)= (and
             (= %3 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= eeb8 (str.to.int x))
             (= (+ %0 (* (- 1) eeb1)) 0)
             (= (+ %0 (* (- 1) eeb5)) 0)
             (= (+ eeb1 (* (- 1) eeb4) (* (- 1) (exp 10 eee11))) 0)
             (= (+ eeb2 (* (- 1) %2)) 0)
             (= (+ eeb5 (* (- 999) (exp 10 eeb2)) (* (- 1) eeb8)) 0)
             (= (+ eee11 (* (- 1) eeb2) (* (- 1) u9)) 0)
             (= (+ (* (- 1) %3) (exp 10 %2)) 1)
             (= (+ (* (- 1) y) (exp 10 u9)) 0))
  Something ready to substitute
        %0 -> eeb1
        eeb1 -> (+ (* (- eeb4) (- 1)) (* (* (- 1) (exp 10 eee11)) (- 1)))
        eeb2 -> %2
        eeb5 -> (+ (* (* (- 999) (exp 10 %2)) (- 1)) (* (- eeb8) (- 1)))
        y -> (exp 10 u9)
  
  iter(3)= (and
             (= %3 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= eeb8 (str.to.int x))
             (= (+ %0 (* (- 1) eeb1)) 0)
             (= (+ %0 (* (- 1) eeb5)) 0)
             (= (+ eeb1 (* (- 1) eeb4) (* (- 1) (exp 10 eee11))) 0)
             (= (+ eeb2 (* (- 1) %2)) 0)
             (= (+ eeb5 (* (- 999) (exp 10 eeb2)) (* (- 1) eeb8)) 0)
             (= (+ eee11 (* (- 1) eeb2) (* (- 1) u9)) 0)
             (= (+ (* (- 1) %3) (exp 10 %2)) 1)
             (= (+ (* (- 1) y) (exp 10 u9)) 0))
  iter(4)= (and
             (= %3 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= eeb8 (str.to.int x))
             (= (+ eeb1 (* (* (* (- 999) (exp 10 %2)) (- 1)) (- 1))
                (* (* (* (- 1) eeb8) (- 1)) (- 1))) 0)
             (= (+ eeb1 (* (* (* (- 1) eeb4) (- 1)) (- 1))
                (* (* (* (- 1) (exp 10 eee11)) (- 1)) (- 1))) 0)
             (= (+ eee11 (* (- 1) %2) (* (- 1) u9)) 0)
             (= (+ (* (- 999) (exp 10 %2)) (* (- 1) eeb8)
                (* (* (- 999) (exp 10 %2)) (- 1)) (* (* (- 1) eeb8) (- 1))) 0)
             (= (+ (* (- 1) %3) (exp 10 %2)) 1)
             (= (+ (* (- 1) eeb4) (* (- 1) (exp 10 eee11))
                (* (* (- 1) eeb4) (- 1)) (* (* (- 1) (exp 10 eee11)) (- 1))) 0))
  Something ready to substitute
        %0 -> eeb1
        eeb1 -> (+ (* (- eeb4) (- 1)) (* (* (- 1) (exp 10 eee11)) (- 1)))
        eeb2 -> %2
        eeb5 -> (+ (* (* (- 999) (exp 10 %2)) (- 1)) (* (- eeb8) (- 1)))
        u9 -> (+ eee11 (- %2))
        y -> (exp 10 u9)
  
  iter(5)= (and
             (= %3 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= eeb8 (str.to.int x))
             (= (+ eee11 (* (- 1) %2) (* (- 1) u9)) 0)
             (= (+ (* (- 999) (exp 10 %2)) (* (- 1) eeb8)
                (* (* (- 1) eeb4) (- 1)) (* (* (- 1) (exp 10 eee11)) (- 1))) 0)
             (= (+ (* (- 1) %3) (exp 10 %2)) 1)
             (= (+ (* (- 1) eeb4) (* (- 1) (exp 10 eee11))
                (* (* (- 1) eeb4) (- 1)) (* (* (- 1) (exp 10 eee11)) (- 1))) 0)
             (= (+ (* (- 1) (exp 10 eee11)) (exp 10 eee11)) 0))
  Something ready to substitute
        %0 -> eeb1
        eeb1 -> (+ (* (- eeb4) (- 1)) (* (* (- 1) (exp 10 eee11)) (- 1)))
        eeb2 -> %2
        eeb5 -> (+ (* (* (- 999) (exp 10 %2)) (- 1)) (* (- eeb8) (- 1)))
        eeb8 -> (+ (* (- 999) (exp 10 %2)) (* (- eeb4) (- 1))
                (* (* (- 1) (exp 10 eee11)) (- 1)))
        u9 -> (+ eee11 (- %2))
        y -> (exp 10 u9)
  
  iter(6)= (and
             (= %3 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= eeb8 (str.to.int x))
             (= (+ eeb4 (* (- 999) (exp 10 %2)) (* (- 1) eeb8) (exp 10 eee11)) 0)
             (= (+ eee11 (* eee11 (- 1)) (* (- 1) %2) (* (* (- 1) %2) (- 1))) 0)
             (= (+ (* (- 1) %3) (exp 10 %2)) 1)
             (= (+ (* (- 1) (exp 10 eee11)) (exp 10 eee11)) 0))
  iter(7)= (and
             (= %3 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= (+ eeb4 (* (- 999) (exp 10 %2))
                (* (* (- 999) (exp 10 %2)) (- 1))
                (* (* (* (- 1) eeb4) (- 1)) (- 1))
                (* (* (* (- 1) (exp 10 eee11)) (- 1)) (- 1)) (exp 10 eee11)) 0)
             (= (+ (* (- 999) (exp 10 %2)) (* (* (- 1) eeb4) (- 1))
                (* (* (- 1) (exp 10 eee11)) (- 1))) (str.to.int x))
             (= (+ (* (- 1) %3) (exp 10 %2)) 1))
  iter(8)= (and
             (= %3 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= (+ eeb4 (* (- 999) (exp 10 %2)) (exp 10 eee11)) (str.to.int x))
             (= (+ (* (- 1) %3) (exp 10 %2)) 1))
  Simplify step: ((= %3 (chrob.len x)) & (= eeb4 (str.to.int x)) & (= (+ eeb4
                                                                      (* (- 999)
                                                                      (exp 10 %2))
                                                                      (exp 10 eee11)) (str.to.int x)) &
  (= (+ (* (- 1) %3) (exp 10 %2)) 1))
  Simplified expression: (and
                           (= %3 (chrob.len x))
                           (= eeb4 (str.to.int x))
                           (= (+ eeb4 (* (- 999) (exp 10 %2)) (exp 10 eee11)) (str.to.int x))
                           (= (+ (* (- 1) %3) (exp 10 %2)) 1))
  (assert (exists (x)
          (and
            (exists (eeb4)
            (and
              (= eeb4 (chrob.to.int x))
              (= (+ eeb4 (* (- 1) x) (* (- 999) pow2(%2)) pow2(eee11) )  0)
              )
  
            (exists (%3)
            (and
              (= %3 (chrob.len x))
              (= (+ (* (- 1) %3) pow2(%2) )  1)
              )
  
            )
  )
  $ unset CHRO_DEBUG
  $ timeout 5 Chro -pre-simpl -dsimpl strings3.smt2 -flat 0 -under3 -amin 0 -amax 1 | sed 's/[[:space:]]*$//'
  unknown
  ; Under2 resigns
  (assert (exists (x)
          (and
            (exists (eeb4)
            (and
              (= eeb4 (chrob.to.int x))
              (= (+ eeb4 (* (- 1) x) (* (- 999) pow2(%2)) pow2(eee11) )  0)
              )
  
            (exists (%3)
            (and
              (= %3 (chrob.len x))
              (= (+ (* (- 1) %3) pow2(%2) )  1)
              )
  
            )
  )
  sat ; under III
