  $ export CHRO_DEBUG=1
  $ cat > 1.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x String)
  > (declare-const y String)
  > (assert (= (str.++ "999" x) (str.++ y x)))
  > (check-sat)
  > EOF

  $ Chro -pre-simpl -dpresimpl -dsimpl -stop-after simpl 1.smt2 -flat 1 -under3 -bmax 2 | sed 's/[[:space:]]*$//'
  strlen data:
  
  After strlen lowering:
  (and
    (= (str.++ "999" x) (str.++ y x)))
  
  iter(1)= (and
             (= (str.++ "999" x) (str.++ y x)))
  iter(2)= (= (str.++ "999" x) (str.++ y x))
  vars_for_under2:
  
  iter(0)= (and
             (= (str.++ "999" x) (str.++ y x)))
  iter(1)= (= (str.++ "999" x) (str.++ y x))
  run_underapprox2: Before strlen lowering:
  (and
    (= (str.++ "999" x) (str.++ y x)))
  
  strlen data:
  
  run_underapprox2: After strlen lowering:
  (and
    (= (str.++ "999" x) (str.++ y x)))
  
  iter(1)= (and
             (= (str.++ "999" x) (str.++ y x)))
  iter(2)= (= (str.++ "999" x) (str.++ y x))
  (= (str.++ "999" x) (str.++ y x))
  Looking for SAT in 1 asts...
  Simplify step: (= (str.++ "999" x) (str.++ y x))
  Simplify step: (= (str.++ "999" x) (str.++ y x))
  Simplified expression: (= (str.++ "999" x) (str.++ y x))
  unknown
  ; Under2 resigns
  strlen data:
  (str.len x) ~~> [eeb2,eeb6]
  (str.to.int x) ~~> [eeb4,eeb8]
  (str.to.int y) ~~> [eeb7]
  
  After strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb7 (str.to.int y))
    (= eeb6 eeb2)
    (= eeb5 (+ (* eeb7 (exp 10 eeb6)) eeb8))
    (= eeb8 eeb4)
    (= eeb7 eeb7)
    (= eeb2 eeb2)
    (= eeb1 (+ (* eeb3 (exp 10 eeb2)) eeb4))
    (= eeb4 eeb4)
    (= eeb3 999)
    (= (str.from_int eeb1) (str.from_int eeb5)))
  
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb7 (str.to.int y))
             (= eeb6 eeb2)
             (= eeb5 (+ (* eeb7 (exp 10 eeb6)) eeb8))
             (= eeb8 eeb4)
             (= eeb7 eeb7)
             (= eeb2 eeb2)
             (= eeb1 (+ (* eeb3 (exp 10 eeb2)) eeb4))
             (= eeb4 eeb4)
             (= eeb3 999)
             (= (str.from_int eeb1) (str.from_int eeb5)))
  Something ready to substitute:  eeb3 -> 999; eeb6 -> eeb2; eeb8 -> eeb4;
  iter(2)= (and
             (= eeb1 (+ eeb4 (* eeb3 (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb3 999)
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6))))
             (= eeb6 eeb2)
             (= eeb7 (str.to.int y))
             (= eeb8 eeb4)
             (= eeb1 eeb5))
  Something ready to substitute:  eeb1 ->s eeb5; eeb3 -> 999; eeb6 -> eeb2; eeb8 ->
                                 eeb4;
  iter(3)= (and
             (= eeb1 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* eeb7 (exp 10 eeb2))))
             (= eeb7 (str.to.int y))
             (= eeb1 eeb5))
  iter(4)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* eeb7 (exp 10 eeb2))))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= eeb7 (str.to.int y)))
  vars_for_under2: eeb7
  
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 1
                                   (* (+ (* 1 (exp 10 u0))
                                      (* 1 (* (- 1) (exp 10 u1))))
                                   (exp 10 0)))
                                (* 9 0))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9
                  (+ (* 1
                     (* (+ (* 1 (exp 10 u0)) (* 1 (* (- 1) (exp 10 u1))))
                     (exp 10 0)))
                  (* 9 0))) (* 9 (str.to.int y))))
             (<= (* 1 (* 1 u1)) (* 1 (* 1 u0)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u1))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* (* (* (* (- 1) (exp 10 u1)) 1) 1) 9)
                (* (* (* (exp 10 u0) 1) 1) 9)) (* 9 (str.to.int y)))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9)
                           (* (* (* (* (* (* (- 1) (exp 10 u1)) 1) 1)
                                 (exp 10 eeb2))
                              1)
                           9)
                           (* (* (* (* (* (exp 10 u0) 1) 1) (exp 10 eeb2)) 1)
                           9)))
             (<= u1 u0)
             (<= 0 u1))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 1) (exp 10 eeb2) (exp 10 u1))
                (* 1 (exp 10 (+ u0 eeb2))) (* 9 eeb4)) (* 1 eeb5))
             (= (+ (* (- 1) (exp 10 u1)) (* 1 (exp 10 u0))) (* 1
                                                            (str.to.int y)))
             (<= u1 u0)
             (<= 0 u1))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 1) (exp 10 u1)) (exp 10 u0)) (str.to.int y))
             (= (+ (* (- 1) (exp 10 (+ eeb2 u1))) (* 9 eeb4)
                (exp 10 (+ eeb2 u0))) eeb5)
             (<= u1 u0)
             (<= 0 u1))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ (* (- 1) (exp 10 u1)) (exp 10 u0)) (str.to.int y))
    (= (+ (* (- 1) (exp 10 (+ eeb2 u1))) (* 9 eeb4) (exp 10 (+ eeb2 u0))) eeb5)
    (<= u1 u0)
    (<= 0 u1))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %0 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ (* (- 1) (exp 10 u1)) (exp 10 u0)) %0)
    (= (+ (* (- 1) (exp 10 (+ eeb2 u1))) (* 9 eeb4) (exp 10 (+ eeb2 u0))) eeb5)
    (<= u1 u0)
    (<= 0 u1))
  
  iter(1)= (and
             (= %0 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 1) (exp 10 u1)) (exp 10 u0)) %0)
             (= (+ (* (- 1) (exp 10 (+ eeb2 u1))) (* 9 eeb4)
                (exp 10 (+ eeb2 u0))) eeb5)
             (<= u1 u0)
             (<= 0 u1))
  iter(2)= (and
             (= %0 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 1) (exp 10 u1)) (exp 10 u0)) %0)
             (= (+ (* (- 1) (exp 10 (+ eeb2 u1))) (* 9 eeb4)
                (exp 10 (+ eeb2 u0))) eeb5)
             (<= u1 u0)
             (<= 0 u1))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 1
                                   (* (+ (* 1 (exp 10 u2))
                                      (* 1 (* (- 1) (exp 10 u3))))
                                   (exp 10 1)))
                                (* 9 1))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9
                  (+ (* 1
                     (* (+ (* 1 (exp 10 u2)) (* 1 (* (- 1) (exp 10 u3))))
                     (exp 10 1)))
                  (* 9 1))) (* 9 (str.to.int y))))
             (<= (* 1 (* 1 u3)) (* 1 (* 1 u2)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u3))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 9 9) (* (* (* (* (- 1) (exp 10 u3)) 10) 1) 9)
                (* (* (* (exp 10 u2) 10) 1) 9)) (* 9 (str.to.int y)))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9) (* (* (* 9 (exp 10 eeb2)) 1) 9)
                           (* (* (* (* (* (* (- 1) (exp 10 u3)) 10) 1)
                                 (exp 10 eeb2))
                              1)
                           9)
                           (* (* (* (* (* (exp 10 u2) 10) 1) (exp 10 eeb2)) 1)
                           9)))
             (<= u3 u2)
             (<= 0 u3))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 10) (exp 10 u3)) (* 10 (exp 10 u2))) (* 1
                                                                (str.to.int y)))
             (= (+ (* (- 10) (exp 10 eeb2) (exp 10 u3)) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 10 (exp 10 eeb2) (exp 10 u2))) (* 1
                                                                      eeb5))
             (<= u3 u2)
             (<= 0 u3))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 10) (exp 10 u3)) (* 10 (exp 10 u2))) (str.to.int y))
             (= (+ (* (- 10) (exp 10 (+ eeb2 u3))) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 10 (exp 10 (+ eeb2 u2)))) eeb5)
             (<= u3 u2)
             (<= 0 u3))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 10) (exp 10 u3)) (* 10 (exp 10 u2))) (str.to.int y))
    (= (+ (* (- 10) (exp 10 (+ eeb2 u3))) (* 9 eeb4) (* 9 (exp 10 eeb2))
       (* 10 (exp 10 (+ eeb2 u2)))) eeb5)
    (<= u3 u2)
    (<= 0 u3))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %1 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 10) (exp 10 u3)) (* 10 (exp 10 u2))) %1)
    (= (+ (* (- 10) (exp 10 (+ eeb2 u3))) (* 9 eeb4) (* 9 (exp 10 eeb2))
       (* 10 (exp 10 (+ eeb2 u2)))) eeb5)
    (<= u3 u2)
    (<= 0 u3))
  
  iter(1)= (and
             (= %1 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 10) (exp 10 u3)) (* 10 (exp 10 u2))) %1)
             (= (+ (* (- 10) (exp 10 (+ eeb2 u3))) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 10 (exp 10 (+ eeb2 u2)))) eeb5)
             (<= u3 u2)
             (<= 0 u3))
  iter(2)= (and
             (= %1 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 10) (exp 10 u3)) (* 10 (exp 10 u2))) %1)
             (= (+ (* (- 10) (exp 10 (+ eeb2 u3))) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 10 (exp 10 (+ eeb2 u2)))) eeb5)
             (<= u3 u2)
             (<= 0 u3))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 1
                                   (* (+ (* 1 (exp 10 u4))
                                      (* 1 (* (- 1) (exp 10 u5))))
                                   (exp 10 1)))
                                (* 9 2))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9
                  (+ (* 1
                     (* (+ (* 1 (exp 10 u4)) (* 1 (* (- 1) (exp 10 u5))))
                     (exp 10 1)))
                  (* 9 2))) (* 9 (str.to.int y))))
             (<= (* 1 (* 1 u5)) (* 1 (* 1 u4)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u5))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 18 9) (* (* (* (* (- 1) (exp 10 u5)) 10) 1) 9)
                (* (* (* (exp 10 u4) 10) 1) 9)) (* 9 (str.to.int y)))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9) (* (* (* 18 (exp 10 eeb2)) 1) 9)
                           (* (* (* (* (* (* (- 1) (exp 10 u5)) 10) 1)
                                 (exp 10 eeb2))
                              1)
                           9)
                           (* (* (* (* (* (exp 10 u4) 10) 1) (exp 10 eeb2)) 1)
                           9)))
             (<= u5 u4)
             (<= 0 u5))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 10) (exp 10 u5)) (* 10 (exp 10 u4))) (* 1
                                                                (str.to.int y)))
             (= (+ (* (- 10) (exp 10 eeb2) (exp 10 u5)) (* 9 eeb4)
                (* 10 (exp 10 eeb2) (exp 10 u4)) (* 18 (exp 10 eeb2)))
             (* 1 eeb5))
             (<= u5 u4)
             (<= 0 u5))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 10) (exp 10 u5)) (* 10 (exp 10 u4))) (str.to.int y))
             (= (+ (* (- 10) (exp 10 (+ eeb2 u5))) (* 9 eeb4)
                (* 10 (exp 10 (+ eeb2 u4))) (* 18 (exp 10 eeb2))) eeb5)
             (<= u5 u4)
             (<= 0 u5))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 10) (exp 10 u5)) (* 10 (exp 10 u4))) (str.to.int y))
    (= (+ (* (- 10) (exp 10 (+ eeb2 u5))) (* 9 eeb4)
       (* 10 (exp 10 (+ eeb2 u4))) (* 18 (exp 10 eeb2))) eeb5)
    (<= u5 u4)
    (<= 0 u5))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %2 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 10) (exp 10 u5)) (* 10 (exp 10 u4))) %2)
    (= (+ (* (- 10) (exp 10 (+ eeb2 u5))) (* 9 eeb4)
       (* 10 (exp 10 (+ eeb2 u4))) (* 18 (exp 10 eeb2))) eeb5)
    (<= u5 u4)
    (<= 0 u5))
  
  iter(1)= (and
             (= %2 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 10) (exp 10 u5)) (* 10 (exp 10 u4))) %2)
             (= (+ (* (- 10) (exp 10 (+ eeb2 u5))) (* 9 eeb4)
                (* 10 (exp 10 (+ eeb2 u4))) (* 18 (exp 10 eeb2))) eeb5)
             (<= u5 u4)
             (<= 0 u5))
  iter(2)= (and
             (= %2 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 10) (exp 10 u5)) (* 10 (exp 10 u4))) %2)
             (= (+ (* (- 10) (exp 10 (+ eeb2 u5))) (* 9 eeb4)
                (* 10 (exp 10 (+ eeb2 u4))) (* 18 (exp 10 eeb2))) eeb5)
             (<= u5 u4)
             (<= 0 u5))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 2
                                   (* (+ (* 1 (exp 10 u6))
                                      (* 1 (* (- 1) (exp 10 u7))))
                                   (exp 10 0)))
                                (* 9 0))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9
                  (+ (* 2
                     (* (+ (* 1 (exp 10 u6)) (* 1 (* (- 1) (exp 10 u7))))
                     (exp 10 0)))
                  (* 9 0))) (* 9 (str.to.int y))))
             (<= (* 1 (* 1 u7)) (* 1 (* 1 u6)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u7))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* (* (* (* (- 1) (exp 10 u7)) 1) 2) 9)
                (* (* (* (exp 10 u6) 1) 2) 9)) (* 9 (str.to.int y)))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9)
                           (* (* (* (* (* (* (- 1) (exp 10 u7)) 1) 2)
                                 (exp 10 eeb2))
                              1)
                           9)
                           (* (* (* (* (* (exp 10 u6) 1) 2) (exp 10 eeb2)) 1)
                           9)))
             (<= u7 u6)
             (<= 0 u7))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 2) (exp 10 eeb2) (exp 10 u7))
                (* 2 (exp 10 eeb2) (exp 10 u6)) (* 9 eeb4)) (* 1 eeb5))
             (= (+ (* (- 2) (exp 10 u7)) (* 2 (exp 10 u6))) (* 1
                                                            (str.to.int y)))
             (<= u7 u6)
             (<= 0 u7))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 2) (exp 10 u7)) (* 2 (exp 10 u6))) (str.to.int y))
             (= (+ (* (- 2) (exp 10 (+ eeb2 u7))) (* 2 (exp 10 (+ eeb2 u6)))
                (* 9 eeb4)) eeb5)
             (<= u7 u6)
             (<= 0 u7))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ (* (- 2) (exp 10 u7)) (* 2 (exp 10 u6))) (str.to.int y))
    (= (+ (* (- 2) (exp 10 (+ eeb2 u7))) (* 2 (exp 10 (+ eeb2 u6))) (* 9 eeb4)) eeb5)
    (<= u7 u6)
    (<= 0 u7))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %3 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ (* (- 2) (exp 10 u7)) (* 2 (exp 10 u6))) %3)
    (= (+ (* (- 2) (exp 10 (+ eeb2 u7))) (* 2 (exp 10 (+ eeb2 u6))) (* 9 eeb4)) eeb5)
    (<= u7 u6)
    (<= 0 u7))
  
  iter(1)= (and
             (= %3 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 2) (exp 10 u7)) (* 2 (exp 10 u6))) %3)
             (= (+ (* (- 2) (exp 10 (+ eeb2 u7))) (* 2 (exp 10 (+ eeb2 u6)))
                (* 9 eeb4)) eeb5)
             (<= u7 u6)
             (<= 0 u7))
  iter(2)= (and
             (= %3 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 2) (exp 10 u7)) (* 2 (exp 10 u6))) %3)
             (= (+ (* (- 2) (exp 10 (+ eeb2 u7))) (* 2 (exp 10 (+ eeb2 u6)))
                (* 9 eeb4)) eeb5)
             (<= u7 u6)
             (<= 0 u7))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 2
                                   (* (+ (* 1 (exp 10 u8))
                                      (* 1 (* (- 1) (exp 10 u9))))
                                   (exp 10 1)))
                                (* 9 1))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9
                  (+ (* 2
                     (* (+ (* 1 (exp 10 u8)) (* 1 (* (- 1) (exp 10 u9))))
                     (exp 10 1)))
                  (* 9 1))) (* 9 (str.to.int y))))
             (<= (* 1 (* 1 u9)) (* 1 (* 1 u8)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u9))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 9 9) (* (* (* (* (- 1) (exp 10 u9)) 10) 2) 9)
                (* (* (* (exp 10 u8) 10) 2) 9)) (* 9 (str.to.int y)))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9) (* (* (* 9 (exp 10 eeb2)) 1) 9)
                           (* (* (* (* (* (* (- 1) (exp 10 u9)) 10) 2)
                                 (exp 10 eeb2))
                              1)
                           9)
                           (* (* (* (* (* (exp 10 u8) 10) 2) (exp 10 eeb2)) 1)
                           9)))
             (<= u9 u8)
             (<= 0 u9))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 20) (exp 10 u9)) (* 20 (exp 10 u8))) (* 1
                                                                (str.to.int y)))
             (= (+ (* (- 20) (exp 10 eeb2) (exp 10 u9)) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 20 (exp 10 eeb2) (exp 10 u8))) (* 1
                                                                      eeb5))
             (<= u9 u8)
             (<= 0 u9))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 20) (exp 10 u9)) (* 20 (exp 10 u8))) (str.to.int y))
             (= (+ (* (- 20) (exp 10 (+ eeb2 u9))) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 20 (exp 10 (+ eeb2 u8)))) eeb5)
             (<= u9 u8)
             (<= 0 u9))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 20) (exp 10 u9)) (* 20 (exp 10 u8))) (str.to.int y))
    (= (+ (* (- 20) (exp 10 (+ eeb2 u9))) (* 9 eeb4) (* 9 (exp 10 eeb2))
       (* 20 (exp 10 (+ eeb2 u8)))) eeb5)
    (<= u9 u8)
    (<= 0 u9))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %4 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 20) (exp 10 u9)) (* 20 (exp 10 u8))) %4)
    (= (+ (* (- 20) (exp 10 (+ eeb2 u9))) (* 9 eeb4) (* 9 (exp 10 eeb2))
       (* 20 (exp 10 (+ eeb2 u8)))) eeb5)
    (<= u9 u8)
    (<= 0 u9))
  
  iter(1)= (and
             (= %4 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 20) (exp 10 u9)) (* 20 (exp 10 u8))) %4)
             (= (+ (* (- 20) (exp 10 (+ eeb2 u9))) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 20 (exp 10 (+ eeb2 u8)))) eeb5)
             (<= u9 u8)
             (<= 0 u9))
  iter(2)= (and
             (= %4 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 20) (exp 10 u9)) (* 20 (exp 10 u8))) %4)
             (= (+ (* (- 20) (exp 10 (+ eeb2 u9))) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 20 (exp 10 (+ eeb2 u8)))) eeb5)
             (<= u9 u8)
             (<= 0 u9))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 2
                                   (* (+ (* 1 (exp 10 u10))
                                      (* 1 (* (- 1) (exp 10 u11))))
                                   (exp 10 1)))
                                (* 9 2))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9
                  (+ (* 2
                     (* (+ (* 1 (exp 10 u10)) (* 1 (* (- 1) (exp 10 u11))))
                     (exp 10 1)))
                  (* 9 2))) (* 9 (str.to.int y))))
             (<= (* 1 (* 1 u11)) (* 1 (* 1 u10)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u11))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 18 9) (* (* (* (* (- 1) (exp 10 u11)) 10) 2) 9)
                (* (* (* (exp 10 u10) 10) 2) 9)) (* 9 (str.to.int y)))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9) (* (* (* 18 (exp 10 eeb2)) 1) 9)
                           (* (* (* (* (* (* (- 1) (exp 10 u11)) 10) 2)
                                 (exp 10 eeb2))
                              1)
                           9)
                           (* (* (* (* (* (exp 10 u10) 10) 2) (exp 10 eeb2)) 1)
                           9)))
             (<= u11 u10)
             (<= 0 u11))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 20) (exp 10 u11)) (* 20 (exp 10 u10))) (* 1
                                                                  (str.to.int y)))
             (= (+ (* (- 20) (exp 10 eeb2) (exp 10 u11)) (* 9 eeb4)
                (* 18 (exp 10 eeb2)) (* 20 (exp 10 eeb2) (exp 10 u10)))
             (* 1 eeb5))
             (<= u11 u10)
             (<= 0 u11))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 20) (exp 10 u11)) (* 20 (exp 10 u10))) (str.to.int y))
             (= (+ (* (- 20) (exp 10 (+ eeb2 u11))) (* 9 eeb4)
                (* 18 (exp 10 eeb2)) (* 20 (exp 10 (+ eeb2 u10)))) eeb5)
             (<= u11 u10)
             (<= 0 u11))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 20) (exp 10 u11)) (* 20 (exp 10 u10))) (str.to.int y))
    (= (+ (* (- 20) (exp 10 (+ eeb2 u11))) (* 9 eeb4) (* 18 (exp 10 eeb2))
       (* 20 (exp 10 (+ eeb2 u10)))) eeb5)
    (<= u11 u10)
    (<= 0 u11))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %5 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 20) (exp 10 u11)) (* 20 (exp 10 u10))) %5)
    (= (+ (* (- 20) (exp 10 (+ eeb2 u11))) (* 9 eeb4) (* 18 (exp 10 eeb2))
       (* 20 (exp 10 (+ eeb2 u10)))) eeb5)
    (<= u11 u10)
    (<= 0 u11))
  
  iter(1)= (and
             (= %5 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 20) (exp 10 u11)) (* 20 (exp 10 u10))) %5)
             (= (+ (* (- 20) (exp 10 (+ eeb2 u11))) (* 9 eeb4)
                (* 18 (exp 10 eeb2)) (* 20 (exp 10 (+ eeb2 u10)))) eeb5)
             (<= u11 u10)
             (<= 0 u11))
  iter(2)= (and
             (= %5 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 20) (exp 10 u11)) (* 20 (exp 10 u10))) %5)
             (= (+ (* (- 20) (exp 10 (+ eeb2 u11))) (* 9 eeb4)
                (* 18 (exp 10 eeb2)) (* 20 (exp 10 (+ eeb2 u10)))) eeb5)
             (<= u11 u10)
             (<= 0 u11))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 3 eeb5) (* 3
                             (+ (* 3 eeb4)
                             (* 1
                             (* (+ (* 1
                                   (* (+ (* 1 (exp 10 u12))
                                      (* 1 (* (- 1) (exp 10 u13))))
                                   (exp 10 0)))
                                (* 3 0))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 3
                  (+ (* 1
                     (* (+ (* 1 (exp 10 u12)) (* 1 (* (- 1) (exp 10 u13))))
                     (exp 10 0)))
                  (* 3 0))) (* 3 (str.to.int y))))
             (<= (* 1 (* 1 u13)) (* 1 (* 1 u12)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u13))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* (* (* (* (- 1) (exp 10 u13)) 1) 1) 3)
                (* (* (* (exp 10 u12) 1) 1) 3)) (* 3 (str.to.int y)))
             (= (* 3 eeb5) (+ (* (* 3 eeb4) 3)
                           (* (* (* (* (* (* (- 1) (exp 10 u13)) 1) 1)
                                 (exp 10 eeb2))
                              1)
                           3)
                           (* (* (* (* (* (exp 10 u12) 1) 1) (exp 10 eeb2)) 1)
                           3)))
             (<= u13 u12)
             (<= 0 u13))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 1) (exp 10 eeb2) (exp 10 u13))
                (* 1 (exp 10 (+ u12 eeb2))) (* 3 eeb4)) (* 1 eeb5))
             (= (+ (* (- 1) (exp 10 u13)) (* 1 (exp 10 u12))) (* 1
                                                              (str.to.int y)))
             (<= u13 u12)
             (<= 0 u13))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 1) (exp 10 u13)) (exp 10 u12)) (str.to.int y))
             (= (+ (* (- 1) (exp 10 (+ eeb2 u13))) (* 3 eeb4)
                (exp 10 (+ eeb2 u12))) eeb5)
             (<= u13 u12)
             (<= 0 u13))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ (* (- 1) (exp 10 u13)) (exp 10 u12)) (str.to.int y))
    (= (+ (* (- 1) (exp 10 (+ eeb2 u13))) (* 3 eeb4) (exp 10 (+ eeb2 u12))) eeb5)
    (<= u13 u12)
    (<= 0 u13))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %6 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ (* (- 1) (exp 10 u13)) (exp 10 u12)) %6)
    (= (+ (* (- 1) (exp 10 (+ eeb2 u13))) (* 3 eeb4) (exp 10 (+ eeb2 u12))) eeb5)
    (<= u13 u12)
    (<= 0 u13))
  
  iter(1)= (and
             (= %6 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 1) (exp 10 u13)) (exp 10 u12)) %6)
             (= (+ (* (- 1) (exp 10 (+ eeb2 u13))) (* 3 eeb4)
                (exp 10 (+ eeb2 u12))) eeb5)
             (<= u13 u12)
             (<= 0 u13))
  iter(2)= (and
             (= %6 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 1) (exp 10 u13)) (exp 10 u12)) %6)
             (= (+ (* (- 1) (exp 10 (+ eeb2 u13))) (* 3 eeb4)
                (exp 10 (+ eeb2 u12))) eeb5)
             (<= u13 u12)
             (<= 0 u13))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 3 eeb5) (* 3
                             (+ (* 3 eeb4)
                             (* 1
                             (* (+ (* 1
                                   (* (+ (* 1 (exp 10 u14))
                                      (* 1 (* (- 1) (exp 10 u15))))
                                   (exp 10 1)))
                                (* 3 1))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 3
                  (+ (* 1
                     (* (+ (* 1 (exp 10 u14)) (* 1 (* (- 1) (exp 10 u15))))
                     (exp 10 1)))
                  (* 3 1))) (* 3 (str.to.int y))))
             (<= (* 1 (* 1 u15)) (* 1 (* 1 u14)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u15))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 3 3) (* (* (* (* (- 1) (exp 10 u15)) 10) 1) 3)
                (* (* (* (exp 10 u14) 10) 1) 3)) (* 3 (str.to.int y)))
             (= (* 3 eeb5) (+ (* (* 3 eeb4) 3) (* (* (* 3 (exp 10 eeb2)) 1) 3)
                           (* (* (* (* (* (* (- 1) (exp 10 u15)) 10) 1)
                                 (exp 10 eeb2))
                              1)
                           3)
                           (* (* (* (* (* (exp 10 u14) 10) 1) (exp 10 eeb2)) 1)
                           3)))
             (<= u15 u14)
             (<= 0 u15))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 3 (* (- 10) (exp 10 u15)) (* 10 (exp 10 u14))) (* 1
                                                                  (str.to.int y)))
             (= (+ (* (- 10) (exp 10 eeb2) (exp 10 u15)) (* 3 eeb4)
                (* 3 (exp 10 eeb2)) (* 10 (exp 10 eeb2) (exp 10 u14)))
             (* 1 eeb5))
             (<= u15 u14)
             (<= 0 u15))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 3 (* (- 10) (exp 10 u15)) (* 10 (exp 10 u14))) (str.to.int y))
             (= (+ (* (- 10) (exp 10 (+ eeb2 u15))) (* 3 eeb4)
                (* 3 (exp 10 eeb2)) (* 10 (exp 10 (+ eeb2 u14)))) eeb5)
             (<= u15 u14)
             (<= 0 u15))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 3 (* (- 10) (exp 10 u15)) (* 10 (exp 10 u14))) (str.to.int y))
    (= (+ (* (- 10) (exp 10 (+ eeb2 u15))) (* 3 eeb4) (* 3 (exp 10 eeb2))
       (* 10 (exp 10 (+ eeb2 u14)))) eeb5)
    (<= u15 u14)
    (<= 0 u15))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %7 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 3 (* (- 10) (exp 10 u15)) (* 10 (exp 10 u14))) %7)
    (= (+ (* (- 10) (exp 10 (+ eeb2 u15))) (* 3 eeb4) (* 3 (exp 10 eeb2))
       (* 10 (exp 10 (+ eeb2 u14)))) eeb5)
    (<= u15 u14)
    (<= 0 u15))
  
  iter(1)= (and
             (= %7 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 3 (* (- 10) (exp 10 u15)) (* 10 (exp 10 u14))) %7)
             (= (+ (* (- 10) (exp 10 (+ eeb2 u15))) (* 3 eeb4)
                (* 3 (exp 10 eeb2)) (* 10 (exp 10 (+ eeb2 u14)))) eeb5)
             (<= u15 u14)
             (<= 0 u15))
  iter(2)= (and
             (= %7 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 3 (* (- 10) (exp 10 u15)) (* 10 (exp 10 u14))) %7)
             (= (+ (* (- 10) (exp 10 (+ eeb2 u15))) (* 3 eeb4)
                (* 3 (exp 10 eeb2)) (* 10 (exp 10 (+ eeb2 u14)))) eeb5)
             (<= u15 u14)
             (<= 0 u15))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 3 eeb5) (* 3
                             (+ (* 3 eeb4)
                             (* 1
                             (* (+ (* 1
                                   (* (+ (* 1 (exp 10 u16))
                                      (* 1 (* (- 1) (exp 10 u17))))
                                   (exp 10 1)))
                                (* 3 2))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 3
                  (+ (* 1
                     (* (+ (* 1 (exp 10 u16)) (* 1 (* (- 1) (exp 10 u17))))
                     (exp 10 1)))
                  (* 3 2))) (* 3 (str.to.int y))))
             (<= (* 1 (* 1 u17)) (* 1 (* 1 u16)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u17))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 6 3) (* (* (* (* (- 1) (exp 10 u17)) 10) 1) 3)
                (* (* (* (exp 10 u16) 10) 1) 3)) (* 3 (str.to.int y)))
             (= (* 3 eeb5) (+ (* (* 3 eeb4) 3) (* (* (* 6 (exp 10 eeb2)) 1) 3)
                           (* (* (* (* (* (* (- 1) (exp 10 u17)) 10) 1)
                                 (exp 10 eeb2))
                              1)
                           3)
                           (* (* (* (* (* (exp 10 u16) 10) 1) (exp 10 eeb2)) 1)
                           3)))
             (<= u17 u16)
             (<= 0 u17))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 3 (* (- 10) (exp 10 u17)) (* 10 (exp 10 u16))) (* 1
                                                                  (str.to.int y)))
             (= (+ (* (- 10) (exp 10 eeb2) (exp 10 u17)) (* 3 eeb4)
                (* 6 (exp 10 eeb2)) (* 10 (exp 10 eeb2) (exp 10 u16)))
             (* 1 eeb5))
             (<= u17 u16)
             (<= 0 u17))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 3 (* (- 10) (exp 10 u17)) (* 10 (exp 10 u16))) (str.to.int y))
             (= (+ (* (- 10) (exp 10 (+ eeb2 u17))) (* 3 eeb4)
                (* 6 (exp 10 eeb2)) (* 10 (exp 10 (+ eeb2 u16)))) eeb5)
             (<= u17 u16)
             (<= 0 u17))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 3 (* (- 10) (exp 10 u17)) (* 10 (exp 10 u16))) (str.to.int y))
    (= (+ (* (- 10) (exp 10 (+ eeb2 u17))) (* 3 eeb4) (* 6 (exp 10 eeb2))
       (* 10 (exp 10 (+ eeb2 u16)))) eeb5)
    (<= u17 u16)
    (<= 0 u17))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %8 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 3 (* (- 10) (exp 10 u17)) (* 10 (exp 10 u16))) %8)
    (= (+ (* (- 10) (exp 10 (+ eeb2 u17))) (* 3 eeb4) (* 6 (exp 10 eeb2))
       (* 10 (exp 10 (+ eeb2 u16)))) eeb5)
    (<= u17 u16)
    (<= 0 u17))
  
  iter(1)= (and
             (= %8 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 3 (* (- 10) (exp 10 u17)) (* 10 (exp 10 u16))) %8)
             (= (+ (* (- 10) (exp 10 (+ eeb2 u17))) (* 3 eeb4)
                (* 6 (exp 10 eeb2)) (* 10 (exp 10 (+ eeb2 u16)))) eeb5)
             (<= u17 u16)
             (<= 0 u17))
  iter(2)= (and
             (= %8 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 3 (* (- 10) (exp 10 u17)) (* 10 (exp 10 u16))) %8)
             (= (+ (* (- 10) (exp 10 (+ eeb2 u17))) (* 3 eeb4)
                (* 6 (exp 10 eeb2)) (* 10 (exp 10 (+ eeb2 u16)))) eeb5)
             (<= u17 u16)
             (<= 0 u17))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 4
                                   (* (+ (* 1 (exp 10 u18))
                                      (* 1 (* (- 1) (exp 10 u19))))
                                   (exp 10 0)))
                                (* 9 0))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9
                  (+ (* 4
                     (* (+ (* 1 (exp 10 u18)) (* 1 (* (- 1) (exp 10 u19))))
                     (exp 10 0)))
                  (* 9 0))) (* 9 (str.to.int y))))
             (<= (* 1 (* 1 u19)) (* 1 (* 1 u18)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u19))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* (* (* (* (- 1) (exp 10 u19)) 1) 4) 9)
                (* (* (* (exp 10 u18) 1) 4) 9)) (* 9 (str.to.int y)))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9)
                           (* (* (* (* (* (* (- 1) (exp 10 u19)) 1) 4)
                                 (exp 10 eeb2))
                              1)
                           9)
                           (* (* (* (* (* (exp 10 u18) 1) 4) (exp 10 eeb2)) 1)
                           9)))
             (<= u19 u18)
             (<= 0 u19))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 4) (exp 10 eeb2) (exp 10 u19))
                (* 4 (exp 10 eeb2) (exp 10 u18)) (* 9 eeb4)) (* 1 eeb5))
             (= (+ (* (- 4) (exp 10 u19)) (* 4 (exp 10 u18))) (* 1
                                                              (str.to.int y)))
             (<= u19 u18)
             (<= 0 u19))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 4) (exp 10 u19)) (* 4 (exp 10 u18))) (str.to.int y))
             (= (+ (* (- 4) (exp 10 (+ eeb2 u19))) (* 4 (exp 10 (+ eeb2 u18)))
                (* 9 eeb4)) eeb5)
             (<= u19 u18)
             (<= 0 u19))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ (* (- 4) (exp 10 u19)) (* 4 (exp 10 u18))) (str.to.int y))
    (= (+ (* (- 4) (exp 10 (+ eeb2 u19))) (* 4 (exp 10 (+ eeb2 u18)))
       (* 9 eeb4)) eeb5)
    (<= u19 u18)
    (<= 0 u19))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %9 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ (* (- 4) (exp 10 u19)) (* 4 (exp 10 u18))) %9)
    (= (+ (* (- 4) (exp 10 (+ eeb2 u19))) (* 4 (exp 10 (+ eeb2 u18)))
       (* 9 eeb4)) eeb5)
    (<= u19 u18)
    (<= 0 u19))
  
  iter(1)= (and
             (= %9 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 4) (exp 10 u19)) (* 4 (exp 10 u18))) %9)
             (= (+ (* (- 4) (exp 10 (+ eeb2 u19))) (* 4 (exp 10 (+ eeb2 u18)))
                (* 9 eeb4)) eeb5)
             (<= u19 u18)
             (<= 0 u19))
  iter(2)= (and
             (= %9 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 4) (exp 10 u19)) (* 4 (exp 10 u18))) %9)
             (= (+ (* (- 4) (exp 10 (+ eeb2 u19))) (* 4 (exp 10 (+ eeb2 u18)))
                (* 9 eeb4)) eeb5)
             (<= u19 u18)
             (<= 0 u19))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 4
                                   (* (+ (* 1 (exp 10 u20))
                                      (* 1 (* (- 1) (exp 10 u21))))
                                   (exp 10 1)))
                                (* 9 1))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9
                  (+ (* 4
                     (* (+ (* 1 (exp 10 u20)) (* 1 (* (- 1) (exp 10 u21))))
                     (exp 10 1)))
                  (* 9 1))) (* 9 (str.to.int y))))
             (<= (* 1 (* 1 u21)) (* 1 (* 1 u20)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u21))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 9 9) (* (* (* (* (- 1) (exp 10 u21)) 10) 4) 9)
                (* (* (* (exp 10 u20) 10) 4) 9)) (* 9 (str.to.int y)))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9) (* (* (* 9 (exp 10 eeb2)) 1) 9)
                           (* (* (* (* (* (* (- 1) (exp 10 u21)) 10) 4)
                                 (exp 10 eeb2))
                              1)
                           9)
                           (* (* (* (* (* (exp 10 u20) 10) 4) (exp 10 eeb2)) 1)
                           9)))
             (<= u21 u20)
             (<= 0 u21))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 40) (exp 10 u21)) (* 40 (exp 10 u20))) (* 1
                                                                  (str.to.int y)))
             (= (+ (* (- 40) (exp 10 eeb2) (exp 10 u21)) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 40 (exp 10 eeb2) (exp 10 u20)))
             (* 1 eeb5))
             (<= u21 u20)
             (<= 0 u21))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 40) (exp 10 u21)) (* 40 (exp 10 u20))) (str.to.int y))
             (= (+ (* (- 40) (exp 10 (+ eeb2 u21))) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 40 (exp 10 (+ eeb2 u20)))) eeb5)
             (<= u21 u20)
             (<= 0 u21))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 40) (exp 10 u21)) (* 40 (exp 10 u20))) (str.to.int y))
    (= (+ (* (- 40) (exp 10 (+ eeb2 u21))) (* 9 eeb4) (* 9 (exp 10 eeb2))
       (* 40 (exp 10 (+ eeb2 u20)))) eeb5)
    (<= u21 u20)
    (<= 0 u21))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %10 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 40) (exp 10 u21)) (* 40 (exp 10 u20))) %10)
    (= (+ (* (- 40) (exp 10 (+ eeb2 u21))) (* 9 eeb4) (* 9 (exp 10 eeb2))
       (* 40 (exp 10 (+ eeb2 u20)))) eeb5)
    (<= u21 u20)
    (<= 0 u21))
  
  iter(1)= (and
             (= %10 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 40) (exp 10 u21)) (* 40 (exp 10 u20))) %10)
             (= (+ (* (- 40) (exp 10 (+ eeb2 u21))) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 40 (exp 10 (+ eeb2 u20)))) eeb5)
             (<= u21 u20)
             (<= 0 u21))
  iter(2)= (and
             (= %10 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 40) (exp 10 u21)) (* 40 (exp 10 u20))) %10)
             (= (+ (* (- 40) (exp 10 (+ eeb2 u21))) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 40 (exp 10 (+ eeb2 u20)))) eeb5)
             (<= u21 u20)
             (<= 0 u21))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 4
                                   (* (+ (* 1 (exp 10 u22))
                                      (* 1 (* (- 1) (exp 10 u23))))
                                   (exp 10 1)))
                                (* 9 2))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9
                  (+ (* 4
                     (* (+ (* 1 (exp 10 u22)) (* 1 (* (- 1) (exp 10 u23))))
                     (exp 10 1)))
                  (* 9 2))) (* 9 (str.to.int y))))
             (<= (* 1 (* 1 u23)) (* 1 (* 1 u22)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u23))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 18 9) (* (* (* (* (- 1) (exp 10 u23)) 10) 4) 9)
                (* (* (* (exp 10 u22) 10) 4) 9)) (* 9 (str.to.int y)))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9) (* (* (* 18 (exp 10 eeb2)) 1) 9)
                           (* (* (* (* (* (* (- 1) (exp 10 u23)) 10) 4)
                                 (exp 10 eeb2))
                              1)
                           9)
                           (* (* (* (* (* (exp 10 u22) 10) 4) (exp 10 eeb2)) 1)
                           9)))
             (<= u23 u22)
             (<= 0 u23))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 40) (exp 10 u23)) (* 40 (exp 10 u22))) (* 1
                                                                  (str.to.int y)))
             (= (+ (* (- 40) (exp 10 eeb2) (exp 10 u23)) (* 9 eeb4)
                (* 18 (exp 10 eeb2)) (* 40 (exp 10 eeb2) (exp 10 u22)))
             (* 1 eeb5))
             (<= u23 u22)
             (<= 0 u23))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 40) (exp 10 u23)) (* 40 (exp 10 u22))) (str.to.int y))
             (= (+ (* (- 40) (exp 10 (+ eeb2 u23))) (* 9 eeb4)
                (* 18 (exp 10 eeb2)) (* 40 (exp 10 (+ eeb2 u22)))) eeb5)
             (<= u23 u22)
             (<= 0 u23))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 40) (exp 10 u23)) (* 40 (exp 10 u22))) (str.to.int y))
    (= (+ (* (- 40) (exp 10 (+ eeb2 u23))) (* 9 eeb4) (* 18 (exp 10 eeb2))
       (* 40 (exp 10 (+ eeb2 u22)))) eeb5)
    (<= u23 u22)
    (<= 0 u23))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %11 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 40) (exp 10 u23)) (* 40 (exp 10 u22))) %11)
    (= (+ (* (- 40) (exp 10 (+ eeb2 u23))) (* 9 eeb4) (* 18 (exp 10 eeb2))
       (* 40 (exp 10 (+ eeb2 u22)))) eeb5)
    (<= u23 u22)
    (<= 0 u23))
  
  iter(1)= (and
             (= %11 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 40) (exp 10 u23)) (* 40 (exp 10 u22))) %11)
             (= (+ (* (- 40) (exp 10 (+ eeb2 u23))) (* 9 eeb4)
                (* 18 (exp 10 eeb2)) (* 40 (exp 10 (+ eeb2 u22)))) eeb5)
             (<= u23 u22)
             (<= 0 u23))
  iter(2)= (and
             (= %11 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 40) (exp 10 u23)) (* 40 (exp 10 u22))) %11)
             (= (+ (* (- 40) (exp 10 (+ eeb2 u23))) (* 9 eeb4)
                (* 18 (exp 10 eeb2)) (* 40 (exp 10 (+ eeb2 u22)))) eeb5)
             (<= u23 u22)
             (<= 0 u23))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 5
                                   (* (+ (* 1 (exp 10 u24))
                                      (* 1 (* (- 1) (exp 10 u25))))
                                   (exp 10 0)))
                                (* 9 0))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9
                  (+ (* 5
                     (* (+ (* 1 (exp 10 u24)) (* 1 (* (- 1) (exp 10 u25))))
                     (exp 10 0)))
                  (* 9 0))) (* 9 (str.to.int y))))
             (<= (* 1 (* 1 u25)) (* 1 (* 1 u24)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u25))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* (* (* (* (- 1) (exp 10 u25)) 1) 5) 9)
                (* (* (* (exp 10 u24) 1) 5) 9)) (* 9 (str.to.int y)))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9)
                           (* (* (* (* (* (* (- 1) (exp 10 u25)) 1) 5)
                                 (exp 10 eeb2))
                              1)
                           9)
                           (* (* (* (* (* (exp 10 u24) 1) 5) (exp 10 eeb2)) 1)
                           9)))
             (<= u25 u24)
             (<= 0 u25))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 5) (exp 10 eeb2) (exp 10 u25))
                (* 5 (exp 10 eeb2) (exp 10 u24)) (* 9 eeb4)) (* 1 eeb5))
             (= (+ (* (- 5) (exp 10 u25)) (* 5 (exp 10 u24))) (* 1
                                                              (str.to.int y)))
             (<= u25 u24)
             (<= 0 u25))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 5) (exp 10 u25)) (* 5 (exp 10 u24))) (str.to.int y))
             (= (+ (* (- 5) (exp 10 (+ eeb2 u25))) (* 5 (exp 10 (+ eeb2 u24)))
                (* 9 eeb4)) eeb5)
             (<= u25 u24)
             (<= 0 u25))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ (* (- 5) (exp 10 u25)) (* 5 (exp 10 u24))) (str.to.int y))
    (= (+ (* (- 5) (exp 10 (+ eeb2 u25))) (* 5 (exp 10 (+ eeb2 u24)))
       (* 9 eeb4)) eeb5)
    (<= u25 u24)
    (<= 0 u25))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %12 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ (* (- 5) (exp 10 u25)) (* 5 (exp 10 u24))) %12)
    (= (+ (* (- 5) (exp 10 (+ eeb2 u25))) (* 5 (exp 10 (+ eeb2 u24)))
       (* 9 eeb4)) eeb5)
    (<= u25 u24)
    (<= 0 u25))
  
  iter(1)= (and
             (= %12 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 5) (exp 10 u25)) (* 5 (exp 10 u24))) %12)
             (= (+ (* (- 5) (exp 10 (+ eeb2 u25))) (* 5 (exp 10 (+ eeb2 u24)))
                (* 9 eeb4)) eeb5)
             (<= u25 u24)
             (<= 0 u25))
  iter(2)= (and
             (= %12 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 5) (exp 10 u25)) (* 5 (exp 10 u24))) %12)
             (= (+ (* (- 5) (exp 10 (+ eeb2 u25))) (* 5 (exp 10 (+ eeb2 u24)))
                (* 9 eeb4)) eeb5)
             (<= u25 u24)
             (<= 0 u25))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 5
                                   (* (+ (* 1 (exp 10 u26))
                                      (* 1 (* (- 1) (exp 10 u27))))
                                   (exp 10 1)))
                                (* 9 1))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9
                  (+ (* 5
                     (* (+ (* 1 (exp 10 u26)) (* 1 (* (- 1) (exp 10 u27))))
                     (exp 10 1)))
                  (* 9 1))) (* 9 (str.to.int y))))
             (<= (* 1 (* 1 u27)) (* 1 (* 1 u26)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u27))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 9 9) (* (* (* (* (- 1) (exp 10 u27)) 10) 5) 9)
                (* (* (* (exp 10 u26) 10) 5) 9)) (* 9 (str.to.int y)))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9) (* (* (* 9 (exp 10 eeb2)) 1) 9)
                           (* (* (* (* (* (* (- 1) (exp 10 u27)) 10) 5)
                                 (exp 10 eeb2))
                              1)
                           9)
                           (* (* (* (* (* (exp 10 u26) 10) 5) (exp 10 eeb2)) 1)
                           9)))
             (<= u27 u26)
             (<= 0 u27))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 50) (exp 10 u27)) (* 50 (exp 10 u26))) (* 1
                                                                  (str.to.int y)))
             (= (+ (* (- 50) (exp 10 eeb2) (exp 10 u27)) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 50 (exp 10 eeb2) (exp 10 u26)))
             (* 1 eeb5))
             (<= u27 u26)
             (<= 0 u27))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 50) (exp 10 u27)) (* 50 (exp 10 u26))) (str.to.int y))
             (= (+ (* (- 50) (exp 10 (+ eeb2 u27))) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 50 (exp 10 (+ eeb2 u26)))) eeb5)
             (<= u27 u26)
             (<= 0 u27))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 50) (exp 10 u27)) (* 50 (exp 10 u26))) (str.to.int y))
    (= (+ (* (- 50) (exp 10 (+ eeb2 u27))) (* 9 eeb4) (* 9 (exp 10 eeb2))
       (* 50 (exp 10 (+ eeb2 u26)))) eeb5)
    (<= u27 u26)
    (<= 0 u27))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %13 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 50) (exp 10 u27)) (* 50 (exp 10 u26))) %13)
    (= (+ (* (- 50) (exp 10 (+ eeb2 u27))) (* 9 eeb4) (* 9 (exp 10 eeb2))
       (* 50 (exp 10 (+ eeb2 u26)))) eeb5)
    (<= u27 u26)
    (<= 0 u27))
  
  iter(1)= (and
             (= %13 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 50) (exp 10 u27)) (* 50 (exp 10 u26))) %13)
             (= (+ (* (- 50) (exp 10 (+ eeb2 u27))) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 50 (exp 10 (+ eeb2 u26)))) eeb5)
             (<= u27 u26)
             (<= 0 u27))
  iter(2)= (and
             (= %13 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 50) (exp 10 u27)) (* 50 (exp 10 u26))) %13)
             (= (+ (* (- 50) (exp 10 (+ eeb2 u27))) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 50 (exp 10 (+ eeb2 u26)))) eeb5)
             (<= u27 u26)
             (<= 0 u27))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 5
                                   (* (+ (* 1 (exp 10 u28))
                                      (* 1 (* (- 1) (exp 10 u29))))
                                   (exp 10 1)))
                                (* 9 2))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9
                  (+ (* 5
                     (* (+ (* 1 (exp 10 u28)) (* 1 (* (- 1) (exp 10 u29))))
                     (exp 10 1)))
                  (* 9 2))) (* 9 (str.to.int y))))
             (<= (* 1 (* 1 u29)) (* 1 (* 1 u28)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u29))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 18 9) (* (* (* (* (- 1) (exp 10 u29)) 10) 5) 9)
                (* (* (* (exp 10 u28) 10) 5) 9)) (* 9 (str.to.int y)))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9) (* (* (* 18 (exp 10 eeb2)) 1) 9)
                           (* (* (* (* (* (* (- 1) (exp 10 u29)) 10) 5)
                                 (exp 10 eeb2))
                              1)
                           9)
                           (* (* (* (* (* (exp 10 u28) 10) 5) (exp 10 eeb2)) 1)
                           9)))
             (<= u29 u28)
             (<= 0 u29))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 50) (exp 10 u29)) (* 50 (exp 10 u28))) (* 1
                                                                  (str.to.int y)))
             (= (+ (* (- 50) (exp 10 eeb2) (exp 10 u29)) (* 9 eeb4)
                (* 18 (exp 10 eeb2)) (* 50 (exp 10 eeb2) (exp 10 u28)))
             (* 1 eeb5))
             (<= u29 u28)
             (<= 0 u29))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 50) (exp 10 u29)) (* 50 (exp 10 u28))) (str.to.int y))
             (= (+ (* (- 50) (exp 10 (+ eeb2 u29))) (* 9 eeb4)
                (* 18 (exp 10 eeb2)) (* 50 (exp 10 (+ eeb2 u28)))) eeb5)
             (<= u29 u28)
             (<= 0 u29))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 50) (exp 10 u29)) (* 50 (exp 10 u28))) (str.to.int y))
    (= (+ (* (- 50) (exp 10 (+ eeb2 u29))) (* 9 eeb4) (* 18 (exp 10 eeb2))
       (* 50 (exp 10 (+ eeb2 u28)))) eeb5)
    (<= u29 u28)
    (<= 0 u29))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %14 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 50) (exp 10 u29)) (* 50 (exp 10 u28))) %14)
    (= (+ (* (- 50) (exp 10 (+ eeb2 u29))) (* 9 eeb4) (* 18 (exp 10 eeb2))
       (* 50 (exp 10 (+ eeb2 u28)))) eeb5)
    (<= u29 u28)
    (<= 0 u29))
  
  iter(1)= (and
             (= %14 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 50) (exp 10 u29)) (* 50 (exp 10 u28))) %14)
             (= (+ (* (- 50) (exp 10 (+ eeb2 u29))) (* 9 eeb4)
                (* 18 (exp 10 eeb2)) (* 50 (exp 10 (+ eeb2 u28)))) eeb5)
             (<= u29 u28)
             (<= 0 u29))
  iter(2)= (and
             (= %14 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 50) (exp 10 u29)) (* 50 (exp 10 u28))) %14)
             (= (+ (* (- 50) (exp 10 (+ eeb2 u29))) (* 9 eeb4)
                (* 18 (exp 10 eeb2)) (* 50 (exp 10 (+ eeb2 u28)))) eeb5)
             (<= u29 u28)
             (<= 0 u29))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 3 eeb5) (* 3
                             (+ (* 3 eeb4)
                             (* 1
                             (* (+ (* 2
                                   (* (+ (* 1 (exp 10 u30))
                                      (* 1 (* (- 1) (exp 10 u31))))
                                   (exp 10 0)))
                                (* 3 0))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 3
                  (+ (* 2
                     (* (+ (* 1 (exp 10 u30)) (* 1 (* (- 1) (exp 10 u31))))
                     (exp 10 0)))
                  (* 3 0))) (* 3 (str.to.int y))))
             (<= (* 1 (* 1 u31)) (* 1 (* 1 u30)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u31))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* (* (* (* (- 1) (exp 10 u31)) 1) 2) 3)
                (* (* (* (exp 10 u30) 1) 2) 3)) (* 3 (str.to.int y)))
             (= (* 3 eeb5) (+ (* (* 3 eeb4) 3)
                           (* (* (* (* (* (* (- 1) (exp 10 u31)) 1) 2)
                                 (exp 10 eeb2))
                              1)
                           3)
                           (* (* (* (* (* (exp 10 u30) 1) 2) (exp 10 eeb2)) 1)
                           3)))
             (<= u31 u30)
             (<= 0 u31))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 2) (exp 10 eeb2) (exp 10 u31))
                (* 2 (exp 10 eeb2) (exp 10 u30)) (* 3 eeb4)) (* 1 eeb5))
             (= (+ (* (- 2) (exp 10 u31)) (* 2 (exp 10 u30))) (* 1
                                                              (str.to.int y)))
             (<= u31 u30)
             (<= 0 u31))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 2) (exp 10 u31)) (* 2 (exp 10 u30))) (str.to.int y))
             (= (+ (* (- 2) (exp 10 (+ eeb2 u31))) (* 2 (exp 10 (+ eeb2 u30)))
                (* 3 eeb4)) eeb5)
             (<= u31 u30)
             (<= 0 u31))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ (* (- 2) (exp 10 u31)) (* 2 (exp 10 u30))) (str.to.int y))
    (= (+ (* (- 2) (exp 10 (+ eeb2 u31))) (* 2 (exp 10 (+ eeb2 u30)))
       (* 3 eeb4)) eeb5)
    (<= u31 u30)
    (<= 0 u31))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %15 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ (* (- 2) (exp 10 u31)) (* 2 (exp 10 u30))) %15)
    (= (+ (* (- 2) (exp 10 (+ eeb2 u31))) (* 2 (exp 10 (+ eeb2 u30)))
       (* 3 eeb4)) eeb5)
    (<= u31 u30)
    (<= 0 u31))
  
  iter(1)= (and
             (= %15 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 2) (exp 10 u31)) (* 2 (exp 10 u30))) %15)
             (= (+ (* (- 2) (exp 10 (+ eeb2 u31))) (* 2 (exp 10 (+ eeb2 u30)))
                (* 3 eeb4)) eeb5)
             (<= u31 u30)
             (<= 0 u31))
  iter(2)= (and
             (= %15 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 2) (exp 10 u31)) (* 2 (exp 10 u30))) %15)
             (= (+ (* (- 2) (exp 10 (+ eeb2 u31))) (* 2 (exp 10 (+ eeb2 u30)))
                (* 3 eeb4)) eeb5)
             (<= u31 u30)
             (<= 0 u31))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 3 eeb5) (* 3
                             (+ (* 3 eeb4)
                             (* 1
                             (* (+ (* 2
                                   (* (+ (* 1 (exp 10 u32))
                                      (* 1 (* (- 1) (exp 10 u33))))
                                   (exp 10 1)))
                                (* 3 1))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 3
                  (+ (* 2
                     (* (+ (* 1 (exp 10 u32)) (* 1 (* (- 1) (exp 10 u33))))
                     (exp 10 1)))
                  (* 3 1))) (* 3 (str.to.int y))))
             (<= (* 1 (* 1 u33)) (* 1 (* 1 u32)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u33))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 3 3) (* (* (* (* (- 1) (exp 10 u33)) 10) 2) 3)
                (* (* (* (exp 10 u32) 10) 2) 3)) (* 3 (str.to.int y)))
             (= (* 3 eeb5) (+ (* (* 3 eeb4) 3) (* (* (* 3 (exp 10 eeb2)) 1) 3)
                           (* (* (* (* (* (* (- 1) (exp 10 u33)) 10) 2)
                                 (exp 10 eeb2))
                              1)
                           3)
                           (* (* (* (* (* (exp 10 u32) 10) 2) (exp 10 eeb2)) 1)
                           3)))
             (<= u33 u32)
             (<= 0 u33))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 3 (* (- 20) (exp 10 u33)) (* 20 (exp 10 u32))) (* 1
                                                                  (str.to.int y)))
             (= (+ (* (- 20) (exp 10 eeb2) (exp 10 u33)) (* 3 eeb4)
                (* 3 (exp 10 eeb2)) (* 20 (exp 10 eeb2) (exp 10 u32)))
             (* 1 eeb5))
             (<= u33 u32)
             (<= 0 u33))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 3 (* (- 20) (exp 10 u33)) (* 20 (exp 10 u32))) (str.to.int y))
             (= (+ (* (- 20) (exp 10 (+ eeb2 u33))) (* 3 eeb4)
                (* 3 (exp 10 eeb2)) (* 20 (exp 10 (+ eeb2 u32)))) eeb5)
             (<= u33 u32)
             (<= 0 u33))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 3 (* (- 20) (exp 10 u33)) (* 20 (exp 10 u32))) (str.to.int y))
    (= (+ (* (- 20) (exp 10 (+ eeb2 u33))) (* 3 eeb4) (* 3 (exp 10 eeb2))
       (* 20 (exp 10 (+ eeb2 u32)))) eeb5)
    (<= u33 u32)
    (<= 0 u33))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %16 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 3 (* (- 20) (exp 10 u33)) (* 20 (exp 10 u32))) %16)
    (= (+ (* (- 20) (exp 10 (+ eeb2 u33))) (* 3 eeb4) (* 3 (exp 10 eeb2))
       (* 20 (exp 10 (+ eeb2 u32)))) eeb5)
    (<= u33 u32)
    (<= 0 u33))
  
  iter(1)= (and
             (= %16 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 3 (* (- 20) (exp 10 u33)) (* 20 (exp 10 u32))) %16)
             (= (+ (* (- 20) (exp 10 (+ eeb2 u33))) (* 3 eeb4)
                (* 3 (exp 10 eeb2)) (* 20 (exp 10 (+ eeb2 u32)))) eeb5)
             (<= u33 u32)
             (<= 0 u33))
  iter(2)= (and
             (= %16 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 3 (* (- 20) (exp 10 u33)) (* 20 (exp 10 u32))) %16)
             (= (+ (* (- 20) (exp 10 (+ eeb2 u33))) (* 3 eeb4)
                (* 3 (exp 10 eeb2)) (* 20 (exp 10 (+ eeb2 u32)))) eeb5)
             (<= u33 u32)
             (<= 0 u33))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 3 eeb5) (* 3
                             (+ (* 3 eeb4)
                             (* 1
                             (* (+ (* 2
                                   (* (+ (* 1 (exp 10 u34))
                                      (* 1 (* (- 1) (exp 10 u35))))
                                   (exp 10 1)))
                                (* 3 2))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 3
                  (+ (* 2
                     (* (+ (* 1 (exp 10 u34)) (* 1 (* (- 1) (exp 10 u35))))
                     (exp 10 1)))
                  (* 3 2))) (* 3 (str.to.int y))))
             (<= (* 1 (* 1 u35)) (* 1 (* 1 u34)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u35))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 6 3) (* (* (* (* (- 1) (exp 10 u35)) 10) 2) 3)
                (* (* (* (exp 10 u34) 10) 2) 3)) (* 3 (str.to.int y)))
             (= (* 3 eeb5) (+ (* (* 3 eeb4) 3) (* (* (* 6 (exp 10 eeb2)) 1) 3)
                           (* (* (* (* (* (* (- 1) (exp 10 u35)) 10) 2)
                                 (exp 10 eeb2))
                              1)
                           3)
                           (* (* (* (* (* (exp 10 u34) 10) 2) (exp 10 eeb2)) 1)
                           3)))
             (<= u35 u34)
             (<= 0 u35))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 3 (* (- 20) (exp 10 u35)) (* 20 (exp 10 u34))) (* 1
                                                                  (str.to.int y)))
             (= (+ (* (- 20) (exp 10 eeb2) (exp 10 u35)) (* 3 eeb4)
                (* 6 (exp 10 eeb2)) (* 20 (exp 10 eeb2) (exp 10 u34)))
             (* 1 eeb5))
             (<= u35 u34)
             (<= 0 u35))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 3 (* (- 20) (exp 10 u35)) (* 20 (exp 10 u34))) (str.to.int y))
             (= (+ (* (- 20) (exp 10 (+ eeb2 u35))) (* 3 eeb4)
                (* 6 (exp 10 eeb2)) (* 20 (exp 10 (+ eeb2 u34)))) eeb5)
             (<= u35 u34)
             (<= 0 u35))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 3 (* (- 20) (exp 10 u35)) (* 20 (exp 10 u34))) (str.to.int y))
    (= (+ (* (- 20) (exp 10 (+ eeb2 u35))) (* 3 eeb4) (* 6 (exp 10 eeb2))
       (* 20 (exp 10 (+ eeb2 u34)))) eeb5)
    (<= u35 u34)
    (<= 0 u35))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %17 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 3 (* (- 20) (exp 10 u35)) (* 20 (exp 10 u34))) %17)
    (= (+ (* (- 20) (exp 10 (+ eeb2 u35))) (* 3 eeb4) (* 6 (exp 10 eeb2))
       (* 20 (exp 10 (+ eeb2 u34)))) eeb5)
    (<= u35 u34)
    (<= 0 u35))
  
  iter(1)= (and
             (= %17 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 3 (* (- 20) (exp 10 u35)) (* 20 (exp 10 u34))) %17)
             (= (+ (* (- 20) (exp 10 (+ eeb2 u35))) (* 3 eeb4)
                (* 6 (exp 10 eeb2)) (* 20 (exp 10 (+ eeb2 u34)))) eeb5)
             (<= u35 u34)
             (<= 0 u35))
  iter(2)= (and
             (= %17 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 3 (* (- 20) (exp 10 u35)) (* 20 (exp 10 u34))) %17)
             (= (+ (* (- 20) (exp 10 (+ eeb2 u35))) (* 3 eeb4)
                (* 6 (exp 10 eeb2)) (* 20 (exp 10 (+ eeb2 u34)))) eeb5)
             (<= u35 u34)
             (<= 0 u35))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 7
                                   (* (+ (* 1 (exp 10 u36))
                                      (* 1 (* (- 1) (exp 10 u37))))
                                   (exp 10 0)))
                                (* 9 0))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9
                  (+ (* 7
                     (* (+ (* 1 (exp 10 u36)) (* 1 (* (- 1) (exp 10 u37))))
                     (exp 10 0)))
                  (* 9 0))) (* 9 (str.to.int y))))
             (<= (* 1 (* 1 u37)) (* 1 (* 1 u36)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u37))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* (* (* (* (- 1) (exp 10 u37)) 1) 7) 9)
                (* (* (* (exp 10 u36) 1) 7) 9)) (* 9 (str.to.int y)))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9)
                           (* (* (* (* (* (* (- 1) (exp 10 u37)) 1) 7)
                                 (exp 10 eeb2))
                              1)
                           9)
                           (* (* (* (* (* (exp 10 u36) 1) 7) (exp 10 eeb2)) 1)
                           9)))
             (<= u37 u36)
             (<= 0 u37))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 7) (exp 10 eeb2) (exp 10 u37))
                (* 7 (exp 10 eeb2) (exp 10 u36)) (* 9 eeb4)) (* 1 eeb5))
             (= (+ (* (- 7) (exp 10 u37)) (* 7 (exp 10 u36))) (* 1
                                                              (str.to.int y)))
             (<= u37 u36)
             (<= 0 u37))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 7) (exp 10 u37)) (* 7 (exp 10 u36))) (str.to.int y))
             (= (+ (* (- 7) (exp 10 (+ eeb2 u37))) (* 7 (exp 10 (+ eeb2 u36)))
                (* 9 eeb4)) eeb5)
             (<= u37 u36)
             (<= 0 u37))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ (* (- 7) (exp 10 u37)) (* 7 (exp 10 u36))) (str.to.int y))
    (= (+ (* (- 7) (exp 10 (+ eeb2 u37))) (* 7 (exp 10 (+ eeb2 u36)))
       (* 9 eeb4)) eeb5)
    (<= u37 u36)
    (<= 0 u37))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %18 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ (* (- 7) (exp 10 u37)) (* 7 (exp 10 u36))) %18)
    (= (+ (* (- 7) (exp 10 (+ eeb2 u37))) (* 7 (exp 10 (+ eeb2 u36)))
       (* 9 eeb4)) eeb5)
    (<= u37 u36)
    (<= 0 u37))
  
  iter(1)= (and
             (= %18 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 7) (exp 10 u37)) (* 7 (exp 10 u36))) %18)
             (= (+ (* (- 7) (exp 10 (+ eeb2 u37))) (* 7 (exp 10 (+ eeb2 u36)))
                (* 9 eeb4)) eeb5)
             (<= u37 u36)
             (<= 0 u37))
  iter(2)= (and
             (= %18 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 7) (exp 10 u37)) (* 7 (exp 10 u36))) %18)
             (= (+ (* (- 7) (exp 10 (+ eeb2 u37))) (* 7 (exp 10 (+ eeb2 u36)))
                (* 9 eeb4)) eeb5)
             (<= u37 u36)
             (<= 0 u37))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 7
                                   (* (+ (* 1 (exp 10 u38))
                                      (* 1 (* (- 1) (exp 10 u39))))
                                   (exp 10 1)))
                                (* 9 1))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9
                  (+ (* 7
                     (* (+ (* 1 (exp 10 u38)) (* 1 (* (- 1) (exp 10 u39))))
                     (exp 10 1)))
                  (* 9 1))) (* 9 (str.to.int y))))
             (<= (* 1 (* 1 u39)) (* 1 (* 1 u38)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u39))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 9 9) (* (* (* (* (- 1) (exp 10 u39)) 10) 7) 9)
                (* (* (* (exp 10 u38) 10) 7) 9)) (* 9 (str.to.int y)))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9) (* (* (* 9 (exp 10 eeb2)) 1) 9)
                           (* (* (* (* (* (* (- 1) (exp 10 u39)) 10) 7)
                                 (exp 10 eeb2))
                              1)
                           9)
                           (* (* (* (* (* (exp 10 u38) 10) 7) (exp 10 eeb2)) 1)
                           9)))
             (<= u39 u38)
             (<= 0 u39))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 70) (exp 10 u39)) (* 70 (exp 10 u38))) (* 1
                                                                  (str.to.int y)))
             (= (+ (* (- 70) (exp 10 eeb2) (exp 10 u39)) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 70 (exp 10 eeb2) (exp 10 u38)))
             (* 1 eeb5))
             (<= u39 u38)
             (<= 0 u39))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 70) (exp 10 u39)) (* 70 (exp 10 u38))) (str.to.int y))
             (= (+ (* (- 70) (exp 10 (+ eeb2 u39))) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 70 (exp 10 (+ eeb2 u38)))) eeb5)
             (<= u39 u38)
             (<= 0 u39))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 70) (exp 10 u39)) (* 70 (exp 10 u38))) (str.to.int y))
    (= (+ (* (- 70) (exp 10 (+ eeb2 u39))) (* 9 eeb4) (* 9 (exp 10 eeb2))
       (* 70 (exp 10 (+ eeb2 u38)))) eeb5)
    (<= u39 u38)
    (<= 0 u39))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %19 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 70) (exp 10 u39)) (* 70 (exp 10 u38))) %19)
    (= (+ (* (- 70) (exp 10 (+ eeb2 u39))) (* 9 eeb4) (* 9 (exp 10 eeb2))
       (* 70 (exp 10 (+ eeb2 u38)))) eeb5)
    (<= u39 u38)
    (<= 0 u39))
  
  iter(1)= (and
             (= %19 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 70) (exp 10 u39)) (* 70 (exp 10 u38))) %19)
             (= (+ (* (- 70) (exp 10 (+ eeb2 u39))) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 70 (exp 10 (+ eeb2 u38)))) eeb5)
             (<= u39 u38)
             (<= 0 u39))
  iter(2)= (and
             (= %19 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 70) (exp 10 u39)) (* 70 (exp 10 u38))) %19)
             (= (+ (* (- 70) (exp 10 (+ eeb2 u39))) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 70 (exp 10 (+ eeb2 u38)))) eeb5)
             (<= u39 u38)
             (<= 0 u39))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 7
                                   (* (+ (* 1 (exp 10 u40))
                                      (* 1 (* (- 1) (exp 10 u41))))
                                   (exp 10 1)))
                                (* 9 2))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9
                  (+ (* 7
                     (* (+ (* 1 (exp 10 u40)) (* 1 (* (- 1) (exp 10 u41))))
                     (exp 10 1)))
                  (* 9 2))) (* 9 (str.to.int y))))
             (<= (* 1 (* 1 u41)) (* 1 (* 1 u40)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u41))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 18 9) (* (* (* (* (- 1) (exp 10 u41)) 10) 7) 9)
                (* (* (* (exp 10 u40) 10) 7) 9)) (* 9 (str.to.int y)))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9) (* (* (* 18 (exp 10 eeb2)) 1) 9)
                           (* (* (* (* (* (* (- 1) (exp 10 u41)) 10) 7)
                                 (exp 10 eeb2))
                              1)
                           9)
                           (* (* (* (* (* (exp 10 u40) 10) 7) (exp 10 eeb2)) 1)
                           9)))
             (<= u41 u40)
             (<= 0 u41))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 70) (exp 10 u41)) (* 70 (exp 10 u40))) (* 1
                                                                  (str.to.int y)))
             (= (+ (* (- 70) (exp 10 eeb2) (exp 10 u41)) (* 9 eeb4)
                (* 18 (exp 10 eeb2)) (* 70 (exp 10 eeb2) (exp 10 u40)))
             (* 1 eeb5))
             (<= u41 u40)
             (<= 0 u41))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 70) (exp 10 u41)) (* 70 (exp 10 u40))) (str.to.int y))
             (= (+ (* (- 70) (exp 10 (+ eeb2 u41))) (* 9 eeb4)
                (* 18 (exp 10 eeb2)) (* 70 (exp 10 (+ eeb2 u40)))) eeb5)
             (<= u41 u40)
             (<= 0 u41))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 70) (exp 10 u41)) (* 70 (exp 10 u40))) (str.to.int y))
    (= (+ (* (- 70) (exp 10 (+ eeb2 u41))) (* 9 eeb4) (* 18 (exp 10 eeb2))
       (* 70 (exp 10 (+ eeb2 u40)))) eeb5)
    (<= u41 u40)
    (<= 0 u41))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %20 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 70) (exp 10 u41)) (* 70 (exp 10 u40))) %20)
    (= (+ (* (- 70) (exp 10 (+ eeb2 u41))) (* 9 eeb4) (* 18 (exp 10 eeb2))
       (* 70 (exp 10 (+ eeb2 u40)))) eeb5)
    (<= u41 u40)
    (<= 0 u41))
  
  iter(1)= (and
             (= %20 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 70) (exp 10 u41)) (* 70 (exp 10 u40))) %20)
             (= (+ (* (- 70) (exp 10 (+ eeb2 u41))) (* 9 eeb4)
                (* 18 (exp 10 eeb2)) (* 70 (exp 10 (+ eeb2 u40)))) eeb5)
             (<= u41 u40)
             (<= 0 u41))
  iter(2)= (and
             (= %20 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 70) (exp 10 u41)) (* 70 (exp 10 u40))) %20)
             (= (+ (* (- 70) (exp 10 (+ eeb2 u41))) (* 9 eeb4)
                (* 18 (exp 10 eeb2)) (* 70 (exp 10 (+ eeb2 u40)))) eeb5)
             (<= u41 u40)
             (<= 0 u41))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 8
                                   (* (+ (* 1 (exp 10 u42))
                                      (* 1 (* (- 1) (exp 10 u43))))
                                   (exp 10 0)))
                                (* 9 0))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9
                  (+ (* 8
                     (* (+ (* 1 (exp 10 u42)) (* 1 (* (- 1) (exp 10 u43))))
                     (exp 10 0)))
                  (* 9 0))) (* 9 (str.to.int y))))
             (<= (* 1 (* 1 u43)) (* 1 (* 1 u42)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u43))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* (* (* (* (- 1) (exp 10 u43)) 1) 8) 9)
                (* (* (* (exp 10 u42) 1) 8) 9)) (* 9 (str.to.int y)))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9)
                           (* (* (* (* (* (* (- 1) (exp 10 u43)) 1) 8)
                                 (exp 10 eeb2))
                              1)
                           9)
                           (* (* (* (* (* (exp 10 u42) 1) 8) (exp 10 eeb2)) 1)
                           9)))
             (<= u43 u42)
             (<= 0 u43))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 8) (exp 10 eeb2) (exp 10 u43))
                (* 8 (exp 10 eeb2) (exp 10 u42)) (* 9 eeb4)) (* 1 eeb5))
             (= (+ (* (- 8) (exp 10 u43)) (* 8 (exp 10 u42))) (* 1
                                                              (str.to.int y)))
             (<= u43 u42)
             (<= 0 u43))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 8) (exp 10 u43)) (* 8 (exp 10 u42))) (str.to.int y))
             (= (+ (* (- 8) (exp 10 (+ eeb2 u43))) (* 8 (exp 10 (+ eeb2 u42)))
                (* 9 eeb4)) eeb5)
             (<= u43 u42)
             (<= 0 u43))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ (* (- 8) (exp 10 u43)) (* 8 (exp 10 u42))) (str.to.int y))
    (= (+ (* (- 8) (exp 10 (+ eeb2 u43))) (* 8 (exp 10 (+ eeb2 u42)))
       (* 9 eeb4)) eeb5)
    (<= u43 u42)
    (<= 0 u43))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %21 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ (* (- 8) (exp 10 u43)) (* 8 (exp 10 u42))) %21)
    (= (+ (* (- 8) (exp 10 (+ eeb2 u43))) (* 8 (exp 10 (+ eeb2 u42)))
       (* 9 eeb4)) eeb5)
    (<= u43 u42)
    (<= 0 u43))
  
  iter(1)= (and
             (= %21 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 8) (exp 10 u43)) (* 8 (exp 10 u42))) %21)
             (= (+ (* (- 8) (exp 10 (+ eeb2 u43))) (* 8 (exp 10 (+ eeb2 u42)))
                (* 9 eeb4)) eeb5)
             (<= u43 u42)
             (<= 0 u43))
  iter(2)= (and
             (= %21 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 8) (exp 10 u43)) (* 8 (exp 10 u42))) %21)
             (= (+ (* (- 8) (exp 10 (+ eeb2 u43))) (* 8 (exp 10 (+ eeb2 u42)))
                (* 9 eeb4)) eeb5)
             (<= u43 u42)
             (<= 0 u43))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 8
                                   (* (+ (* 1 (exp 10 u44))
                                      (* 1 (* (- 1) (exp 10 u45))))
                                   (exp 10 1)))
                                (* 9 1))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9
                  (+ (* 8
                     (* (+ (* 1 (exp 10 u44)) (* 1 (* (- 1) (exp 10 u45))))
                     (exp 10 1)))
                  (* 9 1))) (* 9 (str.to.int y))))
             (<= (* 1 (* 1 u45)) (* 1 (* 1 u44)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u45))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 9 9) (* (* (* (* (- 1) (exp 10 u45)) 10) 8) 9)
                (* (* (* (exp 10 u44) 10) 8) 9)) (* 9 (str.to.int y)))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9) (* (* (* 9 (exp 10 eeb2)) 1) 9)
                           (* (* (* (* (* (* (- 1) (exp 10 u45)) 10) 8)
                                 (exp 10 eeb2))
                              1)
                           9)
                           (* (* (* (* (* (exp 10 u44) 10) 8) (exp 10 eeb2)) 1)
                           9)))
             (<= u45 u44)
             (<= 0 u45))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 80) (exp 10 u45)) (* 80 (exp 10 u44))) (* 1
                                                                  (str.to.int y)))
             (= (+ (* (- 80) (exp 10 eeb2) (exp 10 u45)) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 80 (exp 10 eeb2) (exp 10 u44)))
             (* 1 eeb5))
             (<= u45 u44)
             (<= 0 u45))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 80) (exp 10 u45)) (* 80 (exp 10 u44))) (str.to.int y))
             (= (+ (* (- 80) (exp 10 (+ eeb2 u45))) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 80 (exp 10 (+ eeb2 u44)))) eeb5)
             (<= u45 u44)
             (<= 0 u45))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 80) (exp 10 u45)) (* 80 (exp 10 u44))) (str.to.int y))
    (= (+ (* (- 80) (exp 10 (+ eeb2 u45))) (* 9 eeb4) (* 9 (exp 10 eeb2))
       (* 80 (exp 10 (+ eeb2 u44)))) eeb5)
    (<= u45 u44)
    (<= 0 u45))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %22 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 80) (exp 10 u45)) (* 80 (exp 10 u44))) %22)
    (= (+ (* (- 80) (exp 10 (+ eeb2 u45))) (* 9 eeb4) (* 9 (exp 10 eeb2))
       (* 80 (exp 10 (+ eeb2 u44)))) eeb5)
    (<= u45 u44)
    (<= 0 u45))
  
  iter(1)= (and
             (= %22 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 80) (exp 10 u45)) (* 80 (exp 10 u44))) %22)
             (= (+ (* (- 80) (exp 10 (+ eeb2 u45))) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 80 (exp 10 (+ eeb2 u44)))) eeb5)
             (<= u45 u44)
             (<= 0 u45))
  iter(2)= (and
             (= %22 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 80) (exp 10 u45)) (* 80 (exp 10 u44))) %22)
             (= (+ (* (- 80) (exp 10 (+ eeb2 u45))) (* 9 eeb4)
                (* 9 (exp 10 eeb2)) (* 80 (exp 10 (+ eeb2 u44)))) eeb5)
             (<= u45 u44)
             (<= 0 u45))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 8
                                   (* (+ (* 1 (exp 10 u46))
                                      (* 1 (* (- 1) (exp 10 u47))))
                                   (exp 10 1)))
                                (* 9 2))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9
                  (+ (* 8
                     (* (+ (* 1 (exp 10 u46)) (* 1 (* (- 1) (exp 10 u47))))
                     (exp 10 1)))
                  (* 9 2))) (* 9 (str.to.int y))))
             (<= (* 1 (* 1 u47)) (* 1 (* 1 u46)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u47))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 18 9) (* (* (* (* (- 1) (exp 10 u47)) 10) 8) 9)
                (* (* (* (exp 10 u46) 10) 8) 9)) (* 9 (str.to.int y)))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9) (* (* (* 18 (exp 10 eeb2)) 1) 9)
                           (* (* (* (* (* (* (- 1) (exp 10 u47)) 10) 8)
                                 (exp 10 eeb2))
                              1)
                           9)
                           (* (* (* (* (* (exp 10 u46) 10) 8) (exp 10 eeb2)) 1)
                           9)))
             (<= u47 u46)
             (<= 0 u47))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 80) (exp 10 u47)) (* 80 (exp 10 u46))) (* 1
                                                                  (str.to.int y)))
             (= (+ (* (- 80) (exp 10 eeb2) (exp 10 u47)) (* 9 eeb4)
                (* 18 (exp 10 eeb2)) (* 80 (exp 10 eeb2) (exp 10 u46)))
             (* 1 eeb5))
             (<= u47 u46)
             (<= 0 u47))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 80) (exp 10 u47)) (* 80 (exp 10 u46))) (str.to.int y))
             (= (+ (* (- 80) (exp 10 (+ eeb2 u47))) (* 9 eeb4)
                (* 18 (exp 10 eeb2)) (* 80 (exp 10 (+ eeb2 u46)))) eeb5)
             (<= u47 u46)
             (<= 0 u47))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 80) (exp 10 u47)) (* 80 (exp 10 u46))) (str.to.int y))
    (= (+ (* (- 80) (exp 10 (+ eeb2 u47))) (* 9 eeb4) (* 18 (exp 10 eeb2))
       (* 80 (exp 10 (+ eeb2 u46)))) eeb5)
    (<= u47 u46)
    (<= 0 u47))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %23 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 9 (* (- 80) (exp 10 u47)) (* 80 (exp 10 u46))) %23)
    (= (+ (* (- 80) (exp 10 (+ eeb2 u47))) (* 9 eeb4) (* 18 (exp 10 eeb2))
       (* 80 (exp 10 (+ eeb2 u46)))) eeb5)
    (<= u47 u46)
    (<= 0 u47))
  
  iter(1)= (and
             (= %23 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 80) (exp 10 u47)) (* 80 (exp 10 u46))) %23)
             (= (+ (* (- 80) (exp 10 (+ eeb2 u47))) (* 9 eeb4)
                (* 18 (exp 10 eeb2)) (* 80 (exp 10 (+ eeb2 u46)))) eeb5)
             (<= u47 u46)
             (<= 0 u47))
  iter(2)= (and
             (= %23 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* (- 80) (exp 10 u47)) (* 80 (exp 10 u46))) %23)
             (= (+ (* (- 80) (exp 10 (+ eeb2 u47))) (* 9 eeb4)
                (* 18 (exp 10 eeb2)) (* 80 (exp 10 (+ eeb2 u46)))) eeb5)
             (<= u47 u46)
             (<= 0 u47))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 1 eeb5) (* 1
                             (+ (* 1 eeb4)
                             (* 1
                             (* (+ (* 1
                                   (* (+ (* 1 (exp 10 u48))
                                      (* 1 (* (- 1) (exp 10 u49))))
                                   (exp 10 0)))
                                (* 1 0))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 1
                  (+ (* 1
                     (* (+ (* 1 (exp 10 u48)) (* 1 (* (- 1) (exp 10 u49))))
                     (exp 10 0)))
                  (* 1 0))) (* 1 (str.to.int y))))
             (<= (* 1 (* 1 u49)) (* 1 (* 1 u48)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u49))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= eeb5 (+ (* eeb4 1)
                     (* (* (* (* (* (* (- 1) (exp 10 u49)) 1) 1) (exp 10 eeb2))
                        1)
                     1) (* (* (* (* (* (exp 10 u48) 1) 1) (exp 10 eeb2)) 1) 1)))
             (= (+ (* (* (* (* (- 1) (exp 10 u49)) 1) 1) 1)
                (* (* (* (exp 10 u48) 1) 1) 1)) (str.to.int y))
             (<= u49 u48)
             (<= 0 u49))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* (- 1) (exp 10 eeb2) (exp 10 u49))
                     (exp 10 (+ u48 eeb2))))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 1) (exp 10 u49)) (exp 10 u48)) (str.to.int y))
             (<= u49 u48)
             (<= 0 u49))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* (- 1) (exp 10 (+ eeb2 u49)))
                     (exp 10 (+ eeb2 u48))))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 1) (exp 10 u49)) (exp 10 u48)) (str.to.int y))
             (<= u49 u48)
             (<= 0 u49))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* (- 1) (exp 10 (+ eeb2 u49))) (exp 10 (+ eeb2 u48))))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ (* (- 1) (exp 10 u49)) (exp 10 u48)) (str.to.int y))
    (<= u49 u48)
    (<= 0 u49))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %24 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* (- 1) (exp 10 (+ eeb2 u49))) (exp 10 (+ eeb2 u48))))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ (* (- 1) (exp 10 u49)) (exp 10 u48)) %24)
    (<= u49 u48)
    (<= 0 u49))
  
  iter(1)= (and
             (= %24 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* (- 1) (exp 10 (+ eeb2 u49)))
                     (exp 10 (+ eeb2 u48))))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 1) (exp 10 u49)) (exp 10 u48)) %24)
             (<= u49 u48)
             (<= 0 u49))
  iter(2)= (and
             (= %24 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* (- 1) (exp 10 (+ eeb2 u49)))
                     (exp 10 (+ eeb2 u48))))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ (* (- 1) (exp 10 u49)) (exp 10 u48)) %24)
             (<= u49 u48)
             (<= 0 u49))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 1 eeb5) (* 1
                             (+ (* 1 eeb4)
                             (* 1
                             (* (+ (* 1
                                   (* (+ (* 1 (exp 10 u50))
                                      (* 1 (* (- 1) (exp 10 u51))))
                                   (exp 10 1)))
                                (* 1 1))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 1
                  (+ (* 1
                     (* (+ (* 1 (exp 10 u50)) (* 1 (* (- 1) (exp 10 u51))))
                     (exp 10 1)))
                  (* 1 1))) (* 1 (str.to.int y))))
             (<= (* 1 (* 1 u51)) (* 1 (* 1 u50)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u51))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= eeb5 (+ (* eeb4 1) (* (* (* 1 (exp 10 eeb2)) 1) 1)
                     (* (* (* (* (* (* (- 1) (exp 10 u51)) 10) 1)
                           (exp 10 eeb2))
                        1)
                     1)
                     (* (* (* (* (* (exp 10 u50) 10) 1) (exp 10 eeb2)) 1) 1)))
             (= (+ (* 1 1) (* (* (* (* (- 1) (exp 10 u51)) 10) 1) 1)
                (* (* (* (exp 10 u50) 10) 1) 1)) (str.to.int y))
             (<= u51 u50)
             (<= 0 u51))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* (- 10) (exp 10 eeb2) (exp 10 u51))
                     (* 10 (exp 10 eeb2) (exp 10 u50)) (exp 10 eeb2)))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 1 (* (- 10) (exp 10 u51)) (* 10 (exp 10 u50))) (str.to.int y))
             (<= u51 u50)
             (<= 0 u51))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* (- 10) (exp 10 (+ eeb2 u51)))
                     (* 10 (exp 10 (+ eeb2 u50))) (exp 10 eeb2)))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 1 (* (- 10) (exp 10 u51)) (* 10 (exp 10 u50))) (str.to.int y))
             (<= u51 u50)
             (<= 0 u51))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* (- 10) (exp 10 (+ eeb2 u51)))
            (* 10 (exp 10 (+ eeb2 u50))) (exp 10 eeb2)))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 1 (* (- 10) (exp 10 u51)) (* 10 (exp 10 u50))) (str.to.int y))
    (<= u51 u50)
    (<= 0 u51))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %25 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* (- 10) (exp 10 (+ eeb2 u51)))
            (* 10 (exp 10 (+ eeb2 u50))) (exp 10 eeb2)))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 1 (* (- 10) (exp 10 u51)) (* 10 (exp 10 u50))) %25)
    (<= u51 u50)
    (<= 0 u51))
  
  iter(1)= (and
             (= %25 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* (- 10) (exp 10 (+ eeb2 u51)))
                     (* 10 (exp 10 (+ eeb2 u50))) (exp 10 eeb2)))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 1 (* (- 10) (exp 10 u51)) (* 10 (exp 10 u50))) %25)
             (<= u51 u50)
             (<= 0 u51))
  iter(2)= (and
             (= %25 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* (- 10) (exp 10 (+ eeb2 u51)))
                     (* 10 (exp 10 (+ eeb2 u50))) (exp 10 eeb2)))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 1 (* (- 10) (exp 10 u51)) (* 10 (exp 10 u50))) %25)
             (<= u51 u50)
             (<= 0 u51))
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 1 eeb5) (* 1
                             (+ (* 1 eeb4)
                             (* 1
                             (* (+ (* 1
                                   (* (+ (* 1 (exp 10 u52))
                                      (* 1 (* (- 1) (exp 10 u53))))
                                   (exp 10 1)))
                                (* 1 2))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 1
                  (+ (* 1
                     (* (+ (* 1 (exp 10 u52)) (* 1 (* (- 1) (exp 10 u53))))
                     (exp 10 1)))
                  (* 1 2))) (* 1 (str.to.int y))))
             (<= (* 1 (* 1 u53)) (* 1 (* 1 u52)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u53))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= eeb5 (+ (* eeb4 1) (* (* (* 2 (exp 10 eeb2)) 1) 1)
                     (* (* (* (* (* (* (- 1) (exp 10 u53)) 10) 1)
                           (exp 10 eeb2))
                        1)
                     1)
                     (* (* (* (* (* (exp 10 u52) 10) 1) (exp 10 eeb2)) 1) 1)))
             (= (+ (* 2 1) (* (* (* (* (- 1) (exp 10 u53)) 10) 1) 1)
                (* (* (* (exp 10 u52) 10) 1) 1)) (str.to.int y))
             (<= u53 u52)
             (<= 0 u53))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* (- 10) (exp 10 eeb2) (exp 10 u53))
                     (* 2 (exp 10 eeb2)) (* 10 (exp 10 eeb2) (exp 10 u52))))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 2 (* (- 10) (exp 10 u53)) (* 10 (exp 10 u52))) (str.to.int y))
             (<= u53 u52)
             (<= 0 u53))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* (- 10) (exp 10 (+ eeb2 u53)))
                     (* 2 (exp 10 eeb2)) (* 10 (exp 10 (+ eeb2 u52)))))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 2 (* (- 10) (exp 10 u53)) (* 10 (exp 10 u52))) (str.to.int y))
             (<= u53 u52)
             (<= 0 u53))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* (- 10) (exp 10 (+ eeb2 u53))) (* 2 (exp 10 eeb2))
            (* 10 (exp 10 (+ eeb2 u52)))))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 2 (* (- 10) (exp 10 u53)) (* 10 (exp 10 u52))) (str.to.int y))
    (<= u53 u52)
    (<= 0 u53))
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %26 (str.to.int y))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 eeb2)
    (= eeb4 eeb4)
    (= eeb5 (+ eeb4 (* (- 10) (exp 10 (+ eeb2 u53))) (* 2 (exp 10 eeb2))
            (* 10 (exp 10 (+ eeb2 u52)))))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
    (= (+ 2 (* (- 10) (exp 10 u53)) (* 10 (exp 10 u52))) %26)
    (<= u53 u52)
    (<= 0 u53))
  
  iter(1)= (and
             (= %26 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= eeb5 (+ eeb4 (* (- 10) (exp 10 (+ eeb2 u53)))
                     (* 2 (exp 10 eeb2)) (* 10 (exp 10 (+ eeb2 u52)))))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 2 (* (- 10) (exp 10 u53)) (* 10 (exp 10 u52))) %26)
             (<= u53 u52)
             (<= 0 u53))
  iter(2)= (and
             (= %26 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* (- 10) (exp 10 (+ eeb2 u53)))
                     (* 2 (exp 10 eeb2)) (* 10 (exp 10 (+ eeb2 u52)))))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 2 (* (- 10) (exp 10 u53)) (* 10 (exp 10 u52))) %26)
             (<= u53 u52)
             (<= 0 u53))
  (= (str.++ "999" x) (str.++ y x))
  Looking for SAT in 27 asts...
  Simplify step: ((= eee10 (+ eeb2 u0)) & (= eee9 (+ eeb2 u1)) & (= %0 (str.to.int y)) & (= eeb2 (str.len x)) & (= eeb4 (str.to.int x)) & (= eeb5
  (+ eeb4 (* 999 (exp 10 eeb2)))) & (= (+ (* (- 1) (exp 10 u1)) (exp 10 u0)) %0) & (=
  (+ (* (- 1) (exp 10 eee9)) (* 9 eeb4) (exp 10 eee10)) eeb5) & (<= u1 u0) & (<= 0 u1))
  Simplified expression: (and
                           (= eee10 (+ eeb2 u0))
                           (= eee9 (+ eeb2 u1))
                           (= %0 (str.to.int y))
                           (= eeb2 (str.len x))
                           (= eeb4 (str.to.int x))
                           (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
                           (= (+ (* (- 1) (exp 10 u1)) (exp 10 u0)) %0)
                           (= (+ (* (- 1) (exp 10 eee9)) (* 9 eeb4)
                              (exp 10 eee10)) eeb5)
                           (<= u1 u0)
                           (<= 0 u1))
  strlen data:
  (chrob.len x) ~~> [%28]
  
  After strlen lowering:
  (and
    (= %28 (chrob.len x))
    (and
      (= (+ (* (- 1) u0) (* 1 eee10) (* (- 1) eeb2)) 0))
    (and
      (= (+ (* (- 1) u1) (* 1 eee9) (* (- 1) eeb2)) 0))
    (and
      (= (+ (* (- 1) y) (* 1 %0)) 0))
    (and
      (= (+ (* 1 eeb2) (* (- 1) %27)) 0)
      (= %28 %28)
      (= (+ (* 1 (exp 10 %27)) (* (- 1) %28)) 1))
    (and
      (= (+ (* (- 1) x) (* 1 eeb4)) 0))
    (and
      (= (+ (* (- 999) (exp 10 eeb2)) (* 1 eeb5) (* (- 1) eeb4)) 0))
    (and
      (= (+ (* (- 1) (exp 10 u1)) (* 1 (exp 10 u0)) (* (- 1) %0)) 0))
    (and
      (= (+ (* (- 1) (exp 10 eee9)) (* 1 (exp 10 eee10)) (* (- 1) eeb5)
         (* 9 eeb4)) 0))
    (and
      (<= (+ (* 1 u1) (* (- 1) u0)) 0))
    (and
      (<= (+ (* (- 1) u1)) 0)))
  
  iter(1)= (and
             (= %28 (chrob.len x))
             (and
               (= (+ (* (- 1) u0) (* 1 eee10) (* (- 1) eeb2)) 0))
             (and
               (= (+ (* (- 1) u1) (* 1 eee9) (* (- 1) eeb2)) 0))
             (and
               (= (+ (* (- 1) y) (* 1 %0)) 0))
             (and
               (= (+ (* 1 eeb2) (* (- 1) %27)) 0)
               (= %28 %28)
               (= (+ (* 1 (exp 10 %27)) (* (- 1) %28)) 1))
             (and
               (= (+ (* (- 1) x) (* 1 eeb4)) 0))
             (and
               (= (+ (* (- 999) (exp 10 eeb2)) (* 1 eeb5) (* (- 1) eeb4)) 0))
             (and
               (= (+ (* (- 1) (exp 10 u1)) (* 1 (exp 10 u0)) (* (- 1) %0)) 0))
             (and
               (= (+ (* (- 1) (exp 10 eee9)) (* 1 (exp 10 eee10))
                  (* (- 1) eeb5) (* 9 eeb4)) 0))
             (and
               (<= (+ (* 1 u1) (* (- 1) u0)) 0))
             (and
               (<= (+ (* (- 1) u1)) 0)))
  iter(2)= (and
             (= %28 (chrob.len x))
             (= (+ %0 (* (- 1) y)) 0)
             (= (+ eeb2 (* (- 1) %27)) 0)
             (= (+ eeb4 (* (- 1) x)) 0)
             (= (+ eeb5 (* (- 999) (exp 10 eeb2)) (* (- 1) eeb4)) 0)
             (= (+ eee10 (* (- 1) eeb2) (* (- 1) u0)) 0)
             (= (+ eee9 (* (- 1) eeb2) (* (- 1) u1)) 0)
             (= (+ (* (- 1) %0) (* (- 1) (exp 10 u1)) (exp 10 u0)) 0)
             (= (+ (* (- 1) %28) (exp 10 %27)) 1)
             (= (+ (* (- 1) eeb5) (* (- 1) (exp 10 eee9)) (* 9 eeb4)
                (exp 10 eee10)) 0)
             (<= (+ u1 (* (- 1) u0)) 0)
             (<= (* (- 1) u1) 0))
  Something ready to substitute:  %0 -> y; eeb2 -> %27; eeb4 -> x; eeb5 ->
                                 (+ (* (* (- 999) (exp 10 %27)) (- 1))
                                 (* (* (- 1) x) (- 1)));
  iter(3)= (and
             (= %28 (chrob.len x))
             (= (+ %0 (* (- 1) y)) 0)
             (= (+ eeb2 (* (- 1) %27)) 0)
             (= (+ eeb4 (* (- 1) x)) 0)
             (= (+ eeb5 (* (- 999) (exp 10 eeb2)) (* (- 1) eeb4)) 0)
             (= (+ eee10 (* (- 1) eeb2) (* (- 1) u0)) 0)
             (= (+ eee9 (* (- 1) eeb2) (* (- 1) u1)) 0)
             (= (+ (* (- 1) %0) (* (- 1) (exp 10 u1)) (exp 10 u0)) 0)
             (= (+ (* (- 1) %28) (exp 10 %27)) 1)
             (= (+ (* (- 1) eeb5) (* (- 1) (exp 10 eee9)) (* 9 eeb4)
                (exp 10 eee10)) 0)
             (<= (+ u1 (* (- 1) u0)) 0)
             (<= (* (- 1) u1) 0))
  iter(4)= (and
             (= %28 (chrob.len x))
             (= (+ eee10 (* (- 1) %27) (* (- 1) u0)) 0)
             (= (+ eee9 (* (- 1) %27) (* (- 1) u1)) 0)
             (= (+ (* (- 999) (exp 10 %27)) (* (- 1) x)
                (* (* (- 999) (exp 10 %27)) (- 1)) (* (* (- 1) x) (- 1))) 0)
             (= (+ (* (- 1) %28) (exp 10 %27)) 1)
             (= (+ (* (- 1) y) (* (- 1) (exp 10 u1)) (exp 10 u0)) 0)
             (= (+ (* (- 1) (exp 10 eee9)) (* 9 x)
                (* (* (* (- 999) (exp 10 %27)) (- 1)) (- 1))
                (* (* (* (- 1) x) (- 1)) (- 1)) (exp 10 eee10)) 0)
             (<= (+ u1 (* (- 1) u0)) 0)
             (<= (* (- 1) u1) 0))
  Something ready to substitute:  %0 -> y; eeb2 -> %27; eeb4 -> x; eeb5 ->
                                 (+ (* (* (- 999) (exp 10 %27)) (- 1))
                                 (* (* (- 1) x) (- 1))); y -> (+ (* (- 1)
                                                                 (exp 10 u1))
                                                              (exp 10 u0));
  iter(5)= (and
             (= %28 (chrob.len x))
             (= (+ eee10 (* (- 1) %27) (* (- 1) u0)) 0)
             (= (+ eee9 (* (- 1) %27) (* (- 1) u1)) 0)
             (= (+ (* (- 999) (exp 10 %27)) (* (- 1) (exp 10 eee9)) (* 8 x)
                (exp 10 eee10)) 0)
             (= (+ (* (- 1) %28) (exp 10 %27)) 1)
             (= (+ (* (- 1) y) (* (- 1) (exp 10 u1)) (exp 10 u0)) 0)
             (<= (+ u1 (* (- 1) u0)) 0)
             (<= (* (- 1) u1) 0))
  iter(6)= (and
             (= %28 (chrob.len x))
             (= (+ eee10 (* (- 1) %27) (* (- 1) u0)) 0)
             (= (+ eee9 (* (- 1) %27) (* (- 1) u1)) 0)
             (= (+ (* (- 999) (exp 10 %27)) (* (- 1) (exp 10 eee9)) (* 8 x)
                (exp 10 eee10)) 0)
             (= (+ (* (- 1) %28) (exp 10 %27)) 1)
             (= (+ (* (- 1) (exp 10 u1)) (* (* (- 1) (exp 10 u1)) (- 1))
                (* (exp 10 u0) (- 1)) (exp 10 u0)) 0)
             (<= (+ u1 (* (- 1) u0)) 0)
             (<= (* (- 1) u1) 0))
  iter(7)= (and
             (= %28 (chrob.len x))
             (= (+ eee10 (* (- 1) %27) (* (- 1) u0)) 0)
             (= (+ eee9 (* (- 1) %27) (* (- 1) u1)) 0)
             (= (+ (* (- 999) (exp 10 %27)) (* (- 1) (exp 10 eee9)) (* 8 x)
                (exp 10 eee10)) 0)
             (= (+ (* (- 1) %28) (exp 10 %27)) 1)
             (<= (+ u1 (* (- 1) u0)) 0)
             (<= (* (- 1) u1) 0))
  Something ready to substitute:  %0 -> y; eeb2 -> %27; eeb4 -> x; eeb5 ->
                                 (+ (* (* (- 999) (exp 10 %27)) (- 1))
                                 (* (* (- 1) x) (- 1))); u0 -> (+ eee10
                                                               (* (- 1) %27)); u1 ->
                                 (+ eee9 (* (- 1) %27)); y -> (+ (* (- 1)
                                                                 (exp 10 u1))
                                                              (exp 10 u0));
  iter(8)= (and
             (= %28 (chrob.len x))
             (= (+ eee10 (* (- 1) %27) (* (- 1) u0)) 0)
             (= (+ eee9 (* (- 1) %27) (* (- 1) u1)) 0)
             (= (+ (* (- 999) (exp 10 %27)) (* (- 1) (exp 10 eee9)) (* 8 x)
                (exp 10 eee10)) 0)
             (= (+ (* (- 1) %28) (exp 10 %27)) 1)
             (<= (+ u1 (* (- 1) u0)) 0)
             (<= (* (- 1) u1) 0))
  iter(9)= (and
             (= %28 (chrob.len x))
             (= (+ eee10 (* eee10 (- 1)) (* (- 1) %27) (* (* (- 1) %27) (- 1))) 0)
             (= (+ eee9 (* eee9 (- 1)) (* (- 1) %27) (* (* (- 1) %27) (- 1))) 0)
             (= (+ (* (- 999) (exp 10 %27)) (* (- 1) (exp 10 eee9)) (* 8 x)
                (exp 10 eee10)) 0)
             (= (+ (* (- 1) %28) (exp 10 %27)) 1)
             (<= (+ eee9 (* eee10 (- 1)) (* (- 1) %27) (* (* (- 1) %27) (- 1))) 0)
             (<= (+ (* eee9 (- 1)) (* (* (- 1) %27) (- 1))) 0))
  iter(10)= (and
              (= %28 (chrob.len x))
              (= (+ (* (- 999) (exp 10 %27)) (* (- 1) (exp 10 eee9)) (* 8 x)
                 (exp 10 eee10)) 0)
              (= (+ (* (- 1) %28) (exp 10 %27)) 1)
              (<= (+ %27 (* (- 1) eee9)) 0)
              (<= (+ eee9 (* (- 1) eee10)) 0))
  Simplify step: ((= %28 (chrob.len x)) & (= (+ (* (- 999) (exp 10 %27))
                                             (* (- 1) (exp 10 eee9)) (* 8 x)
                                             (exp 10 eee10)) 0) & (= (+
                                                                     (* (- 1)
                                                                     %28)
                                                                     (exp 10 %27)) 1) & (<= (exp 10 %27) (exp 10 eee9)) & (<= (exp 10 eee9) (exp 10 eee10)))
  Simplified expression: (and
                           (= %28 (chrob.len x))
                           (= (+ (* (- 999) (exp 10 %27))
                              (* (- 1) (exp 10 eee9)) (* 8 x) (exp 10 eee10)) 0)
                           (= (+ (* (- 1) %28) (exp 10 %27)) 1)
                           (<= (exp 10 %27) (exp 10 eee9))
                           (<= (exp 10 eee9) (exp 10 eee10)))
  (assert (exists (x)
          (and
            (exists (%28)
            (and
              (= %28 (chrob.len x))(= (+ (* (- 1) %28) pow2(%27) )  1)
              )
            (= (+ (* 8 x) (* (- 999) pow2(%27)) pow2(eee10)
               (* (- 1) pow2(eee9)) )
             0)
            (<= (+ pow2(%27) (* (- 1) pow2(eee9)) )  0)
            (<= (+ (* (- 1) pow2(eee10)) pow2(eee9) )  0)
            )
  )

  $ unset CHRO_DEBUG
  $ Chro -pre-simpl -dpresimpl -dsimpl 1.smt2 -flat 1 -under3 -bmax 2 | sed 's/[[:space:]]*$//'
  strlen data:
  
  strlen data:
  
  (= (str.++ "999" x) (str.++ y x))
  unknown
  ; Under2 resigns
  strlen data:
  (str.len x) ~~> [eeb2,eeb6]
  (str.to.int x) ~~> [eeb4,eeb8]
  (str.to.int y) ~~> [eeb7]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  strlen data:
  (str.len x) ~~> [eeb2]
  (str.to.int x) ~~> [eeb4]
  
  (= (str.++ "999" x) (str.++ y x))
  strlen data:
  (chrob.len x) ~~> [%28]
  
  (assert (exists (x)
          (and
            (exists (%28)
            (and
              (= %28 (chrob.len x))(= (+ (* (- 1) %28) pow2(%27) )  1)
              )
            (= (+ (* 8 x) (* (- 999) pow2(%27)) pow2(eee10)
               (* (- 1) pow2(eee9)) )
             0)
            (<= (+ pow2(%27) (* (- 1) pow2(eee9)) )  0)
            (<= (+ (* (- 1) pow2(eee10)) pow2(eee9) )  0)
            )
  )
  sat ; under III
