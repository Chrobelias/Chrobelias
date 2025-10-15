  $ export CHRO_DEBUG=1
  $ cat > 1.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x String)
  > (declare-const y String)
  > (assert (= (str.++ "999" x) (str.++ y x)))
  > (set-info :status sat)
  > (check-sat)
  > EOF

  $ Chro -pre-simpl -dpresimpl -dsimpl -stop-after simpl 1.smt2 -flat 1 -under3 -amin 2 -amax 2 # | sed 's/[[:space:]]*$//' | head -n 80
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
  iter(3)= (and
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6))))
             (= (+ eeb8 (* eeb7 (exp 10 eeb6))) (+ eeb4 (* 999 (exp 10 eeb2)))))
  iter(4)= (and
             (= (+ eeb8 (* eeb7 (exp 10 eeb6)) (* (- 999) (exp 10 eeb2))
                (* (- 1) eeb4)) 0)
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6)))))
  vars_for_under2: eeb7
  
  all as: 2
  
  iter(1)= (and
             (= eeb5 (+ eeb8 (* 2 (exp 10 eeb6))
                     (* (* (- 1) (exp 10 v10)) (exp 10 eeb6))
                     (* (exp 10 u9) (exp 10 eeb6))))
             (= (+ eeb8 (* (- 999) (exp 10 eeb2)) (* (- 1) eeb4)
                (* 2 (exp 10 eeb6)) (* (* (- 1) (exp 10 v10)) (exp 10 eeb6))
                (* (exp 10 u9) (exp 10 eeb6))) 0)
             (<= v10 u9))
  Something ready to substitute:  eeb8 -> (+ (* (* (- 999) (exp 10 eeb2))
                                             (- 1))
                                          (* (* (- 1) eeb4) (- 1))
                                          (* (* (- 1) (exp 10 eeb6)
                                             (exp 10 v10))
                                          (- 1)) (* (* 2 (exp 10 eeb6)) (- 1))
                                          (* (exp 10 (+ u9 eeb6)) (- 1))); 
  iter(2)= (and
             (= (+ eeb8 (* (- 999) (exp 10 eeb2)) (* (- 1) eeb4)
                (* (- 1) (exp 10 eeb6) (exp 10 v10)) (* 2 (exp 10 eeb6))
                (exp 10 (+ u9 eeb6))) 0)
             (<= v10 u9)
             (= eeb5 (+ eeb8 (* (- 1) (exp 10 eeb6) (exp 10 v10))
                     (* 2 (exp 10 eeb6)) (exp 10 (+ u9 eeb6)))))
  iter(3)= (and
             (= (+ (* (- 999) (exp 10 eeb2)) (* (- 1) eeb4)
                (* (- 1) (exp 10 (+ eeb6 v10))) (* 2 (exp 10 eeb6))
                (* (* (- 999) (exp 10 eeb2)) (- 1)) (* (* (- 1) eeb4) (- 1))
                (* (* (- 1) (exp 10 eeb6) (exp 10 v10)) (- 1))
                (* (* 2 (exp 10 eeb6)) (- 1)) (* (exp 10 (+ u9 eeb6)) (- 1))
                (exp 10 (+ eeb6 u9))) 0)
             (<= v10 u9)
             (= eeb5 (+ (* (- 1) (exp 10 (+ eeb6 v10))) (* 2 (exp 10 eeb6))
                     (* (* (- 999) (exp 10 eeb2)) (- 1))
                     (* (* (- 1) eeb4) (- 1))
                     (* (* (- 1) (exp 10 eeb6) (exp 10 v10)) (- 1))
                     (* (* 2 (exp 10 eeb6)) (- 1))
                     (* (exp 10 (+ u9 eeb6)) (- 1)) (exp 10 (+ eeb6 u9)))))
  iter(4)= (and
             (= (+ (* (- 1) (exp 10 (+ eeb6 v10))) (exp 10 (+ eeb6 v10))) 0)
             (<= v10 u9)
             (= eeb5 (+ eeb4 (* (- 1) (exp 10 (+ eeb6 v10)))
                     (* 999 (exp 10 eeb2)) (exp 10 (+ eeb6 v10)))))
  iter(5)= (and
             (<= v10 u9)
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2)))))
  (= (str.++ "999" x) (str.++ y x))
  Looking for SAT in 1 asts...
  Simplify step: ((<= v10 u9) & (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2)))))
  Simplified expression: (and
                           (<= v10 u9)
                           (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2)))))
  iter(1)= (and
             (and
               (<= (+ (* 1 v10) (* (- 1) u9)) 0))
             (and
               (= (+ (* (- 999) (exp 10 eeb2)) (* 1 eeb5) (* (- 1) eeb4)) 0)))
  Something ready to substitute:  eeb5 -> (+ (* (* (- 999) (exp 10 eeb2))
                                             (- 1))
                                          (* (* (- 1) eeb4) (- 1))); 
  iter(2)= (and
             (= (+ eeb5 (* (- 999) (exp 10 eeb2)) (* (- 1) eeb4)) 0)
             (<= (+ v10 (* (- 1) u9)) 0))
  iter(3)= (and
             (= (+ (* (- 999) (exp 10 eeb2)) (* (- 1) eeb4)
                (* (* (- 999) (exp 10 eeb2)) (- 1)) (* (* (- 1) eeb4) (- 1))) 0)
             (<= (+ v10 (* (- 1) u9)) 0))
  iter(4)= (and
             (<= (+ v10 (* (- 1) u9)) 0))
  iter(5)= (<= (+ v10 (* (- 1) u9)) 0)
  Simplify step: (<= (+ v10 (* (- 1) u9)) 0)
  Simplified expression: (<= (+ v10 (* (- 1) u9)) 0)
  Trying to use PrA deciding procedure over  ((-1u9 + 1v10 <= 0))
  (assert (exists (u9 v10) (<= (+ (* (- 1) u9) v10 )  0) )
  )


