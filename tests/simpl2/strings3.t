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
  Something ready to substitute:  eeb1 ->s eeb5; eeb3 -> 999; eeb6 -> eeb2; eeb8 -> 
                                 eeb4; 
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb3 999)
             (= eeb4 (str.to.int x))
             (= eeb6 eeb2)
             (= eeb7 (str.to.int y))
             (= eeb8 eeb4)
             (= eeb1 eeb5)
             (= eeb1 (+ eeb4 (* eeb3 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6)))))
  iter(3)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb7 (str.to.int y))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= (+ eeb4 (* 999 (exp 10 eeb2))) (+ eeb4 (* eeb7 (exp 10 eeb2)))))
  iter(4)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb7 (str.to.int y))
             (= (+ eeb4 (* 999 (exp 10 eeb2)) (* (- 1) eeb4)
                (* (- 1) eeb7 (exp 10 eeb2))) 0)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2)))))
  Something ready to substitute:  eeb1 ->s eeb5; eeb3 -> 999; eeb6 -> eeb2; eeb7 -> 
                                 999; eeb8 -> eeb4; 
  iter(5)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb7 (str.to.int y))
             (= (+ (* (- 1) eeb7) 999) 0)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2)))))
  iter(6)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= 999 (str.to.int y))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2)))))
  vars_for_under2: 
  
  iter(0)= (and
             (and
               (= (* 1 eeb2) (* 1 (str.len x)))
               (= (* 1 eeb4) (* 1 (str.to.int x)))
               (= (* 1 999) (* 1 (str.to.int y)))
               (= (* 1 eeb5) (* 1 (+ (* 1 eeb4) (* 1 (* 999 (exp 10 eeb2))))))))
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= 999 (str.to.int y))
             (= eeb5 (+ (* eeb4 1) (* (* 999 (exp 10 eeb2)) 1))))
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= 999 (str.to.int y))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2)))))
  run_underapprox2: Before strlen lowering:
  (and
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= 999 (str.to.int y))
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2)))))
  
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
    (= 999 %0)
    (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2)))))
  
  iter(1)= (and
             (= %0 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb2 eeb2)
             (= eeb4 eeb4)
             (= 999 %0)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2)))))
  iter(2)= (and
             (= %0 (str.to.int y))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= 999 %0)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2)))))
  (= (str.++ "999" x) (str.++ y x))
  Looking for SAT in 1 asts...
  Simplify step: ((= %0 (str.to.int y)) & (= eeb2 (str.len x)) & (= eeb4 (str.to.int x)) & (= 999 %0) & (= eeb5 
  (+ eeb4 (* 999 (exp 10 eeb2)))))
  Simplified expression: (and
                           (= %0 (str.to.int y))
                           (= eeb2 (str.len x))
                           (= eeb4 (str.to.int x))
                           (= 999 %0)
                           (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2)))))
  strlen data:
  (chrob.len x) ~~> [%2]
  
  After strlen lowering:
  (and
    (= %2 (chrob.len x))
    (and
      (= (+ (* (- 1) y) (* 1 %0)) 0))
    (and
      (= (+ (* 1 eeb2) (* (- 1) %1)) 0)
      (= %2 %2)
      (= (+ (* 1 (exp 10 %1)) (* (- 1) %2)) 1))
    (and
      (= (+ (* (- 1) x) (* 1 eeb4)) 0))
    (and
      (= (+ (* (- 1) %0)) (- 999)))
    (and
      (= (+ (* (- 999) (exp 10 eeb2)) (* 1 eeb5) (* (- 1) eeb4)) 0)))
  
  iter(1)= (and
             (= %2 (chrob.len x))
             (and
               (= (+ (* (- 1) y) (* 1 %0)) 0))
             (and
               (= (+ (* 1 eeb2) (* (- 1) %1)) 0)
               (= %2 %2)
               (= (+ (* 1 (exp 10 %1)) (* (- 1) %2)) 1))
             (and
               (= (+ (* (- 1) x) (* 1 eeb4)) 0))
             (and
               (= (+ (* (- 1) %0)) (- 999)))
             (and
               (= (+ (* (- 999) (exp 10 eeb2)) (* 1 eeb5) (* (- 1) eeb4)) 0)))
  Something ready to substitute:  %0 -> y; eeb2 -> %1; eeb4 -> x; eeb5 -> 
                                 (+ (* (* (- 999) (exp 10 %1)) (- 1))
                                 (* (* (- 1) x) (- 1))); 
  iter(2)= (and
             (= %2 (chrob.len x))
             (= (+ %0 (* (- 1) y)) 0)
             (= (+ eeb2 (* (- 1) %1)) 0)
             (= (+ eeb4 (* (- 1) x)) 0)
             (= (+ eeb5 (* (- 999) (exp 10 eeb2)) (* (- 1) eeb4)) 0)
             (= (+ (* (- 1) %2) (exp 10 %1)) 1)
             (= (* (- 1) %0) (- 999)))
  Something ready to substitute:  %0 -> y; eeb2 -> %1; eeb4 -> x; eeb5 -> 
                                 (+ (* (* (- 999) (exp 10 %1)) (- 1))
                                 (* (* (- 1) x) (- 1))); y -> 999; 
  iter(3)= (and
             (= %2 (chrob.len x))
             (= (+ (* (- 999) (exp 10 %1)) (* (- 1) x)
                (* (* (- 999) (exp 10 %1)) (- 1)) (* (* (- 1) x) (- 1))) 0)
             (= (+ (* (- 1) %2) (exp 10 %1)) 1)
             (= (* (- 1) y) (- 999)))
  iter(4)= (and
             (= %2 (chrob.len x))
             (= (+ (* (- 1) %2) (exp 10 %1)) 1))
  Simplify step: ((= %2 (chrob.len x)) & (= (+ (* (- 1) %2) (exp 10 %1)) 1))
  Simplified expression: (and
                           (= %2 (chrob.len x))
                           (= (+ (* (- 1) %2) (exp 10 %1)) 1))
  (assert (exists (%2)
          (and
            (exists (x) (= %2 (chrob.len x)))
            (= (+ (* (- 1) %2) pow2(%1) )  1)
            )
  )
  $ unset CHRO_DEBUG
  $ timeout 2 Chro -pre-simpl -dpresimpl -dsimpl strings3.smt2 -flat 0 -under3 -bmax 1 #| head -n 50
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
  
  (= (str.++ "999" x) (str.++ y x))
  strlen data:
  (chrob.len x) ~~> [%2]
  
  (assert (exists (%2)
          (and
            (exists (x) (= %2 (chrob.len x)))
            (= (+ (* (- 1) %2) pow2(%1) )  1)
            )
  )
  sat ; under III
