  $ CHRO_DEBUG=1 Chro --pre-simpl --dsimpl --stop-after pre-simpl test1.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (and
             (<= (+ 13 1) (+ (+ (* x 5) (* (exp 2 y) 8)) (* z 7)))
             (= (+ z y) 52)
             (<= (* x (+ 0 (* (- 1) 5))) 13))
  Something ready to substitute
        z -> (+ 52 (- y));
  
  iter(2)= (and
             (<= (+ (* (- 8) (exp 2 y)) (* (- 7) z) (* (- 5) x)) (- 14))
             (<= (* (- 5) x) 13))
  iter(3)= (and
             (<= (+ (* (- 8) (exp 2 y)) (* (- 5) x) (* 52 (- 7))
                 (* (* (- 1) y) (- 7))) (- 14))
             (<= (* (- 5) x) 13))
  iter(4)= (and
             (<= (+ (* (- 8) (exp 2 y)) (* (- 5) x) (* 7 y)) 350)
             (<= (* (- 5) x) 13))
  fixed-point
  
  Bound for underapproximation: 8
  
  Interesting: y
  
  Expecting 8 choices ...
  
  lib/Underapprox.ml gives early Sat.
  sat (under int)

  $ cat > testS1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (<= (* x (- 0 5)) 13))
  > (assert (= (+ z y) 52))
  > (assert (> (+ (* x 5) (* (pow2 y) 8) (* z 7) ) 13))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over -bound 0 --pre-simpl --dsimpl --stop-after pre-simpl testS1.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (and
             (<= (+ 13 1) (+ (+ (* x 5) (* (exp 2 y) 8)) (* z 7)))
             (= (+ z y) 52)
             (<= (* x (+ 0 (* (- 1) 5))) 13))
  Something ready to substitute
        z -> (+ 52 (- y));
  
  iter(2)= (and
             (<= (+ (* (- 8) (exp 2 y)) (* (- 7) z) (* (- 5) x)) (- 14))
             (<= (* (- 5) x) 13))
  iter(3)= (and
             (<= (+ (* (- 8) (exp 2 y)) (* (- 5) x) (* 52 (- 7))
                 (* (* (- 1) y) (- 7))) (- 14))
             (<= (* (- 5) x) 13))
  iter(4)= (and
             (<= (+ (* (- 8) (exp 2 y)) (* (- 5) x) (* 7 y)) 350)
             (<= (* (- 5) x) 13))
  fixed-point
  
  Bound for underapproximation: 8
  
  Interesting: y
  
  Expecting 8 choices ...
  
  lib/Underapprox.ml gives early Sat.
  sat (under int)
  $ cat > sum_join1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= (+ (* n (exp 2 n)) ;(* x (exp 2 n))
  >               (* (- 1) n (exp 2 n))
  >               )
  >            0))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over -bound 0 --pre-simpl --dsimpl --stop-after pre-simpl sum_join1.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (= (+ (* n (exp 2 n)) (* (* (- 1) 1) n (exp 2 n))) 0)
  iter(2)= True
  fixed-point
  
  sat (presimpl)
  $ cat > sum_join2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun n () Int)
  > (assert (not (= (+ (* (- 1) (exp 2 n)) (exp 2 n)) 0)) )
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over -bound 0 --pre-simpl --dsimpl --stop-after pre-simpl sum_join2.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (not (= (+ (* (* (- 1) 1) (exp 2 n)) (exp 2 n)) 0))
  iter(2)= (not True)
  fixed-point
  
  unsat (presimpl)
