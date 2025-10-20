  $ export CHRO_DEBUG=1
  $ cat > 1.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x String)
  > (declare-const y String)
  > (assert (= (str.++ "123" x) (str.++ y x)))
  > (assert (= y "321"))
  > (check-sat)
  > EOF

  $ Chro -pre-simpl -stop-after simpl 1.smt2 -flat 1 -amin 2 -amax 2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= y "321")
             (= (str.++ "123" x) (str.++ y x)))
  Something ready to substitute:  y ->s "321";
  iter(2)= (and
             (= y "321")
             (= (str.++ "123" x) (str.++ y x)))
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
  Something ready to substitute:  eeb3 -> 123; eeb6 -> eeb2; eeb7 -> 321;
  iter(2)= (and
             (= eeb1 (+ eeb4 (* eeb3 (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb3 123)
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6))))
             (= eeb6 eeb2)
             (= eeb6 (str.len x))
             (= eeb7 321)
             (= eeb8 (str.to.int x))
             (= eeb1 eeb5))
  Something ready to substitute:  eeb1 ->s eeb5; eeb3 -> 123; eeb6 -> eeb2; eeb7 ->
                                 321;
  iter(3)= (and
             (= eeb1 (+ eeb4 (* 123 (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* 321 (exp 10 eeb2))))
             (= eeb8 (str.to.int x))
             (= eeb1 eeb5))
  iter(4)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 123 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (* 321 (exp 10 eeb2))))
             (= eeb8 (str.to.int x)))
  vars_for_under2:
  
  all as: 2
  
  iter(1)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 123 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (* 321 (exp 10 eeb2))))
             (= eeb8 (str.to.int x)))
  (= (str.++ "123" x) (str.++ "321" x))
  Looking for SAT in 1 asts...
  Simplify step: ((= eeb2 (str.len x)) & (= eeb4 (str.to.int x)) & (= eeb5
  (+ eeb4 (* 123 (exp 10 eeb2)))) & (= eeb5 (+ eeb8 (* 321 (exp 10 eeb2)))) & (= eeb8 (str.to.int x)))
  Simplified expression: (and
                           (= eeb2 (str.len x))
                           (= eeb4 (str.to.int x))
                           (= eeb5 (+ eeb4 (* 123 (exp 10 eeb2))))
                           (= eeb5 (+ eeb8 (* 321 (exp 10 eeb2))))
                           (= eeb8 (str.to.int x)))
  iter(1)= (and
             (and
               (= (+ (* 1 eeb2) (* (- 1) %0)) 0)
               (= %1 (chrob.len x))
               (= (+ (* 1 (exp 10 %0)) (* (- 1) %1)) 1))
             (and
               (= (+ (* (- 1) x) (* 1 eeb4)) 0))
             (and
               (= (+ (* (- 123) (exp 10 eeb2)) (* 1 eeb5) (* (- 1) eeb4)) 0))
             (and
               (= (+ (* (- 321) (exp 10 eeb2)) (* (- 1) eeb8) (* 1 eeb5)) 0))
             (and
               (= (+ (* (- 1) x) (* 1 eeb8)) 0)))
  iter(2)= (and
             (= %1 (chrob.len x))
             (= (+ eeb2 (* (- 1) %0)) 0)
             (= (+ eeb4 (* (- 1) x)) 0)
             (= (+ eeb5 (* (- 321) (exp 10 eeb2)) (* (- 1) eeb8)) 0)
             (= (+ eeb5 (* (- 123) (exp 10 eeb2)) (* (- 1) eeb4)) 0)
             (= (+ eeb8 (* (- 1) x)) 0)
             (= (+ (* (- 1) %1) (exp 10 %0)) 1))
  Something ready to substitute:  eeb2 -> %0; eeb4 -> x; eeb5 -> (+ (*
                                                                    (* (- 321)
                                                                    (exp 10 %0))
                                                                    (- 1))
                                                                 (* (* (- 1)
                                                                    eeb8)
                                                                 (- 1))); eeb8 ->
                                 x;
  iter(3)= (and
             (= %1 (chrob.len x))
             (= (+ eeb2 (* (- 1) %0)) 0)
             (= (+ eeb4 (* (- 1) x)) 0)
             (= (+ eeb5 (* (- 321) (exp 10 eeb2)) (* (- 1) eeb8)) 0)
             (= (+ eeb5 (* (- 123) (exp 10 eeb2)) (* (- 1) eeb4)) 0)
             (= (+ eeb8 (* (- 1) x)) 0)
             (= (+ (* (- 1) %1) (exp 10 %0)) 1))
  iter(4)= (and
             (= %1 (chrob.len x))
             (= (+ (* (- 321) (exp 10 %0)) (* (- 1) x)
                (* (* (- 321) (exp 10 %0)) (- 1)) (* (* (- 1) eeb8) (- 1))) 0)
             (= (+ (* (- 123) (exp 10 %0)) (* (- 1) x)
                (* (* (- 321) (exp 10 %0)) (- 1)) (* (* (- 1) eeb8) (- 1))) 0)
             (= (+ (* (- 1) %1) (exp 10 %0)) 1))
  iter(5)= (and
             (= %1 (chrob.len x))
             (= (+ (* (- 1) %1) (exp 10 %0)) 1)
             (= (* 198 (exp 10 %0)) 0))
  Simplify step: ((= %1 (chrob.len x)) & (= (+ (* (- 1) %1) (exp 10 %0)) 1) & (=
  (* 198 (exp 10 %0)) 0))
  Simplified expression: (and
                           (= %1 (chrob.len x))
                           (= (+ (* (- 1) %1) (exp 10 %0)) 1)
                           (= (* 198 (exp 10 %0)) 0))
  (assert (exists (%1)
          (and
            (exists (x) (= %1 (chrob.len x)))
            (= (+ (* (- 1) %1) pow2(%0) )  1)
            (= (* 198 pow2(%0))  0)
            )
  )
