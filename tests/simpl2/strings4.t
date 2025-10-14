  $ export CHRO_DEBUG=1
  $ cat strings4.smt2
  (set-logic QF_S)
  (declare-const x String)
  (declare-const y String)
  
  (assert (str.in.re x (re.++ (str.to.re "aa") (re.* (str.to.re "bbb")))))
  (assert (str.in.re y (re.+ (str.to.re "9"))))
  (assert (= (str.len x) (+ 1 (str.to.int y))))
  
  (check-sat)
  (get-model)

$ Chro -pre-simpl -dpresimpl -dsimpl -stop-after simpl strings4.smt2 -flat 0 -under3 -bmax 1 | sed 's/[[:space:]]*$//'
  $ Chro -pre-simpl -dpresimpl -dsimpl -stop-after simpl strings4.smt2 -flat 2 -under3 -bmax 9 #| head -n 50
  strlen data:
  
  After strlen lowering:
  (and
    (= %1 (str.len x))
    (= %0 (str.to.int y))
    (= %1 (str.len x))
    (= %1 (+ 1 %0))
    (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re ""))))
    (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re "")))))
  
  iter(1)= (and
             (= %1 (str.len x))
             (= %0 (str.to.int y))
             (= %1 (str.len x))
             (= %1 (+ 1 %0))
             (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re ""))))
             (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re "")))))
  iter(2)= (and
             (= %0 (str.to.int y))
             (= %1 (str.len x))
             (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re ""))))
             (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re ""))))
             (= %1 (+ %0 1)))
  vars_for_under2: 
  
  iter(0)= (and
             (and
               (= (* 1 %0) (* 1 (str.to.int y)))
               (= (* 1 %1) (* 1 (str.len x)))
               (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re ""))))
               (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re ""))))
               (= (* 1 %1) (* 1 (+ (* 1 %0) (* 1 1))))))
  iter(1)= (and
             (= %0 (str.to.int y))
             (= %1 (str.len x))
             (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re ""))))
             (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re ""))))
             (= %1 (+ (* %0 1) (* 1 1))))
  iter(2)= (and
             (= %0 (str.to.int y))
             (= %1 (str.len x))
             (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re ""))))
             (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re ""))))
             (= %1 (+ %0 1)))
  run_underapprox2: Before strlen lowering:
  (and
    (= %0 (str.to.int y))
    (= %1 (str.len x))
    (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re ""))))
    (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re ""))))
    (= %1 (+ %0 1)))
  
  strlen data:
  (str.len x) ~~> [%1]
  (str.to.int y) ~~> [%0]
  
  run_underapprox2: After strlen lowering:
  (and
    (= %1 (str.len x))
    (= %0 (str.to.int y))
    (= %0 %0)
    (= %1 %1)
    (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re ""))))
    (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re ""))))
    (= %1 (+ %0 1)))
  
  iter(1)= (and
             (= %1 (str.len x))
             (= %0 (str.to.int y))
             (= %0 %0)
             (= %1 %1)
             (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re ""))))
             (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re ""))))
             (= %1 (+ %0 1)))
  iter(2)= (and
             (= %0 (str.to.int y))
             (= %1 (str.len x))
             (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re ""))))
             (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re ""))))
             (= %1 (+ %0 1)))
  (and
    (= %0 (str.to.int y))
    (= %1 (str.len x))
    (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re ""))))
    (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re ""))))
    (= %1 (+ %0 1)))
  Looking for SAT in 1 asts...
  Simplify step: ((= %0 (str.to.int y)) & (= %1 (str.len x)) & (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re "")))) & (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re "")))) & (= %1 
  (+ 1 %0)))
  Simplify step: ((= %0 (str.to.int y)) & (= %1 (str.len x)) & (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re "")))) & (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re "")))) & (= %1 
  (+ 1 %0)))
  Simplified expression: (and
                           (= %0 (str.to.int y))
                           (= %1 (str.len x))
                           (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re ""))))
                           (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re ""))))
                           (= %1 (+ 1 %0)))
  strlen data:
  (chrob.len x) ~~> [%3]
  
  After strlen lowering:
  (and
    (= %3 (chrob.len x))
    (and
      (= (+ (* (- 1) y) (* 1 %0)) 0))
    (and
      (= (+ (* (- 1) %2) (* 1 %1)) 0)
      (= %3 %3)
      (= (+ (* 1 (exp 10 %2)) (* (- 1) %3)) 1))
    (and
      (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re "")))))
    (and
      (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re "")))))
    (and
      (= (+ (* 1 %1) (* (- 1) %0)) 1)))
  
  iter(1)= (and
             (= %3 (chrob.len x))
             (and
               (= (+ (* (- 1) y) (* 1 %0)) 0))
             (and
               (= (+ (* (- 1) %2) (* 1 %1)) 0)
               (= %3 %3)
               (= (+ (* 1 (exp 10 %2)) (* (- 1) %3)) 1))
             (and
               (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re "")))))
             (and
               (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re "")))))
             (and
               (= (+ (* 1 %1) (* (- 1) %0)) 1)))
  Something ready to substitute:  %0 -> y; %1 -> %2; 
  iter(2)= (and
             (= %3 (chrob.len x))
             (= (+ %0 (* (- 1) y)) 0)
             (= (+ %1 (* (- 1) %0)) 1)
             (= (+ %1 (* (- 1) %2)) 0)
             (= (+ (* (- 1) %3) (exp 10 %2)) 1)
             (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re ""))))
             (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re "")))))
  iter(3)= (and
             (= %3 (chrob.len x))
             (= (+ %2 (* (- 1) y)) 1)
             (= (+ (* (- 1) %3) (exp 10 %2)) 1)
             (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re ""))))
             (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re "")))))
  Simplify step: ((= %3 (chrob.len x)) & (= (+ %2 (* (- 1) y)) 1) & (= 
  (+ (* (- 1) %3) (exp 10 %2)) 1) & (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re "")))) & (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re "")))))
  Simplified expression: (and
                           (= %3 (chrob.len x))
                           (= (+ %2 (* (- 1) y)) 1)
                           (= (+ (* (- 1) %3) (exp 10 %2)) 1)
                           (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re ""))))
                           (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re "")))))
  (assert (exists (y)
          (and
            (exists (x)
            (and
              (exists (%3)
              (and
                (= %3 (chrob.len x))(= (+ (* (- 1) %3) pow2(%2) )  1)
                )
              (str.in.re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re "")))))
            (= (+ %2 (* (- 1) y) )  1)
            (str.in.re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re "")))))
  )
  $ unset CHRO_DEBUG
  $ timeout 2 Chro -pre-simpl -dpresimpl -dsimpl strings4.smt2 -flat 0 -under3 -bmax 9 #| head -n 50
  strlen data:
  
  strlen data:
  (str.len x) ~~> [%1]
  (str.to.int y) ~~> [%0]
  
  (and
    (= %0 (str.to.int y))
    (= %1 (str.len x))
    (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re ""))))
    (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re ""))))
    (= %1 (+ %0 1)))
  strlen data:
  (chrob.len x) ~~> [%3]
  
  (assert (exists (y)
          (and
            (exists (x)
            (and
              (exists (%3)
              (and
                (= %3 (chrob.len x))(= (+ (* (- 1) %3) pow2(%2) )  1)
                )
              (str.in.re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re "")))))
            (= (+ %2 (* (- 1) y) )  1)
            (str.in.re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re "")))))
  )
  (assert (<= (+ %2 (* (- 1) pow2(%2)) )  -1)
  )
  unknown
  ; Under2 resigns
  strlen data:
  (str.len x) ~~> [%1]
  (str.to.int y) ~~> [%0]
  
  strlen data:
  (str.len x) ~~> [%1]
  (str.to.int y) ~~> [%0]
  
  (and
    (= %0 (str.to.int y))
    (= %1 (str.len x))
    (str.in_re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re ""))))
    (str.in_re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re ""))))
    (= %1 (+ %0 1)))
  strlen data:
  (chrob.len x) ~~> [%15]
  
  (assert (exists (y)
          (and
            (exists (x)
            (and
              (exists (%15)
              (and
                (= %15 (chrob.len x))(= (+ (* (- 1) %15) pow2(%14) )  1)
                )
              (str.in.re x (re.++ (re.++ (re.* (re.++ (str.to.re "b") (re.++ (str.to.re "b") (str.to.re "b")))) (re.++ (str.to.re "a") (str.to.re "a"))) (re.* (str.to.re "")))))
            (= (+ %14 (* (- 1) y) )  1)
            (str.in.re y (re.++ (re.++ (str.to.re "9") (re.* (str.to.re "9"))) (re.* (str.to.re "")))))
  )
  (assert (<= (+ %14 (* (- 1) pow2(%14)) )  -1)
  )
  unknown
  ; Under3 resigns
