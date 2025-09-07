  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl test3rec.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= (+ y x) 13)
             (= (+ x y) 13))
  Something ready to substitute:  y -> (+ 13 (* (- 1) x));
  iter(2)= (= (+ x y) 13)
  iter(3)= (= 0 0)
  iter(4)= True
  sat ()

  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl test4rec.smt2 | sed 's/[[:space:]]*$//'
  Something weird: no errors. lib/SimplII.ml 887
  iter(1)= (and
             (= (+ z x) 10000)
             (= (+ y z) 100)
             (= (+ x y) 1))
  Something ready to substitute:  x -> (+ 1 (* (- 1) y)); z -> (+ 10000
                                                               (* (- 1) x));
  iter(2)= (and
             (= (+ x y) 1)
             (= (+ x z) 10000)
             (= (+ y z) 100))
  iter(3)= (and
             (= 0 0)
             (= (+ y (* (- 1) x)) (- 9900))
             (= (+ (* (- 1) x) (* (- 1) y)) (- 1)))
  iter(4)= (and
             (= (+ y (* 1 (- 1)) (* (* (- 1) y) (- 1))) (- 9900))
             (= (+ (* (- 1) y) (* 1 (- 1)) (* (* (- 1) y) (- 1))) (- 1)))
  iter(5)= (and
             (= 0 0)
             (= (+ y y) (- 9899)))
  iter(6)= (and
             (= (+ y y) (- 9899)))
  iter(7)= (= (+ y y) (- 9899))
  iter(7.0)= (and
               (= 0 0)
               (= (+ y (* (- 1) x)) (- 9900))
               (= (+ (* (- 1) x) (* (- 1) y)) (- 1)))
  iter(7.1)= (and
               (= (+ y (* 1 (- 1)) (* (* (- 1) y) (- 1))) (- 9900))
               (= (+ (* (- 1) y) (* 1 (- 1)) (* (* (- 1) y) (- 1))) (- 1)))
  iter(7.2)= (and
               (= 0 0)
               (= (+ y y) (- 9899)))
  iter(7.3)= (and
               (= (+ y y) (- 9899)))
  iter(7.4)= (= (+ y y) (- 9899))
  1 errors found
  Non linear arithmetic between
    0) (* (- 1) y)
  
  Leftover formula:
  (and
                      (= (+ y y) (- 9899)))
  
  UNKNOWN (Errors after simplification)
  $ cat > xxx.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun y () Int)
  > (assert (= (+ y y) (- 9899)) )
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -bound 1 -pre-simpl   -stop-after pre-simpl xxx.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= (+ y y) (* (- 1) 9899)))
  iter(2)= (= (+ y y) (- 9899))
  iter(2.0)= (= (+ y y) (- 9899))
