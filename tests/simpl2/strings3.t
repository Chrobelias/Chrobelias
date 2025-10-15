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
  Something ready to substitute:  eeb1 ->s eeb5; eeb2 -> (str.len x); eeb3 ->
                                 999; eeb4 -> (str.to.int x); eeb6 -> (str.len x); eeb7 ->
                                 (str.to.int y); eeb8 -> (str.to.int x);
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb3 999)
             (= eeb4 (str.to.int x))
             (= eeb6 (str.len x))
             (= eeb7 (str.to.int y))
             (= eeb8 (str.to.int x))
             (= eeb1 eeb5)
             (= eeb1 (+ eeb4 (* eeb3 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6)))))
  Substitute eeb3 ~~> 999
  Substitute eeb1 ~~> eeb5
  Substitute eeb3 ~~> 999
  Substitute eeb1 ~~> eeb5
  iter(3)= (and
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6))))
             (= (+ eeb8 (* eeb7 (exp 10 eeb6))) (+ eeb4 (* 999 (exp 10 eeb2)))))
  iter(4)= (and
             (= (+ eeb8 (* eeb7 (exp 10 eeb6)) (* (- 999) (exp 10 eeb2))
                (* (- 1) eeb4)) 0)
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6)))))
  vars_for_under2: eeb7
  
  all as: 0 1
  
  Substitute eeb7 ~~> (+ (exp 10 u9) 0)
  Substitute eeb7 ~~> (+ (exp 10 u9) 0)
  Substitute eeb7 ~~> (+ (exp 10 u10) 1)
  Substitute eeb7 ~~> (+ (exp 10 u10) 1)
  iter(1)= (and
             (= eeb5 (+ eeb8 (* 0 (exp 10 eeb6)) (* (exp 10 u9) (exp 10 eeb6))))
             (= (+ eeb8 (* (- 999) (exp 10 eeb2)) (* (- 1) eeb4)
                (* 0 (exp 10 eeb6)) (* (exp 10 u9) (exp 10 eeb6))) 0))
  Something ready to substitute:  eeb8 -> (+ (* (* (- 999) (exp 10 eeb2))
                                             (- 1))
                                          (* (* (- 1) eeb4) (- 1))
                                          (* (exp 10 (+ u9 eeb6)) (- 1)));
  iter(2)= (and
             (= (+ eeb8 (* (- 999) (exp 10 eeb2)) (* (- 1) eeb4)
                (exp 10 (+ u9 eeb6))) 0)
             (= eeb5 (+ eeb8 (exp 10 (+ u9 eeb6)))))
  Substitute eeb8 ~~> (+ (* (* (- 999) (exp 10 eeb2)) (- 1))
                      (* (* (- 1) eeb4) (- 1)) (* (exp 10 (+ u9 eeb6)) (- 1)))
  Substitute eeb8 ~~> (+ (* (* (- 999) (exp 10 eeb2)) (- 1))
                      (* (* (- 1) eeb4) (- 1)) (* (exp 10 (+ u9 eeb6)) (- 1)))
  iter(3)= (and
             (= (+ (* (- 999) (exp 10 eeb2)) (* (- 1) eeb4)
                (* (* (- 999) (exp 10 eeb2)) (- 1)) (* (* (- 1) eeb4) (- 1))
                (* (exp 10 (+ u9 eeb6)) (- 1)) (exp 10 (+ eeb6 u9))) 0)
             (= eeb5 (+ (* (* (- 999) (exp 10 eeb2)) (- 1))
                     (* (* (- 1) eeb4) (- 1)) (* (exp 10 (+ u9 eeb6)) (- 1))
                     (exp 10 (+ eeb6 u9)))))
  iter(4)= (and
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2)))))
  iter(5)= (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
  iter(1)= (and
             (= eeb5 (+ eeb8 (* 1 (exp 10 eeb6))
                     (* (exp 10 u10) (exp 10 eeb6))))
             (= (+ eeb8 (* (- 999) (exp 10 eeb2)) (* (- 1) eeb4)
                (* 1 (exp 10 eeb6)) (* (exp 10 u10) (exp 10 eeb6))) 0))
  Something ready to substitute:  eeb8 -> (+ (* (* (- 999) (exp 10 eeb2))
                                             (- 1))
                                          (* (* (- 1) eeb4) (- 1))
                                          (* (exp 10 eeb6) (- 1))
                                          (* (exp 10 (+ u10 eeb6)) (- 1)));
  iter(2)= (and
             (= (+ eeb8 (* (- 999) (exp 10 eeb2)) (* (- 1) eeb4) (exp 10 eeb6)
                (exp 10 (+ u10 eeb6))) 0)
             (= eeb5 (+ eeb8 (exp 10 eeb6) (exp 10 (+ u10 eeb6)))))
  Substitute eeb8 ~~> (+ (* (* (- 999) (exp 10 eeb2)) (- 1))
                      (* (* (- 1) eeb4) (- 1)) (* (exp 10 eeb6) (- 1))
                      (* (exp 10 (+ u10 eeb6)) (- 1)))
  Substitute eeb8 ~~> (+ (* (* (- 999) (exp 10 eeb2)) (- 1))
                      (* (* (- 1) eeb4) (- 1)) (* (exp 10 eeb6) (- 1))
                      (* (exp 10 (+ u10 eeb6)) (- 1)))
  iter(3)= (and
             (= (+ (* (- 999) (exp 10 eeb2)) (* (- 1) eeb4)
                (* (* (- 999) (exp 10 eeb2)) (- 1)) (* (* (- 1) eeb4) (- 1))
                (* (exp 10 eeb6) (- 1)) (* (exp 10 (+ u10 eeb6)) (- 1))
                (exp 10 eeb6) (exp 10 (+ eeb6 u10))) 0)
             (= eeb5 (+ (* (* (- 999) (exp 10 eeb2)) (- 1))
                     (* (* (- 1) eeb4) (- 1)) (* (exp 10 eeb6) (- 1))
                     (* (exp 10 (+ u10 eeb6)) (- 1)) (exp 10 eeb6)
                     (exp 10 (+ eeb6 u10)))))
  iter(4)= (and
             (= (+ (* (- 1) (exp 10 (+ eeb6 u10))) (exp 10 (+ eeb6 u10))) 0)
             (= eeb5 (+ eeb4 (* (- 1) (exp 10 (+ eeb6 u10)))
                     (* 999 (exp 10 eeb2)) (exp 10 (+ eeb6 u10)))))
  iter(5)= (and
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2)))))
  iter(6)= (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
  (= (str.++ "999" x) (str.++ y x))
  Looking for SAT in 2 asts...
  Simplify step: (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
  Simplify step: (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
  Simplified expression: (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
  iter(1)= (and
             (= (+ (* (- 999) (exp 10 eeb2)) (* 1 eeb5) (* (- 1) eeb4)) 0))
  Something ready to substitute:  eeb5 -> (+ (* (* (- 999) (exp 10 eeb2))
                                             (- 1))
                                          (* (* (- 1) eeb4) (- 1)));
  iter(2)= (= (+ eeb5 (* (- 999) (exp 10 eeb2)) (* (- 1) eeb4)) 0)
  Substitute eeb5 ~~> (+ (* (* (- 999) (exp 10 eeb2)) (- 1))
                      (* (* (- 1) eeb4) (- 1)))
  iter(3)= (= (+ (* (- 999) (exp 10 eeb2)) (* (- 1) eeb4)
              (* (* (- 999) (exp 10 eeb2)) (- 1)) (* (* (- 1) eeb4) (- 1))) 0)
  iter(4)= True
  sat ; under III
  $ unset CHRO_DEBUG
  $ timeout 5 Chro -pre-simpl -dsimpl strings3.smt2 -flat 0 -under3 -amin 0 -amax 1
  unknown
  ; Under2 resigns
  sat ; under III
