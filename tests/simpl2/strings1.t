  $ export CHRO_DEBUG=1
  $ cat > 1.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x String)
  > (declare-const y String)
  > (assert (= (str.++ "999" x) (str.++ y x)))
  > (check-sat)
  > EOF

  $ Chro -pre-simpl -dpresimpl -dsimpl -stop-after simpl 1.smt2 -flat 1 -under3 -amin 2 -amax 2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= (str.++ "999" x) (str.++ y x)))
  iter(2)= (= (str.++ "999" x) (str.++ y x))
  vars_for_under2:
  
  all as: 2
  
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
  
  all as: 2
  
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (* 2 (exp 10 eeb2))
                     (* (* (- 1) (exp 10 v10)) (exp 10 eeb2))
                     (* (exp 10 u9) (exp 10 eeb2))))
             (= eeb8 (str.to.int x))
             (= (+ (exp 10 u9) (* (- 1) (exp 10 v10)) 2) (str.to.int y))
             (<= v10 u9))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (* (- 1) (exp 10 eeb2) (exp 10 v10))
                     (* 2 (exp 10 eeb2)) (exp 10 (+ u9 eeb2))))
             (= eeb8 (str.to.int x))
             (= (+ 2 (* (- 1) (exp 10 v10)) (exp 10 u9)) (str.to.int y))
             (<= v10 u9))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (* (- 1) (exp 10 (+ eeb2 v10)))
                     (* 2 (exp 10 eeb2)) (exp 10 (+ eeb2 u9))))
             (= eeb8 (str.to.int x))
             (= (+ 2 (* (- 1) (exp 10 v10)) (exp 10 u9)) (str.to.int y))
             (<= v10 u9))
  (= (str.++ "999" x) (str.++ y x))
  Looking for SAT in 1 asts...
  Simplify step: ((= eee12 (+ eeb2 u9)) & (= eee11 (+ eeb2 v10)) & (= eeb2 (str.len x)) & (= eeb4 (str.to.int x)) & (= eeb5
  (+ eeb4 (* 999 (exp 10 eeb2)))) & (= eeb5 (+ eeb8 (* (- 1) (exp 10 eee11))
                                            (* 2 (exp 10 eeb2)) (exp 10 eee12))) & (= eeb8 (str.to.int x)) & (=
  (+ 2 (* (- 1) (exp 10 v10)) (exp 10 u9)) (str.to.int y)) & (<= v10 u9))
  Simplified expression: (and
                           (= eee12 (+ eeb2 u9))
                           (= eee11 (+ eeb2 v10))
                           (= eeb2 (str.len x))
                           (= eeb4 (str.to.int x))
                           (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
                           (= eeb5 (+ eeb8 (* (- 1) (exp 10 eee11))
                                   (* 2 (exp 10 eeb2)) (exp 10 eee12)))
                           (= eeb8 (str.to.int x))
                           (= (+ 2 (* (- 1) (exp 10 v10)) (exp 10 u9)) (str.to.int y))
                           (<= v10 u9))
  iter(1)= (and
             (and
               (= (+ (* (- 1) u9) (* 1 eee12) (* (- 1) eeb2)) 0))
             (and
               (= (+ (* (- 1) v10) (* 1 eee11) (* (- 1) eeb2)) 0))
             (and
               (= (+ (* 1 eeb2) (* (- 1) %0)) 0)
               (= %1 (chrob.len x))
               (= (+ (* 1 (exp 10 %0)) (* (- 1) %1)) 1))
             (and
               (= eeb4 (str.to.int x)))
             (and
               (= (+ (* (- 999) (exp 10 eeb2)) (* 1 eeb5) (* (- 1) eeb4)) 0))
             (and
               (= (+ (* (- 1) (exp 10 eee12)) (* 1 (exp 10 eee11))
                  (* (- 2) (exp 10 eeb2)) (* (- 1) eeb8) (* 1 eeb5)) 0))
             (and
               (= eeb8 (str.to.int x)))
             (and
               (= (+ (* (- 1) (exp 10 v10)) (* 1 (exp 10 u9)) (* (- 1) y)) (- 2)))
             (and
               (<= (+ (* 1 v10) (* (- 1) u9)) 0)))
  iter(2)= (and
             (= %1 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= eeb8 (str.to.int x))
             (= (+ eeb2 (* (- 1) %0)) 0)
             (= (+ eeb5 (* (- 999) (exp 10 eeb2)) (* (- 1) eeb4)) 0)
             (= (+ eeb5 (* (- 2) (exp 10 eeb2)) (* (- 1) eeb8)
                (* (- 1) (exp 10 eee12)) (exp 10 eee11)) 0)
             (= (+ eee11 (* (- 1) eeb2) (* (- 1) v10)) 0)
             (= (+ eee12 (* (- 1) eeb2) (* (- 1) u9)) 0)
             (= (+ (* (- 1) %1) (exp 10 %0)) 1)
             (= (+ (* (- 1) y) (* (- 1) (exp 10 v10)) (exp 10 u9)) (- 2))
             (<= (+ v10 (* (- 1) u9)) 0))
  Something ready to substitute:  eeb2 -> %0; eeb5 -> (+ (* (* (- 999)
                                                            (exp 10 %0))
                                                         (- 1))
                                                      (* (* (- 1) eeb4) (- 1)));
  iter(3)= (and
             (= %1 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= eeb8 (str.to.int x))
             (= (+ eeb2 (* (- 1) %0)) 0)
             (= (+ eeb5 (* (- 999) (exp 10 eeb2)) (* (- 1) eeb4)) 0)
             (= (+ eeb5 (* (- 2) (exp 10 eeb2)) (* (- 1) eeb8)
                (* (- 1) (exp 10 eee12)) (exp 10 eee11)) 0)
             (= (+ eee11 (* (- 1) eeb2) (* (- 1) v10)) 0)
             (= (+ eee12 (* (- 1) eeb2) (* (- 1) u9)) 0)
             (= (+ (* (- 1) %1) (exp 10 %0)) 1)
             (= (+ (* (- 1) y) (* (- 1) (exp 10 v10)) (exp 10 u9)) (- 2))
             (<= (+ v10 (* (- 1) u9)) 0))
  iter(4)= (and
             (= %1 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= eeb8 (str.to.int x))
             (= (+ eee11 (* (- 1) %0) (* (- 1) v10)) 0)
             (= (+ eee12 (* (- 1) %0) (* (- 1) u9)) 0)
             (= (+ (* (- 999) (exp 10 %0)) (* (- 1) eeb4)
                (* (* (- 999) (exp 10 %0)) (- 1)) (* (* (- 1) eeb4) (- 1))) 0)
             (= (+ (* (- 2) (exp 10 %0)) (* (- 1) eeb8)
                (* (- 1) (exp 10 eee12)) (* (* (- 999) (exp 10 %0)) (- 1))
                (* (* (- 1) eeb4) (- 1)) (exp 10 eee11)) 0)
             (= (+ (* (- 1) %1) (exp 10 %0)) 1)
             (= (+ (* (- 1) y) (* (- 1) (exp 10 v10)) (exp 10 u9)) (- 2))
             (<= (+ v10 (* (- 1) u9)) 0))
  Something ready to substitute:  eeb2 -> %0; eeb5 -> (+ (* (* (- 999)
                                                            (exp 10 %0))
                                                         (- 1))
                                                      (* (* (- 1) eeb4) (- 1))); eeb8 ->
                                 (+ (* (- 2) (exp 10 %0))
                                 (* (- 1) (exp 10 eee12))
                                 (* (* (- 999) (exp 10 %0)) (- 1))
                                 (* (* (- 1) eeb4) (- 1)) (exp 10 eee11));
  iter(5)= (and
             (= %1 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= eeb8 (str.to.int x))
             (= (+ eeb4 (* (- 1) eeb8) (* (- 1) (exp 10 eee12))
                (* 997 (exp 10 %0)) (exp 10 eee11)) 0)
             (= (+ eee11 (* (- 1) %0) (* (- 1) v10)) 0)
             (= (+ eee12 (* (- 1) %0) (* (- 1) u9)) 0)
             (= (+ (* (- 1) %1) (exp 10 %0)) 1)
             (= (+ (* (- 1) y) (* (- 1) (exp 10 v10)) (exp 10 u9)) (- 2))
             (<= (+ v10 (* (- 1) u9)) 0))
  iter(6)= (and
             (= %1 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= (+ eeb4 (* (- 1) (exp 10 eee12)) (* 997 (exp 10 %0))
                (* (* (- 2) (exp 10 %0)) (- 1))
                (* (* (- 1) (exp 10 eee12)) (- 1))
                (* (* (* (- 999) (exp 10 %0)) (- 1)) (- 1))
                (* (* (* (- 1) eeb4) (- 1)) (- 1)) (* (exp 10 eee11) (- 1))
                (exp 10 eee11)) 0)
             (= (+ eee11 (* (- 1) %0) (* (- 1) v10)) 0)
             (= (+ eee12 (* (- 1) %0) (* (- 1) u9)) 0)
             (= (+ (* (- 2) (exp 10 %0)) (* (- 1) (exp 10 eee12))
                (* (* (- 999) (exp 10 %0)) (- 1)) (* (* (- 1) eeb4) (- 1))
                (exp 10 eee11)) (str.to.int x))
             (= (+ (* (- 1) %1) (exp 10 %0)) 1)
             (= (+ (* (- 1) y) (* (- 1) (exp 10 v10)) (exp 10 u9)) (- 2))
             (<= (+ v10 (* (- 1) u9)) 0))
  iter(7)= (and
             (= %1 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= (+ eeb4 (* (- 1) (exp 10 eee12)) (* 997 (exp 10 %0))
                (exp 10 eee11)) (str.to.int x))
             (= (+ eee11 (* (- 1) %0) (* (- 1) v10)) 0)
             (= (+ eee12 (* (- 1) %0) (* (- 1) u9)) 0)
             (= (+ (* (- 1) %1) (exp 10 %0)) 1)
             (= (+ (* (- 1) y) (* (- 1) (exp 10 v10)) (exp 10 u9)) (- 2))
             (<= (+ v10 (* (- 1) u9)) 0))
  Simplify step: ((= %1 (chrob.len x)) & (= eeb4 (str.to.int x)) & (= (+ eeb4
                                                                      (* (- 1)
                                                                      (exp 10 eee12))
                                                                      (* 997
                                                                      (exp 10 %0))
                                                                      (exp 10 eee11)) (str.to.int x)) & (=
  (+ eee11 (* (- 1) %0) (* (- 1) v10)) 0) & (= (+ eee12 (* (- 1) %0)
                                               (* (- 1) u9)) 0) & (= (+
                                                                     (* (- 1)
                                                                     %1)
                                                                     (exp 10 %0)) 1) & (=
  (+ (* (- 1) y) (* (- 1) (exp 10 v10)) (exp 10 u9)) (- 2)) & (<= (exp 10 v10) (exp 10 u9)))
  Simplified expression: (and
                           (= %1 (chrob.len x))
                           (= eeb4 (str.to.int x))
                           (= (+ eeb4 (* (- 1) (exp 10 eee12))
                              (* 997 (exp 10 %0)) (exp 10 eee11)) (str.to.int x))
                           (= (+ eee11 (* (- 1) %0) (* (- 1) v10)) 0)
                           (= (+ eee12 (* (- 1) %0) (* (- 1) u9)) 0)
                           (= (+ (* (- 1) %1) (exp 10 %0)) 1)
                           (= (+ (* (- 1) y) (* (- 1) (exp 10 v10))
                              (exp 10 u9)) (- 2))
                           (<= (exp 10 v10) (exp 10 u9)))
  (assert (exists (x)
          (and
            (exists (eeb4)
            (and
              (= eeb4 (chrob.to.int x))(= (+ eeb4 (* (- 1) x) (* 997 pow2(%0))
                                          pow2(eee11) (* (- 1) pow2(eee12)) )
                                        0)
              )
            (exists (%1)
            (and
              (= %1 (chrob.len x))(= (+ (* (- 1) %1) pow2(%0) )  1)
              )
            (exists (y) (= (+ (* (- 1) y) pow2(u9) (* (- 1) pow2(v10)) )  -2) )
            (= (+ (* (- 1) %0) eee11 (* (- 1) v10) )  0)
            (= (+ (* (- 1) %0) eee12 (* (- 1) u9) )  0)
            (<= (+ (* (- 1) pow2(u9)) pow2(v10) )  0)
            )
  )
