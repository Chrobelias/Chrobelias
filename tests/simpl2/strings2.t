  $ export CHRO_DEBUG=1
  $ cat > 1.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x String)
  > (declare-const y String)
  > (assert (= (str.++ "123" x) (str.++ y x)))
  > (assert (= y "321"))
  > (set-info :status unsat)
  > (check-sat)
  > EOF

  $ Chro -pre-simpl -dpresimpl -dsimpl -stop-after simpl 1.smt2 -flat 1 -under3 -amin 2 -amax 2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= y "321")
             (= (str.++ "123" x) (str.++ y x)))
  Something ready to substitute:  y ->s "321";
  iter(2)= (and
             (= y "321")
             (= (str.++ "123" x) (str.++ y x)))
  Substitute y ~~> "321"
  Substitute y ~~> "321"
  iter(3)= (and
             (= (str.++ "123" x) (str.++ "321" x)))
  iter(4)= (= (str.++ "123" x) (str.++ "321" x))
  vars_for_under2:
  
  all as: 2
  
  iter(1)= (= (str.++ "123" x) (str.++ "321" x))
  (= (str.++ "123" x) (str.++ "321" x))
  Looking for SAT in 1 asts...
  Simplify step: (= (str.++ "123" x) (str.++ "321" x))
  Simplify step: (= (str.++ "123" x) (str.++ "321" x))
  Simplified expression: (= (str.++ "123" x) (str.++ "321" x))
  unknown
  ; Under2 resigns
  iter(1)= (and
             (= eeb6 (str.len x))
             (= eeb2 (str.len x))
             (= eeb6 eeb2)
             (= eeb5 (+ (* eeb7 (exp 10 eeb6)) eeb8))
             (= eeb8 (str.to.int x))
             (= eeb7 321)
             (= eeb2 eeb2)
             (= eeb1 (+ (* eeb3 (exp 10 eeb2)) eeb4))
             (= eeb4 (str.to.int x))
             (= eeb3 123)
             (= (str.from_int eeb1) (str.from_int eeb5)))
  Something ready to substitute:  eeb1 ->s eeb5; eeb2 -> (str.len x); eeb3 ->
                                 123; eeb4 -> (str.to.int x); eeb6 -> (str.len x); eeb7 ->
                                 321; eeb8 -> (str.to.int x);
  iter(2)= (and
             (= eeb2 (str.len x))
             (= eeb3 123)
             (= eeb4 (str.to.int x))
             (= eeb6 (str.len x))
             (= eeb7 321)
             (= eeb8 (str.to.int x))
             (= eeb1 eeb5)
             (= eeb1 (+ eeb4 (* eeb3 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6)))))
  Substitute eeb3 ~~> 123
  Substitute eeb7 ~~> 321
  Substitute eeb1 ~~> eeb5
  Substitute eeb3 ~~> 123
  Substitute eeb1 ~~> eeb5
  Substitute eeb7 ~~> 321
  iter(3)= (and
             (= eeb5 (+ eeb8 (* 321 (exp 10 eeb6))))
             (= (+ eeb8 (* 321 (exp 10 eeb6))) (+ eeb4 (* 123 (exp 10 eeb2)))))
  iter(4)= (and
             (= (+ eeb8 (* (- 123) (exp 10 eeb2)) (* (- 1) eeb4)
                (* 321 (exp 10 eeb6))) 0)
             (= eeb5 (+ eeb8 (* 321 (exp 10 eeb6)))))
  vars_for_under2:
  
  all as: 2
  
  iter(1)= (and
             (= eeb5 (+ eeb8 (* 321 (exp 10 eeb6))))
             (= (+ eeb8 (* (- 123) (exp 10 eeb2)) (* (- 1) eeb4)
                (* 321 (exp 10 eeb6))) 0))
  Something ready to substitute:  eeb8 -> (+ (* (* (- 123) (exp 10 eeb2))
                                             (- 1))
                                          (* (* (- 1) eeb4) (- 1))
                                          (* (* 321 (exp 10 eeb6)) (- 1)));
  iter(2)= (and
             (= (+ eeb8 (* (- 123) (exp 10 eeb2)) (* (- 1) eeb4)
                (* 321 (exp 10 eeb6))) 0)
             (= eeb5 (+ eeb8 (* 321 (exp 10 eeb6)))))
  Substitute eeb8 ~~> (+ (* (* (- 123) (exp 10 eeb2)) (- 1))
                      (* (* (- 1) eeb4) (- 1)) (* (* 321 (exp 10 eeb6)) (- 1)))
  Substitute eeb8 ~~> (+ (* (* (- 123) (exp 10 eeb2)) (- 1))
                      (* (* (- 1) eeb4) (- 1)) (* (* 321 (exp 10 eeb6)) (- 1)))
  iter(3)= (and
             (= (+ (* (- 123) (exp 10 eeb2)) (* (- 1) eeb4)
                (* 321 (exp 10 eeb6)) (* (* (- 123) (exp 10 eeb2)) (- 1))
                (* (* (- 1) eeb4) (- 1)) (* (* 321 (exp 10 eeb6)) (- 1))) 0)
             (= eeb5 (+ (* 321 (exp 10 eeb6))
                     (* (* (- 123) (exp 10 eeb2)) (- 1))
                     (* (* (- 1) eeb4) (- 1)) (* (* 321 (exp 10 eeb6)) (- 1)))))
  iter(4)= (and
             (= eeb5 (+ eeb4 (* 123 (exp 10 eeb2)))))
  iter(5)= (= eeb5 (+ eeb4 (* 123 (exp 10 eeb2))))
  (= (str.++ "123" x) (str.++ "321" x))
  Looking for SAT in 1 asts...
  Simplify step: (= eeb5 (+ eeb4 (* 123 (exp 10 eeb2))))
  Simplify step: (= eeb5 (+ eeb4 (* 123 (exp 10 eeb2))))
  Simplified expression: (= eeb5 (+ eeb4 (* 123 (exp 10 eeb2))))
  iter(1)= (and
             (= (+ (* (- 123) (exp 10 eeb2)) (* 1 eeb5) (* (- 1) eeb4)) 0))
  Something ready to substitute:  eeb5 -> (+ (* (* (- 123) (exp 10 eeb2))
                                             (- 1))
                                          (* (* (- 1) eeb4) (- 1)));
  iter(2)= (= (+ eeb5 (* (- 123) (exp 10 eeb2)) (* (- 1) eeb4)) 0)
  Substitute eeb5 ~~> (+ (* (* (- 123) (exp 10 eeb2)) (- 1))
                      (* (* (- 1) eeb4) (- 1)))
  iter(3)= (= (+ (* (- 123) (exp 10 eeb2)) (* (- 1) eeb4)
              (* (* (- 123) (exp 10 eeb2)) (- 1)) (* (* (- 1) eeb4) (- 1))) 0)
  iter(4)= True
  sat ; under III
