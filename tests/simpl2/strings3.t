  $ export CHRO_DEBUG=1
  $ cat strings3.smt2
  (set-logic QF_S)
  (declare-const x String)
  (declare-const y String)
  (assert (= (str.++ "999" x) (str.++ y x)))
  (check-sat)

$ Chro -pre-simpl -dpresimpl -dsimpl -stop-after simpl strings3.smt2 -flat 0 -under3 -bmax 1 | sed 's/[[:space:]]*$//'
  $ Chro -pre-simpl -dpresimpl -dsimpl -stop-after simpl strings3.smt2 -flat 0 -under3 -bmax 1 #| head -n 50
  strlen data:
  
  After strlen lowering:
  (and
    (= (str.++ "999" x) (str.++ y x)))
  
  iter(1)= (and
             (= (str.++ "999" x) (str.++ y x)))
  iter(2)= (= (str.++ "999" x) (str.++ y x))
  vars_for_under2: 
  
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
  (str.len x) ~~> eeb2
  (str.to.int x) ~~> eeb4
  (str.to.int y) ~~> eeb7
  
  After strlen lowering:
  (and
    (= eeb8 (str.to.int x))
    (= eeb7 (str.to.int y))
    (= eeb6 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb2 (str.len x))
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
             (= eeb8 (str.to.int x))
             (= eeb7 (str.to.int y))
             (= eeb6 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 (str.len x))
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
             (= eeb6 (str.len x))
             (= eeb7 (str.to.int y))
             (= eeb8 eeb4)
             (= eeb8 (str.to.int x))
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
  
  strlen data:
  
  run_underapprox2: After strlen lowering:
  (and
    (= %2 (str.len y))
    (= %1 (str.len x))
    (= %0 (str.len x))
    (and
      (= (* 1 eeb2) (* 1 %0))
      (= (* 1 eeb4) (* 1 %1))
      (= (* 9 eeb5) (* 9
                    (+ (* 9 eeb4)
                    (* 1
                    (* (+ (* 1 (* (+ (* 1 (exp 10 u0))) (exp 10 0))) (* 9 0))
                    (exp 10 eeb2))))))
      (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
      (= (* 9 (+ (* 1 (* (+ (* 1 (exp 10 u0))) (exp 10 0))) (* 9 0))) (* 9 %2)))
    (<= (* 1 (* 1 0)) (* 1 (* 1 u0))))
  
  iter(1)= (and
             (= %2 (str.len y))
             (= %1 (str.len x))
             (= %0 (str.len x))
             (and
               (= (* 1 eeb2) (* 1 %0))
               (= (* 1 eeb4) (* 1 %1))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 1 (* (+ (* 1 (exp 10 u0))) (exp 10 0)))
                                (* 9 0))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9 (+ (* 1 (* (+ (* 1 (exp 10 u0))) (exp 10 0))) (* 9 0))) 
               (* 9 %2)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u0))))
  iter(2)= (and
             (= %0 (str.len x))
             (= %1 (str.len x))
             (= %2 (str.len y))
             (= eeb2 %0)
             (= eeb4 %1)
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9) (* (exp 10 (+ u0 eeb2)) 9)))
             (= (exp 10 u0) %2)
             (<= 0 u0))
  Something ready to substitute:  eeb2 -> %0; eeb4 -> %1; 
  iter(3)= (and
             (= %0 (str.len x))
             (= %1 (str.len x))
             (= %2 (str.len y))
             (= eeb2 %0)
             (= eeb4 %1)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (* 9 eeb5) (+ (* 9 (exp 10 (+ eeb2 u0))) (* 81 eeb4)))
             (= (exp 10 u0) %2)
             (<= 0 u0))
  iter(4)= (and
             (= %0 (str.len x))
             (= %1 (str.len x))
             (= %2 (str.len y))
             (= eeb5 (+ %1 (* 999 (exp 10 %0))))
             (= (* 9 eeb5) (+ (* 9 (exp 10 (+ %0 u0))) (* 81 %1)))
             (= (exp 10 u0) %2)
             (<= 0 u0))
  strlen data:
  
  run_underapprox2: After strlen lowering:
  (and
    (= %5 (str.len y))
    (= %4 (str.len x))
    (= %3 (str.len x))
    (and
      (= (* 1 eeb2) (* 1 %3))
      (= (* 1 eeb4) (* 1 %4))
      (= (* 9 eeb5) (* 9
                    (+ (* 9 eeb4)
                    (* 1
                    (* (+ (* 1 (* (+ (* 1 (exp 10 u1))) (exp 10 1))) (* 9 1))
                    (exp 10 eeb2))))))
      (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
      (= (* 9 (+ (* 1 (* (+ (* 1 (exp 10 u1))) (exp 10 1))) (* 9 1))) (* 9 %5)))
    (<= (* 1 (* 1 0)) (* 1 (* 1 u1))))
  
  iter(1)= (and
             (= %5 (str.len y))
             (= %4 (str.len x))
             (= %3 (str.len x))
             (and
               (= (* 1 eeb2) (* 1 %3))
               (= (* 1 eeb4) (* 1 %4))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 1 (* (+ (* 1 (exp 10 u1))) (exp 10 1)))
                                (* 9 1))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9 (+ (* 1 (* (+ (* 1 (exp 10 u1))) (exp 10 1))) (* 9 1))) 
               (* 9 %5)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u1))))
  iter(2)= (and
             (= %3 (str.len x))
             (= %4 (str.len x))
             (= %5 (str.len y))
             (= eeb2 %3)
             (= eeb4 %4)
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 9 9) (* (* 10 (exp 10 u1)) 9)) (* 9 %5))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9) (* (* (* 9 (exp 10 eeb2)) 1) 9)
                           (* (* (* (* 10 (exp 10 u1)) (exp 10 eeb2)) 1) 9)))
             (<= 0 u1))
  Something ready to substitute:  eeb2 -> %3; eeb4 -> %4; 
  iter(3)= (and
             (= %3 (str.len x))
             (= %4 (str.len x))
             (= %5 (str.len y))
             (= eeb2 %3)
             (= eeb4 %4)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 81 (* 90 (exp 10 u1))) (* 9 %5))
             (= (* 9 eeb5) (+ (* 81 eeb4) (* 81 (exp 10 eeb2))
                           (* 90 (exp 10 eeb2) (exp 10 u1))))
             (<= 0 u1))
  iter(4)= (and
             (= %3 (str.len x))
             (= %4 (str.len x))
             (= %5 (str.len y))
             (= eeb5 (+ %4 (* 999 (exp 10 %3))))
             (= (+ 81 (* 90 (exp 10 u1))) (* 9 %5))
             (= (* 9 eeb5) (+ (* 81 %4) (* 81 (exp 10 %3))
                           (* 90 (exp 10 (+ %3 u1)))))
             (<= 0 u1))
  strlen data:
  
  run_underapprox2: After strlen lowering:
  (and
    (= %8 (str.len y))
    (= %7 (str.len x))
    (= %6 (str.len x))
    (and
      (= (* 1 eeb2) (* 1 %6))
      (= (* 1 eeb4) (* 1 %7))
      (= (* 9 eeb5) (* 9
                    (+ (* 9 eeb4)
                    (* 1
                    (* (+ (* 2 (* (+ (* 1 (exp 10 u2))) (exp 10 0))) (* 9 0))
                    (exp 10 eeb2))))))
      (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
      (= (* 9 (+ (* 2 (* (+ (* 1 (exp 10 u2))) (exp 10 0))) (* 9 0))) (* 9 %8)))
    (<= (* 1 (* 1 0)) (* 1 (* 1 u2))))
  
  iter(1)= (and
             (= %8 (str.len y))
             (= %7 (str.len x))
             (= %6 (str.len x))
             (and
               (= (* 1 eeb2) (* 1 %6))
               (= (* 1 eeb4) (* 1 %7))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 2 (* (+ (* 1 (exp 10 u2))) (exp 10 0)))
                                (* 9 0))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9 (+ (* 2 (* (+ (* 1 (exp 10 u2))) (exp 10 0))) (* 9 0))) 
               (* 9 %8)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u2))))
  iter(2)= (and
             (= %6 (str.len x))
             (= %7 (str.len x))
             (= %8 (str.len y))
             (= eeb2 %6)
             (= eeb4 %7)
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (* 2 (exp 10 u2)) %8)
             (= (* 9 eeb5) (+ (* (* 2 (exp 10 eeb2) (exp 10 u2)) 9)
                           (* (* 9 eeb4) 9)))
             (<= 0 u2))
  Something ready to substitute:  eeb2 -> %6; eeb4 -> %7; 
  iter(3)= (and
             (= %6 (str.len x))
             (= %7 (str.len x))
             (= %8 (str.len y))
             (= eeb2 %6)
             (= eeb4 %7)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (* 2 (exp 10 u2)) %8)
             (= (* 9 eeb5) (+ (* 18 (exp 10 (+ eeb2 u2))) (* 81 eeb4)))
             (<= 0 u2))
  iter(4)= (and
             (= %6 (str.len x))
             (= %7 (str.len x))
             (= %8 (str.len y))
             (= eeb5 (+ %7 (* 999 (exp 10 %6))))
             (= (* 2 (exp 10 u2)) %8)
             (= (* 9 eeb5) (+ (* 18 (exp 10 (+ %6 u2))) (* 81 %7)))
             (<= 0 u2))
  strlen data:
  
  run_underapprox2: After strlen lowering:
  (and
    (= %9 (str.len x))
    (= %11 (str.len y))
    (= %10 (str.len x))
    (and
      (= (* 1 eeb2) (* 1 %9))
      (= (* 1 eeb4) (* 1 %10))
      (= (* 9 eeb5) (* 9
                    (+ (* 9 eeb4)
                    (* 1
                    (* (+ (* 2 (* (+ (* 1 (exp 10 u3))) (exp 10 1))) (* 9 1))
                    (exp 10 eeb2))))))
      (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
      (= (* 9 (+ (* 2 (* (+ (* 1 (exp 10 u3))) (exp 10 1))) (* 9 1))) (* 9 %11)))
    (<= (* 1 (* 1 0)) (* 1 (* 1 u3))))
  
  iter(1)= (and
             (= %9 (str.len x))
             (= %11 (str.len y))
             (= %10 (str.len x))
             (and
               (= (* 1 eeb2) (* 1 %9))
               (= (* 1 eeb4) (* 1 %10))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 2 (* (+ (* 1 (exp 10 u3))) (exp 10 1)))
                                (* 9 1))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9 (+ (* 2 (* (+ (* 1 (exp 10 u3))) (exp 10 1))) (* 9 1))) 
               (* 9 %11)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u3))))
  iter(2)= (and
             (= %10 (str.len x))
             (= %11 (str.len y))
             (= %9 (str.len x))
             (= eeb2 %9)
             (= eeb4 %10)
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 9 9) (* (* 20 (exp 10 u3)) 9)) (* 9 %11))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9) (* (* (* 9 (exp 10 eeb2)) 1) 9)
                           (* (* (* (* 20 (exp 10 u3)) (exp 10 eeb2)) 1) 9)))
             (<= 0 u3))
  Something ready to substitute:  eeb2 -> %9; eeb4 -> %10; 
  iter(3)= (and
             (= %10 (str.len x))
             (= %11 (str.len y))
             (= %9 (str.len x))
             (= eeb2 %9)
             (= eeb4 %10)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 81 (* 180 (exp 10 u3))) (* 9 %11))
             (= (* 9 eeb5) (+ (* 81 eeb4) (* 81 (exp 10 eeb2))
                           (* 180 (exp 10 eeb2) (exp 10 u3))))
             (<= 0 u3))
  iter(4)= (and
             (= %10 (str.len x))
             (= %11 (str.len y))
             (= %9 (str.len x))
             (= eeb5 (+ %10 (* 999 (exp 10 %9))))
             (= (+ 81 (* 180 (exp 10 u3))) (* 9 %11))
             (= (* 9 eeb5) (+ (* 81 %10) (* 81 (exp 10 %9))
                           (* 180 (exp 10 (+ %9 u3)))))
             (<= 0 u3))
  strlen data:
  
  run_underapprox2: After strlen lowering:
  (and
    (= %14 (str.len y))
    (= %13 (str.len x))
    (= %12 (str.len x))
    (and
      (= (* 1 eeb2) (* 1 %12))
      (= (* 1 eeb4) (* 1 %13))
      (= (* 3 eeb5) (* 3
                    (+ (* 3 eeb4)
                    (* 1
                    (* (+ (* 1 (* (+ (* 1 (exp 10 u4))) (exp 10 0))) (* 3 0))
                    (exp 10 eeb2))))))
      (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
      (= (* 3 (+ (* 1 (* (+ (* 1 (exp 10 u4))) (exp 10 0))) (* 3 0))) (* 3 %14)))
    (<= (* 1 (* 1 0)) (* 1 (* 1 u4))))
  
  iter(1)= (and
             (= %14 (str.len y))
             (= %13 (str.len x))
             (= %12 (str.len x))
             (and
               (= (* 1 eeb2) (* 1 %12))
               (= (* 1 eeb4) (* 1 %13))
               (= (* 3 eeb5) (* 3
                             (+ (* 3 eeb4)
                             (* 1
                             (* (+ (* 1 (* (+ (* 1 (exp 10 u4))) (exp 10 0)))
                                (* 3 0))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 3 (+ (* 1 (* (+ (* 1 (exp 10 u4))) (exp 10 0))) (* 3 0))) 
               (* 3 %14)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u4))))
  iter(2)= (and
             (= %12 (str.len x))
             (= %13 (str.len x))
             (= %14 (str.len y))
             (= eeb2 %12)
             (= eeb4 %13)
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (* 3 eeb5) (+ (* (* 3 eeb4) 3) (* (exp 10 (+ u4 eeb2)) 3)))
             (= (exp 10 u4) %14)
             (<= 0 u4))
  Something ready to substitute:  eeb2 -> %12; eeb4 -> %13; 
  iter(3)= (and
             (= %12 (str.len x))
             (= %13 (str.len x))
             (= %14 (str.len y))
             (= eeb2 %12)
             (= eeb4 %13)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (* 3 eeb5) (+ (* 3 (exp 10 (+ eeb2 u4))) (* 9 eeb4)))
             (= (exp 10 u4) %14)
             (<= 0 u4))
  iter(4)= (and
             (= %12 (str.len x))
             (= %13 (str.len x))
             (= %14 (str.len y))
             (= eeb5 (+ %13 (* 999 (exp 10 %12))))
             (= (* 3 eeb5) (+ (* 3 (exp 10 (+ %12 u4))) (* 9 %13)))
             (= (exp 10 u4) %14)
             (<= 0 u4))
  strlen data:
  
  run_underapprox2: After strlen lowering:
  (and
    (= %17 (str.len y))
    (= %16 (str.len x))
    (= %15 (str.len x))
    (and
      (= (* 1 eeb2) (* 1 %15))
      (= (* 1 eeb4) (* 1 %16))
      (= (* 3 eeb5) (* 3
                    (+ (* 3 eeb4)
                    (* 1
                    (* (+ (* 1 (* (+ (* 1 (exp 10 u5))) (exp 10 1))) (* 3 1))
                    (exp 10 eeb2))))))
      (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
      (= (* 3 (+ (* 1 (* (+ (* 1 (exp 10 u5))) (exp 10 1))) (* 3 1))) (* 3 %17)))
    (<= (* 1 (* 1 0)) (* 1 (* 1 u5))))
  
  iter(1)= (and
             (= %17 (str.len y))
             (= %16 (str.len x))
             (= %15 (str.len x))
             (and
               (= (* 1 eeb2) (* 1 %15))
               (= (* 1 eeb4) (* 1 %16))
               (= (* 3 eeb5) (* 3
                             (+ (* 3 eeb4)
                             (* 1
                             (* (+ (* 1 (* (+ (* 1 (exp 10 u5))) (exp 10 1)))
                                (* 3 1))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 3 (+ (* 1 (* (+ (* 1 (exp 10 u5))) (exp 10 1))) (* 3 1))) 
               (* 3 %17)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u5))))
  iter(2)= (and
             (= %15 (str.len x))
             (= %16 (str.len x))
             (= %17 (str.len y))
             (= eeb2 %15)
             (= eeb4 %16)
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 3 3) (* (* 10 (exp 10 u5)) 3)) (* 3 %17))
             (= (* 3 eeb5) (+ (* (* 3 eeb4) 3) (* (* (* 3 (exp 10 eeb2)) 1) 3)
                           (* (* (* (* 10 (exp 10 u5)) (exp 10 eeb2)) 1) 3)))
             (<= 0 u5))
  Something ready to substitute:  eeb2 -> %15; eeb4 -> %16; 
  iter(3)= (and
             (= %15 (str.len x))
             (= %16 (str.len x))
             (= %17 (str.len y))
             (= eeb2 %15)
             (= eeb4 %16)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* 30 (exp 10 u5))) (* 3 %17))
             (= (* 3 eeb5) (+ (* 9 eeb4) (* 9 (exp 10 eeb2))
                           (* 30 (exp 10 eeb2) (exp 10 u5))))
             (<= 0 u5))
  iter(4)= (and
             (= %15 (str.len x))
             (= %16 (str.len x))
             (= %17 (str.len y))
             (= eeb5 (+ %16 (* 999 (exp 10 %15))))
             (= (+ 9 (* 30 (exp 10 u5))) (* 3 %17))
             (= (* 3 eeb5) (+ (* 9 %16) (* 9 (exp 10 %15))
                           (* 30 (exp 10 (+ %15 u5)))))
             (<= 0 u5))
  strlen data:
  
  run_underapprox2: After strlen lowering:
  (and
    (= %20 (str.len y))
    (= %19 (str.len x))
    (= %18 (str.len x))
    (and
      (= (* 1 eeb2) (* 1 %18))
      (= (* 1 eeb4) (* 1 %19))
      (= (* 9 eeb5) (* 9
                    (+ (* 9 eeb4)
                    (* 1
                    (* (+ (* 4 (* (+ (* 1 (exp 10 u6))) (exp 10 0))) (* 9 0))
                    (exp 10 eeb2))))))
      (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
      (= (* 9 (+ (* 4 (* (+ (* 1 (exp 10 u6))) (exp 10 0))) (* 9 0))) (* 9 %20)))
    (<= (* 1 (* 1 0)) (* 1 (* 1 u6))))
  
  iter(1)= (and
             (= %20 (str.len y))
             (= %19 (str.len x))
             (= %18 (str.len x))
             (and
               (= (* 1 eeb2) (* 1 %18))
               (= (* 1 eeb4) (* 1 %19))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 4 (* (+ (* 1 (exp 10 u6))) (exp 10 0)))
                                (* 9 0))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9 (+ (* 4 (* (+ (* 1 (exp 10 u6))) (exp 10 0))) (* 9 0))) 
               (* 9 %20)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u6))))
  iter(2)= (and
             (= %18 (str.len x))
             (= %19 (str.len x))
             (= %20 (str.len y))
             (= eeb2 %18)
             (= eeb4 %19)
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (* 4 (exp 10 u6)) %20)
             (= (* 9 eeb5) (+ (* (* 4 (exp 10 eeb2) (exp 10 u6)) 9)
                           (* (* 9 eeb4) 9)))
             (<= 0 u6))
  Something ready to substitute:  eeb2 -> %18; eeb4 -> %19; 
  iter(3)= (and
             (= %18 (str.len x))
             (= %19 (str.len x))
             (= %20 (str.len y))
             (= eeb2 %18)
             (= eeb4 %19)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (* 4 (exp 10 u6)) %20)
             (= (* 9 eeb5) (+ (* 36 (exp 10 (+ eeb2 u6))) (* 81 eeb4)))
             (<= 0 u6))
  iter(4)= (and
             (= %18 (str.len x))
             (= %19 (str.len x))
             (= %20 (str.len y))
             (= eeb5 (+ %19 (* 999 (exp 10 %18))))
             (= (* 4 (exp 10 u6)) %20)
             (= (* 9 eeb5) (+ (* 36 (exp 10 (+ %18 u6))) (* 81 %19)))
             (<= 0 u6))
  strlen data:
  
  run_underapprox2: After strlen lowering:
  (and
    (= %23 (str.len y))
    (= %22 (str.len x))
    (= %21 (str.len x))
    (and
      (= (* 1 eeb2) (* 1 %21))
      (= (* 1 eeb4) (* 1 %22))
      (= (* 9 eeb5) (* 9
                    (+ (* 9 eeb4)
                    (* 1
                    (* (+ (* 4 (* (+ (* 1 (exp 10 u7))) (exp 10 1))) (* 9 1))
                    (exp 10 eeb2))))))
      (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
      (= (* 9 (+ (* 4 (* (+ (* 1 (exp 10 u7))) (exp 10 1))) (* 9 1))) (* 9 %23)))
    (<= (* 1 (* 1 0)) (* 1 (* 1 u7))))
  
  iter(1)= (and
             (= %23 (str.len y))
             (= %22 (str.len x))
             (= %21 (str.len x))
             (and
               (= (* 1 eeb2) (* 1 %21))
               (= (* 1 eeb4) (* 1 %22))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 4 (* (+ (* 1 (exp 10 u7))) (exp 10 1)))
                                (* 9 1))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9 (+ (* 4 (* (+ (* 1 (exp 10 u7))) (exp 10 1))) (* 9 1))) 
               (* 9 %23)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u7))))
  iter(2)= (and
             (= %21 (str.len x))
             (= %22 (str.len x))
             (= %23 (str.len y))
             (= eeb2 %21)
             (= eeb4 %22)
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 9 9) (* (* 40 (exp 10 u7)) 9)) (* 9 %23))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9) (* (* (* 9 (exp 10 eeb2)) 1) 9)
                           (* (* (* (* 40 (exp 10 u7)) (exp 10 eeb2)) 1) 9)))
             (<= 0 u7))
  Something ready to substitute:  eeb2 -> %21; eeb4 -> %22; 
  iter(3)= (and
             (= %21 (str.len x))
             (= %22 (str.len x))
             (= %23 (str.len y))
             (= eeb2 %21)
             (= eeb4 %22)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 81 (* 360 (exp 10 u7))) (* 9 %23))
             (= (* 9 eeb5) (+ (* 81 eeb4) (* 81 (exp 10 eeb2))
                           (* 360 (exp 10 eeb2) (exp 10 u7))))
             (<= 0 u7))
  iter(4)= (and
             (= %21 (str.len x))
             (= %22 (str.len x))
             (= %23 (str.len y))
             (= eeb5 (+ %22 (* 999 (exp 10 %21))))
             (= (+ 81 (* 360 (exp 10 u7))) (* 9 %23))
             (= (* 9 eeb5) (+ (* 81 %22) (* 81 (exp 10 %21))
                           (* 360 (exp 10 (+ %21 u7)))))
             (<= 0 u7))
  strlen data:
  
  run_underapprox2: After strlen lowering:
  (and
    (= %26 (str.len y))
    (= %25 (str.len x))
    (= %24 (str.len x))
    (and
      (= (* 1 eeb2) (* 1 %24))
      (= (* 1 eeb4) (* 1 %25))
      (= (* 9 eeb5) (* 9
                    (+ (* 9 eeb4)
                    (* 1
                    (* (+ (* 5 (* (+ (* 1 (exp 10 u8))) (exp 10 0))) (* 9 0))
                    (exp 10 eeb2))))))
      (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
      (= (* 9 (+ (* 5 (* (+ (* 1 (exp 10 u8))) (exp 10 0))) (* 9 0))) (* 9 %26)))
    (<= (* 1 (* 1 0)) (* 1 (* 1 u8))))
  
  iter(1)= (and
             (= %26 (str.len y))
             (= %25 (str.len x))
             (= %24 (str.len x))
             (and
               (= (* 1 eeb2) (* 1 %24))
               (= (* 1 eeb4) (* 1 %25))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 5 (* (+ (* 1 (exp 10 u8))) (exp 10 0)))
                                (* 9 0))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9 (+ (* 5 (* (+ (* 1 (exp 10 u8))) (exp 10 0))) (* 9 0))) 
               (* 9 %26)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u8))))
  iter(2)= (and
             (= %24 (str.len x))
             (= %25 (str.len x))
             (= %26 (str.len y))
             (= eeb2 %24)
             (= eeb4 %25)
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (* 5 (exp 10 u8)) %26)
             (= (* 9 eeb5) (+ (* (* 5 (exp 10 eeb2) (exp 10 u8)) 9)
                           (* (* 9 eeb4) 9)))
             (<= 0 u8))
  Something ready to substitute:  eeb2 -> %24; eeb4 -> %25; 
  iter(3)= (and
             (= %24 (str.len x))
             (= %25 (str.len x))
             (= %26 (str.len y))
             (= eeb2 %24)
             (= eeb4 %25)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (* 5 (exp 10 u8)) %26)
             (= (* 9 eeb5) (+ (* 45 (exp 10 (+ eeb2 u8))) (* 81 eeb4)))
             (<= 0 u8))
  iter(4)= (and
             (= %24 (str.len x))
             (= %25 (str.len x))
             (= %26 (str.len y))
             (= eeb5 (+ %25 (* 999 (exp 10 %24))))
             (= (* 5 (exp 10 u8)) %26)
             (= (* 9 eeb5) (+ (* 45 (exp 10 (+ %24 u8))) (* 81 %25)))
             (<= 0 u8))
  strlen data:
  
  run_underapprox2: After strlen lowering:
  (and
    (= %29 (str.len y))
    (= %28 (str.len x))
    (= %27 (str.len x))
    (and
      (= (* 1 eeb2) (* 1 %27))
      (= (* 1 eeb4) (* 1 %28))
      (= (* 9 eeb5) (* 9
                    (+ (* 9 eeb4)
                    (* 1
                    (* (+ (* 5 (* (+ (* 1 (exp 10 u9))) (exp 10 1))) (* 9 1))
                    (exp 10 eeb2))))))
      (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
      (= (* 9 (+ (* 5 (* (+ (* 1 (exp 10 u9))) (exp 10 1))) (* 9 1))) (* 9 %29)))
    (<= (* 1 (* 1 0)) (* 1 (* 1 u9))))
  
  iter(1)= (and
             (= %29 (str.len y))
             (= %28 (str.len x))
             (= %27 (str.len x))
             (and
               (= (* 1 eeb2) (* 1 %27))
               (= (* 1 eeb4) (* 1 %28))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 5 (* (+ (* 1 (exp 10 u9))) (exp 10 1)))
                                (* 9 1))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9 (+ (* 5 (* (+ (* 1 (exp 10 u9))) (exp 10 1))) (* 9 1))) 
               (* 9 %29)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u9))))
  iter(2)= (and
             (= %27 (str.len x))
             (= %28 (str.len x))
             (= %29 (str.len y))
             (= eeb2 %27)
             (= eeb4 %28)
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 9 9) (* (* 50 (exp 10 u9)) 9)) (* 9 %29))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9) (* (* (* 9 (exp 10 eeb2)) 1) 9)
                           (* (* (* (* 50 (exp 10 u9)) (exp 10 eeb2)) 1) 9)))
             (<= 0 u9))
  Something ready to substitute:  eeb2 -> %27; eeb4 -> %28; 
  iter(3)= (and
             (= %27 (str.len x))
             (= %28 (str.len x))
             (= %29 (str.len y))
             (= eeb2 %27)
             (= eeb4 %28)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 81 (* 450 (exp 10 u9))) (* 9 %29))
             (= (* 9 eeb5) (+ (* 81 eeb4) (* 81 (exp 10 eeb2))
                           (* 450 (exp 10 eeb2) (exp 10 u9))))
             (<= 0 u9))
  iter(4)= (and
             (= %27 (str.len x))
             (= %28 (str.len x))
             (= %29 (str.len y))
             (= eeb5 (+ %28 (* 999 (exp 10 %27))))
             (= (+ 81 (* 450 (exp 10 u9))) (* 9 %29))
             (= (* 9 eeb5) (+ (* 81 %28) (* 81 (exp 10 %27))
                           (* 450 (exp 10 (+ %27 u9)))))
             (<= 0 u9))
  strlen data:
  
  run_underapprox2: After strlen lowering:
  (and
    (= %32 (str.len y))
    (= %31 (str.len x))
    (= %30 (str.len x))
    (and
      (= (* 1 eeb2) (* 1 %30))
      (= (* 1 eeb4) (* 1 %31))
      (= (* 3 eeb5) (* 3
                    (+ (* 3 eeb4)
                    (* 1
                    (* (+ (* 2 (* (+ (* 1 (exp 10 u10))) (exp 10 0))) (* 3 0))
                    (exp 10 eeb2))))))
      (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
      (= (* 3 (+ (* 2 (* (+ (* 1 (exp 10 u10))) (exp 10 0))) (* 3 0))) 
      (* 3 %32)))
    (<= (* 1 (* 1 0)) (* 1 (* 1 u10))))
  
  iter(1)= (and
             (= %32 (str.len y))
             (= %31 (str.len x))
             (= %30 (str.len x))
             (and
               (= (* 1 eeb2) (* 1 %30))
               (= (* 1 eeb4) (* 1 %31))
               (= (* 3 eeb5) (* 3
                             (+ (* 3 eeb4)
                             (* 1
                             (* (+ (* 2 (* (+ (* 1 (exp 10 u10))) (exp 10 0)))
                                (* 3 0))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 3 (+ (* 2 (* (+ (* 1 (exp 10 u10))) (exp 10 0))) (* 3 0))) 
               (* 3 %32)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u10))))
  iter(2)= (and
             (= %30 (str.len x))
             (= %31 (str.len x))
             (= %32 (str.len y))
             (= eeb2 %30)
             (= eeb4 %31)
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (* 2 (exp 10 u10)) %32)
             (= (* 3 eeb5) (+ (* (* 2 (exp 10 eeb2) (exp 10 u10)) 3)
                           (* (* 3 eeb4) 3)))
             (<= 0 u10))
  Something ready to substitute:  eeb2 -> %30; eeb4 -> %31; 
  iter(3)= (and
             (= %30 (str.len x))
             (= %31 (str.len x))
             (= %32 (str.len y))
             (= eeb2 %30)
             (= eeb4 %31)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (* 2 (exp 10 u10)) %32)
             (= (* 3 eeb5) (+ (* 6 (exp 10 (+ eeb2 u10))) (* 9 eeb4)))
             (<= 0 u10))
  iter(4)= (and
             (= %30 (str.len x))
             (= %31 (str.len x))
             (= %32 (str.len y))
             (= eeb5 (+ %31 (* 999 (exp 10 %30))))
             (= (* 2 (exp 10 u10)) %32)
             (= (* 3 eeb5) (+ (* 6 (exp 10 (+ %30 u10))) (* 9 %31)))
             (<= 0 u10))
  strlen data:
  
  run_underapprox2: After strlen lowering:
  (and
    (= %35 (str.len y))
    (= %34 (str.len x))
    (= %33 (str.len x))
    (and
      (= (* 1 eeb2) (* 1 %33))
      (= (* 1 eeb4) (* 1 %34))
      (= (* 3 eeb5) (* 3
                    (+ (* 3 eeb4)
                    (* 1
                    (* (+ (* 2 (* (+ (* 1 (exp 10 u11))) (exp 10 1))) (* 3 1))
                    (exp 10 eeb2))))))
      (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
      (= (* 3 (+ (* 2 (* (+ (* 1 (exp 10 u11))) (exp 10 1))) (* 3 1))) 
      (* 3 %35)))
    (<= (* 1 (* 1 0)) (* 1 (* 1 u11))))
  
  iter(1)= (and
             (= %35 (str.len y))
             (= %34 (str.len x))
             (= %33 (str.len x))
             (and
               (= (* 1 eeb2) (* 1 %33))
               (= (* 1 eeb4) (* 1 %34))
               (= (* 3 eeb5) (* 3
                             (+ (* 3 eeb4)
                             (* 1
                             (* (+ (* 2 (* (+ (* 1 (exp 10 u11))) (exp 10 1)))
                                (* 3 1))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 3 (+ (* 2 (* (+ (* 1 (exp 10 u11))) (exp 10 1))) (* 3 1))) 
               (* 3 %35)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u11))))
  iter(2)= (and
             (= %33 (str.len x))
             (= %34 (str.len x))
             (= %35 (str.len y))
             (= eeb2 %33)
             (= eeb4 %34)
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 3 3) (* (* 20 (exp 10 u11)) 3)) (* 3 %35))
             (= (* 3 eeb5) (+ (* (* 3 eeb4) 3) (* (* (* 3 (exp 10 eeb2)) 1) 3)
                           (* (* (* (* 20 (exp 10 u11)) (exp 10 eeb2)) 1) 3)))
             (<= 0 u11))
  Something ready to substitute:  eeb2 -> %33; eeb4 -> %34; 
  iter(3)= (and
             (= %33 (str.len x))
             (= %34 (str.len x))
             (= %35 (str.len y))
             (= eeb2 %33)
             (= eeb4 %34)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 9 (* 60 (exp 10 u11))) (* 3 %35))
             (= (* 3 eeb5) (+ (* 9 eeb4) (* 9 (exp 10 eeb2))
                           (* 60 (exp 10 eeb2) (exp 10 u11))))
             (<= 0 u11))
  iter(4)= (and
             (= %33 (str.len x))
             (= %34 (str.len x))
             (= %35 (str.len y))
             (= eeb5 (+ %34 (* 999 (exp 10 %33))))
             (= (+ 9 (* 60 (exp 10 u11))) (* 3 %35))
             (= (* 3 eeb5) (+ (* 9 %34) (* 9 (exp 10 %33))
                           (* 60 (exp 10 (+ %33 u11)))))
             (<= 0 u11))
  strlen data:
  
  run_underapprox2: After strlen lowering:
  (and
    (= %38 (str.len y))
    (= %37 (str.len x))
    (= %36 (str.len x))
    (and
      (= (* 1 eeb2) (* 1 %36))
      (= (* 1 eeb4) (* 1 %37))
      (= (* 9 eeb5) (* 9
                    (+ (* 9 eeb4)
                    (* 1
                    (* (+ (* 7 (* (+ (* 1 (exp 10 u12))) (exp 10 0))) (* 9 0))
                    (exp 10 eeb2))))))
      (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
      (= (* 9 (+ (* 7 (* (+ (* 1 (exp 10 u12))) (exp 10 0))) (* 9 0))) 
      (* 9 %38)))
    (<= (* 1 (* 1 0)) (* 1 (* 1 u12))))
  
  iter(1)= (and
             (= %38 (str.len y))
             (= %37 (str.len x))
             (= %36 (str.len x))
             (and
               (= (* 1 eeb2) (* 1 %36))
               (= (* 1 eeb4) (* 1 %37))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 7 (* (+ (* 1 (exp 10 u12))) (exp 10 0)))
                                (* 9 0))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9 (+ (* 7 (* (+ (* 1 (exp 10 u12))) (exp 10 0))) (* 9 0))) 
               (* 9 %38)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u12))))
  iter(2)= (and
             (= %36 (str.len x))
             (= %37 (str.len x))
             (= %38 (str.len y))
             (= eeb2 %36)
             (= eeb4 %37)
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (* 7 (exp 10 u12)) %38)
             (= (* 9 eeb5) (+ (* (* 7 (exp 10 eeb2) (exp 10 u12)) 9)
                           (* (* 9 eeb4) 9)))
             (<= 0 u12))
  Something ready to substitute:  eeb2 -> %36; eeb4 -> %37; 
  iter(3)= (and
             (= %36 (str.len x))
             (= %37 (str.len x))
             (= %38 (str.len y))
             (= eeb2 %36)
             (= eeb4 %37)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (* 7 (exp 10 u12)) %38)
             (= (* 9 eeb5) (+ (* 63 (exp 10 (+ eeb2 u12))) (* 81 eeb4)))
             (<= 0 u12))
  iter(4)= (and
             (= %36 (str.len x))
             (= %37 (str.len x))
             (= %38 (str.len y))
             (= eeb5 (+ %37 (* 999 (exp 10 %36))))
             (= (* 7 (exp 10 u12)) %38)
             (= (* 9 eeb5) (+ (* 63 (exp 10 (+ %36 u12))) (* 81 %37)))
             (<= 0 u12))
  strlen data:
  
  run_underapprox2: After strlen lowering:
  (and
    (= %41 (str.len y))
    (= %40 (str.len x))
    (= %39 (str.len x))
    (and
      (= (* 1 eeb2) (* 1 %39))
      (= (* 1 eeb4) (* 1 %40))
      (= (* 9 eeb5) (* 9
                    (+ (* 9 eeb4)
                    (* 1
                    (* (+ (* 7 (* (+ (* 1 (exp 10 u13))) (exp 10 1))) (* 9 1))
                    (exp 10 eeb2))))))
      (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
      (= (* 9 (+ (* 7 (* (+ (* 1 (exp 10 u13))) (exp 10 1))) (* 9 1))) 
      (* 9 %41)))
    (<= (* 1 (* 1 0)) (* 1 (* 1 u13))))
  
  iter(1)= (and
             (= %41 (str.len y))
             (= %40 (str.len x))
             (= %39 (str.len x))
             (and
               (= (* 1 eeb2) (* 1 %39))
               (= (* 1 eeb4) (* 1 %40))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 7 (* (+ (* 1 (exp 10 u13))) (exp 10 1)))
                                (* 9 1))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9 (+ (* 7 (* (+ (* 1 (exp 10 u13))) (exp 10 1))) (* 9 1))) 
               (* 9 %41)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u13))))
  iter(2)= (and
             (= %39 (str.len x))
             (= %40 (str.len x))
             (= %41 (str.len y))
             (= eeb2 %39)
             (= eeb4 %40)
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 9 9) (* (* 70 (exp 10 u13)) 9)) (* 9 %41))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9) (* (* (* 9 (exp 10 eeb2)) 1) 9)
                           (* (* (* (* 70 (exp 10 u13)) (exp 10 eeb2)) 1) 9)))
             (<= 0 u13))
  Something ready to substitute:  eeb2 -> %39; eeb4 -> %40; 
  iter(3)= (and
             (= %39 (str.len x))
             (= %40 (str.len x))
             (= %41 (str.len y))
             (= eeb2 %39)
             (= eeb4 %40)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 81 (* 630 (exp 10 u13))) (* 9 %41))
             (= (* 9 eeb5) (+ (* 81 eeb4) (* 81 (exp 10 eeb2))
                           (* 630 (exp 10 eeb2) (exp 10 u13))))
             (<= 0 u13))
  iter(4)= (and
             (= %39 (str.len x))
             (= %40 (str.len x))
             (= %41 (str.len y))
             (= eeb5 (+ %40 (* 999 (exp 10 %39))))
             (= (+ 81 (* 630 (exp 10 u13))) (* 9 %41))
             (= (* 9 eeb5) (+ (* 81 %40) (* 81 (exp 10 %39))
                           (* 630 (exp 10 (+ %39 u13)))))
             (<= 0 u13))
  strlen data:
  
  run_underapprox2: After strlen lowering:
  (and
    (= %44 (str.len y))
    (= %43 (str.len x))
    (= %42 (str.len x))
    (and
      (= (* 1 eeb2) (* 1 %42))
      (= (* 1 eeb4) (* 1 %43))
      (= (* 9 eeb5) (* 9
                    (+ (* 9 eeb4)
                    (* 1
                    (* (+ (* 8 (* (+ (* 1 (exp 10 u14))) (exp 10 0))) (* 9 0))
                    (exp 10 eeb2))))))
      (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
      (= (* 9 (+ (* 8 (* (+ (* 1 (exp 10 u14))) (exp 10 0))) (* 9 0))) 
      (* 9 %44)))
    (<= (* 1 (* 1 0)) (* 1 (* 1 u14))))
  
  iter(1)= (and
             (= %44 (str.len y))
             (= %43 (str.len x))
             (= %42 (str.len x))
             (and
               (= (* 1 eeb2) (* 1 %42))
               (= (* 1 eeb4) (* 1 %43))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 8 (* (+ (* 1 (exp 10 u14))) (exp 10 0)))
                                (* 9 0))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9 (+ (* 8 (* (+ (* 1 (exp 10 u14))) (exp 10 0))) (* 9 0))) 
               (* 9 %44)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u14))))
  iter(2)= (and
             (= %42 (str.len x))
             (= %43 (str.len x))
             (= %44 (str.len y))
             (= eeb2 %42)
             (= eeb4 %43)
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (* 8 (exp 10 u14)) %44)
             (= (* 9 eeb5) (+ (* (* 8 (exp 10 eeb2) (exp 10 u14)) 9)
                           (* (* 9 eeb4) 9)))
             (<= 0 u14))
  Something ready to substitute:  eeb2 -> %42; eeb4 -> %43; 
  iter(3)= (and
             (= %42 (str.len x))
             (= %43 (str.len x))
             (= %44 (str.len y))
             (= eeb2 %42)
             (= eeb4 %43)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (* 8 (exp 10 u14)) %44)
             (= (* 9 eeb5) (+ (* 72 (exp 10 (+ eeb2 u14))) (* 81 eeb4)))
             (<= 0 u14))
  iter(4)= (and
             (= %42 (str.len x))
             (= %43 (str.len x))
             (= %44 (str.len y))
             (= eeb5 (+ %43 (* 999 (exp 10 %42))))
             (= (* 8 (exp 10 u14)) %44)
             (= (* 9 eeb5) (+ (* 72 (exp 10 (+ %42 u14))) (* 81 %43)))
             (<= 0 u14))
  strlen data:
  
  run_underapprox2: After strlen lowering:
  (and
    (= %47 (str.len y))
    (= %46 (str.len x))
    (= %45 (str.len x))
    (and
      (= (* 1 eeb2) (* 1 %45))
      (= (* 1 eeb4) (* 1 %46))
      (= (* 9 eeb5) (* 9
                    (+ (* 9 eeb4)
                    (* 1
                    (* (+ (* 8 (* (+ (* 1 (exp 10 u15))) (exp 10 1))) (* 9 1))
                    (exp 10 eeb2))))))
      (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
      (= (* 9 (+ (* 8 (* (+ (* 1 (exp 10 u15))) (exp 10 1))) (* 9 1))) 
      (* 9 %47)))
    (<= (* 1 (* 1 0)) (* 1 (* 1 u15))))
  
  iter(1)= (and
             (= %47 (str.len y))
             (= %46 (str.len x))
             (= %45 (str.len x))
             (and
               (= (* 1 eeb2) (* 1 %45))
               (= (* 1 eeb4) (* 1 %46))
               (= (* 9 eeb5) (* 9
                             (+ (* 9 eeb4)
                             (* 1
                             (* (+ (* 8 (* (+ (* 1 (exp 10 u15))) (exp 10 1)))
                                (* 9 1))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 9 (+ (* 8 (* (+ (* 1 (exp 10 u15))) (exp 10 1))) (* 9 1))) 
               (* 9 %47)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u15))))
  iter(2)= (and
             (= %45 (str.len x))
             (= %46 (str.len x))
             (= %47 (str.len y))
             (= eeb2 %45)
             (= eeb4 %46)
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= (+ (* 9 9) (* (* 80 (exp 10 u15)) 9)) (* 9 %47))
             (= (* 9 eeb5) (+ (* (* 9 eeb4) 9) (* (* (* 9 (exp 10 eeb2)) 1) 9)
                           (* (* (* (* 80 (exp 10 u15)) (exp 10 eeb2)) 1) 9)))
             (<= 0 u15))
  Something ready to substitute:  eeb2 -> %45; eeb4 -> %46; 
  iter(3)= (and
             (= %45 (str.len x))
             (= %46 (str.len x))
             (= %47 (str.len y))
             (= eeb2 %45)
             (= eeb4 %46)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 81 (* 720 (exp 10 u15))) (* 9 %47))
             (= (* 9 eeb5) (+ (* 81 eeb4) (* 81 (exp 10 eeb2))
                           (* 720 (exp 10 eeb2) (exp 10 u15))))
             (<= 0 u15))
  iter(4)= (and
             (= %45 (str.len x))
             (= %46 (str.len x))
             (= %47 (str.len y))
             (= eeb5 (+ %46 (* 999 (exp 10 %45))))
             (= (+ 81 (* 720 (exp 10 u15))) (* 9 %47))
             (= (* 9 eeb5) (+ (* 81 %46) (* 81 (exp 10 %45))
                           (* 720 (exp 10 (+ %45 u15)))))
             (<= 0 u15))
  strlen data:
  
  run_underapprox2: After strlen lowering:
  (and
    (= %50 (str.len y))
    (= %49 (str.len x))
    (= %48 (str.len x))
    (and
      (= (* 1 eeb2) (* 1 %48))
      (= (* 1 eeb4) (* 1 %49))
      (= (* 1 eeb5) (* 1
                    (+ (* 1 eeb4)
                    (* 1
                    (* (+ (* 1 (* (+ (* 1 (exp 10 u16))) (exp 10 0))) (* 1 0))
                    (exp 10 eeb2))))))
      (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
      (= (* 1 (+ (* 1 (* (+ (* 1 (exp 10 u16))) (exp 10 0))) (* 1 0))) 
      (* 1 %50)))
    (<= (* 1 (* 1 0)) (* 1 (* 1 u16))))
  
  iter(1)= (and
             (= %50 (str.len y))
             (= %49 (str.len x))
             (= %48 (str.len x))
             (and
               (= (* 1 eeb2) (* 1 %48))
               (= (* 1 eeb4) (* 1 %49))
               (= (* 1 eeb5) (* 1
                             (+ (* 1 eeb4)
                             (* 1
                             (* (+ (* 1 (* (+ (* 1 (exp 10 u16))) (exp 10 0)))
                                (* 1 0))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 1 (+ (* 1 (* (+ (* 1 (exp 10 u16))) (exp 10 0))) (* 1 0))) 
               (* 1 %50)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u16))))
  iter(2)= (and
             (= %48 (str.len x))
             (= %49 (str.len x))
             (= %50 (str.len y))
             (= eeb2 %48)
             (= eeb4 %49)
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= eeb5 (+ (* eeb4 1) (* (exp 10 (+ u16 eeb2)) 1)))
             (= (exp 10 u16) %50)
             (<= 0 u16))
  Something ready to substitute:  eeb2 -> %48; eeb4 -> %49; 
  iter(3)= (and
             (= %48 (str.len x))
             (= %49 (str.len x))
             (= %50 (str.len y))
             (= eeb2 %48)
             (= eeb4 %49)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= eeb5 (+ eeb4 (exp 10 (+ eeb2 u16))))
             (= (exp 10 u16) %50)
             (<= 0 u16))
  iter(4)= (and
             (= %48 (str.len x))
             (= %49 (str.len x))
             (= %50 (str.len y))
             (= eeb5 (+ %49 (* 999 (exp 10 %48))))
             (= eeb5 (+ %49 (exp 10 (+ %48 u16))))
             (= (exp 10 u16) %50)
             (<= 0 u16))
  strlen data:
  
  run_underapprox2: After strlen lowering:
  (and
    (= %53 (str.len y))
    (= %52 (str.len x))
    (= %51 (str.len x))
    (and
      (= (* 1 eeb2) (* 1 %51))
      (= (* 1 eeb4) (* 1 %52))
      (= (* 1 eeb5) (* 1
                    (+ (* 1 eeb4)
                    (* 1
                    (* (+ (* 1 (* (+ (* 1 (exp 10 u17))) (exp 10 1))) (* 1 1))
                    (exp 10 eeb2))))))
      (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
      (= (* 1 (+ (* 1 (* (+ (* 1 (exp 10 u17))) (exp 10 1))) (* 1 1))) 
      (* 1 %53)))
    (<= (* 1 (* 1 0)) (* 1 (* 1 u17))))
  
  iter(1)= (and
             (= %53 (str.len y))
             (= %52 (str.len x))
             (= %51 (str.len x))
             (and
               (= (* 1 eeb2) (* 1 %51))
               (= (* 1 eeb4) (* 1 %52))
               (= (* 1 eeb5) (* 1
                             (+ (* 1 eeb4)
                             (* 1
                             (* (+ (* 1 (* (+ (* 1 (exp 10 u17))) (exp 10 1)))
                                (* 1 1))
                             (exp 10 eeb2))))))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))
               (= (* 1 (+ (* 1 (* (+ (* 1 (exp 10 u17))) (exp 10 1))) (* 1 1))) 
               (* 1 %53)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u17))))
  iter(2)= (and
             (= %51 (str.len x))
             (= %52 (str.len x))
             (= %53 (str.len y))
             (= eeb2 %51)
             (= eeb4 %52)
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1)))
             (= eeb5 (+ (* eeb4 1) (* (* (* 1 (exp 10 eeb2)) 1) 1)
                     (* (* (* (* 10 (exp 10 u17)) (exp 10 eeb2)) 1) 1)))
             (= (+ (* 1 1) (* (* 10 (exp 10 u17)) 1)) %53)
             (<= 0 u17))
  Something ready to substitute:  eeb2 -> %51; eeb4 -> %52; 
  iter(3)= (and
             (= %51 (str.len x))
             (= %52 (str.len x))
             (= %53 (str.len y))
             (= eeb2 %51)
             (= eeb4 %52)
             (= eeb5 (+ eeb4 (* 10 (exp 10 eeb2) (exp 10 u17)) (exp 10 eeb2)))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ 1 (* 10 (exp 10 u17))) %53)
             (<= 0 u17))
  iter(4)= (and
             (= %51 (str.len x))
             (= %52 (str.len x))
             (= %53 (str.len y))
             (= eeb5 (+ %52 (* 10 (exp 10 (+ %51 u17))) (exp 10 %51)))
             (= eeb5 (+ %52 (* 999 (exp 10 %51))))
             (= (+ 1 (* 10 (exp 10 u17))) %53)
             (<= 0 u17))
  (= (str.++ "999" x) (str.++ y x))
  Looking for SAT in 18 asts...
  Simplify step: ((= eee9 (+ %0 u0)) & (= %0 (str.len x)) & (= %1 (str.len x)) & (= %2 (str.len y)) & (= eeb5 
  (+ %1 (* 999 (exp 10 %0)))) & (= (* 9 eeb5) (+ (* 9 (exp 10 eee9)) (* 81 %1))) & (= (exp 10 u0) %2) & (<= 0 u0))
  Simplified expression: (and
                           (= eee9 (+ %0 u0))
                           (= %0 (str.len x))
                           (= %1 (str.len x))
                           (= %2 (str.len y))
                           (= eeb5 (+ %1 (* 999 (exp 10 %0))))
                           (= (* 9 eeb5) (+ (* 9 (exp 10 eee9)) (* 81 %1)))
                           (= (exp 10 u0) %2)
                           (<= 0 u0))
  strlen data:
  (chrob.len x) ~~> %57
  (chrob.len y) ~~> %59
  
  After strlen lowering:
  (and
    (= %59 (chrob.len y))
    (= %57 (chrob.len x))
    (= %55 (chrob.len x))
    (and
      (= (+ (* (- 1) u0) (* 1 eee9) (* (- 1) %0)) 0))
    (and
      (= (+ (* (- 1) %54) (* 1 %0)) 0)
      (= %55 %57)
      (= (+ (* 1 (exp 10 %54)) (* (- 1) %55)) 1))
    (and
      (= (+ (* (- 1) %56) (* 1 %1)) 0)
      (= %57 %57)
      (= (+ (* 1 (exp 10 %56)) (* (- 1) %57)) 1))
    (and
      (= (+ (* (- 1) %58) (* 1 %2)) 0)
      (= %59 %59)
      (= (+ (* 1 (exp 10 %58)) (* (- 1) %59)) 1))
    (and
      (= (+ (* (- 999) (exp 10 %0)) (* 1 eeb5) (* (- 1) %1)) 0))
    (and
      (= (+ (* (- 9) (exp 10 eee9)) (* 9 eeb5) (* (- 81) %1)) 0))
    (and
      (= (+ (* 1 (exp 10 u0)) (* (- 1) %2)) 0))
    (and
      (<= (+ (* (- 1) u0)) 0)))
  
  iter(1)= (and
             (= %59 (chrob.len y))
             (= %57 (chrob.len x))
             (= %55 (chrob.len x))
             (and
               (= (+ (* (- 1) u0) (* 1 eee9) (* (- 1) %0)) 0))
             (and
               (= (+ (* (- 1) %54) (* 1 %0)) 0)
               (= %55 %57)
               (= (+ (* 1 (exp 10 %54)) (* (- 1) %55)) 1))
             (and
               (= (+ (* (- 1) %56) (* 1 %1)) 0)
               (= %57 %57)
               (= (+ (* 1 (exp 10 %56)) (* (- 1) %57)) 1))
             (and
               (= (+ (* (- 1) %58) (* 1 %2)) 0)
               (= %59 %59)
               (= (+ (* 1 (exp 10 %58)) (* (- 1) %59)) 1))
             (and
               (= (+ (* (- 999) (exp 10 %0)) (* 1 eeb5) (* (- 1) %1)) 0))
             (and
               (= (+ (* (- 9) (exp 10 eee9)) (* 9 eeb5) (* (- 81) %1)) 0))
             (and
               (= (+ (* 1 (exp 10 u0)) (* (- 1) %2)) 0))
             (and
               (<= (+ (* (- 1) u0)) 0)))
  iter(2)= (and
             (= %55 %57)
             (= %55 (chrob.len x))
             (= %57 (chrob.len x))
             (= %59 (chrob.len y))
             (= (+ %0 (* (- 1) %54)) 0)
             (= (+ %1 (* (- 1) %56)) 0)
             (= (+ %2 (* (- 1) %58)) 0)
             (= (+ eeb5 (* (- 999) (exp 10 %0)) (* (- 1) %1)) 0)
             (= (+ eee9 (* (- 1) %0) (* (- 1) u0)) 0)
             (= (+ (* (- 81) %1) (* (- 9) (exp 10 eee9)) (* 9 eeb5)) 0)
             (= (+ (* (- 1) %2) (exp 10 u0)) 0)
             (= (+ (* (- 1) %55) (exp 10 %54)) 1)
             (= (+ (* (- 1) %57) (exp 10 %56)) 1)
             (= (+ (* (- 1) %59) (exp 10 %58)) 1)
             (<= (* (- 1) u0) 0))
  Something ready to substitute:  %0 -> %54; %1 -> %56; %2 -> %58; %55 -> 
                                 %57; eeb5 -> (+ (* (* (- 999) (exp 10 %54))
                                                 (- 1))
                                              (* (* (- 1) %56) (- 1))); 
  iter(3)= (and
             (= %55 %57)
             (= %55 (chrob.len x))
             (= %57 (chrob.len x))
             (= %59 (chrob.len y))
             (= (+ %0 (* (- 1) %54)) 0)
             (= (+ %1 (* (- 1) %56)) 0)
             (= (+ %2 (* (- 1) %58)) 0)
             (= (+ eeb5 (* (- 999) (exp 10 %0)) (* (- 1) %1)) 0)
             (= (+ eee9 (* (- 1) %0) (* (- 1) u0)) 0)
             (= (+ (* (- 81) %1) (* (- 9) (exp 10 eee9)) (* 9 eeb5)) 0)
             (= (+ (* (- 1) %2) (exp 10 u0)) 0)
             (= (+ (* (- 1) %55) (exp 10 %54)) 1)
             (= (+ (* (- 1) %57) (exp 10 %56)) 1)
             (= (+ (* (- 1) %59) (exp 10 %58)) 1)
             (<= (* (- 1) u0) 0))
  iter(4)= (and
             (= %57 (chrob.len x))
             (= %59 (chrob.len y))
             (= (+ eee9 (* (- 1) %54) (* (- 1) u0)) 0)
             (= (+ (* (- 999) (exp 10 %54)) (* (- 1) %56)
                (* (* (- 999) (exp 10 %54)) (- 1)) (* (* (- 1) %56) (- 1))) 0)
             (= (+ (* (- 81) %56) (* (- 9) (exp 10 eee9))
                (* (* (* (- 999) (exp 10 %54)) (- 1)) 9)
                (* (* (* (- 1) %56) (- 1)) 9)) 0)
             (= (+ (* (- 1) %57) (exp 10 %54)) 1)
             (= (+ (* (- 1) %57) (exp 10 %56)) 1)
             (= (+ (* (- 1) %58) (exp 10 u0)) 0)
             (= (+ (* (- 1) %59) (exp 10 %58)) 1)
             (<= (* (- 1) u0) 0))
  iter(5)= (and
             (= %57 (chrob.len x))
             (= %59 (chrob.len y))
             (= (+ eee9 (* (- 1) %54) (* (- 1) u0)) 0)
             (= (+ (* (- 72) %56) (* (- 9) (exp 10 eee9))
                (* 8991 (exp 10 %54))) 0)
             (= (+ (* (- 1) %57) (exp 10 %54)) 1)
             (= (+ (* (- 1) %57) (exp 10 %56)) 1)
             (= (+ (* (- 1) %58) (exp 10 u0)) 0)
             (= (+ (* (- 1) %59) (exp 10 %58)) 1)
             (<= (* (- 1) u0) 0))
  Simplify step: ((= %57 (chrob.len x)) & (= %59 (chrob.len y)) & (= (+ eee9
                                                                     (* (- 1)
                                                                     %54)
                                                                     (* (- 1)
                                                                     u0)) 0) & (= 
  (+ (* (- 72) %56) (* (- 9) (exp 10 eee9)) (* 8991 (exp 10 %54))) 0) & (= 
  (+ (* (- 1) %57) (exp 10 %54)) 1) & (= (+ (* (- 1) %57) (exp 10 %56)) 1) & (= 
  (+ (* (- 1) %58) (exp 10 u0)) 0) & (= (+ (* (- 1) %59) (exp 10 %58)) 1) & (<= 
  (* (- 1) u0) 0))
  Simplified expression: (and
                           (= %57 (chrob.len x))
                           (= %59 (chrob.len y))
                           (= (+ eee9 (* (- 1) %54) (* (- 1) u0)) 0)
                           (= (+ (* (- 72) %56) (* (- 9) (exp 10 eee9))
                              (* 8991 (exp 10 %54))) 0)
                           (= (+ (* (- 1) %57) (exp 10 %54)) 1)
                           (= (+ (* (- 1) %57) (exp 10 %56)) 1)
                           (= (+ (* (- 1) %58) (exp 10 u0)) 0)
                           (= (+ (* (- 1) %59) (exp 10 %58)) 1)
                           (<= (* (- 1) u0) 0))
  (assert (exists (%57)
          (and
            (exists (%59)
            (and
              (exists (y) (= %59 (chrob.len y)))
              (= (+ (* (- 1) %59) pow2(%58) )  1)
              )
            (exists (x) (= %57 (chrob.len x)))
            (= (+ (* (- 1) %54) eee9 (* (- 1) u0) )  0)
            (= (+ (* (- 72) %56) (* 8991 pow2(%54)) (* (- 9) pow2(eee9)) )  0)
            (= (+ (* (- 1) %57) pow2(%54) )  1)
            (= (+ (* (- 1) %57) pow2(%56) )  1)
            (= (+ (* (- 1) %58) pow2(u0) )  0)
            (<= (* (- 1) u0)  0)
            )
  )
