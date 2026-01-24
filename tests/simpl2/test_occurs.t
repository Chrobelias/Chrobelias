  $ CHRO_DEBUG=1 Chro --pre-simpl --dsimpl --stop-after pre-simpl test3rec.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (and
             (= (+ y x) 13)
             (= (+ x y) 13))
  Something ready to substitute
        x -> (+ 13 (- y));
  
  iter(2)= True
  fixed-point
  
  sat (presimpl)

  $ CHRO_DEBUG=1 Chro --pre-simpl --dsimpl --stop-after pre-simpl test4rec.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (and
             (= (+ z x) 10000)
             (= (+ y z) 100)
             (= (+ x y) 1))
  Something ready to substitute
        x -> (+ 1 (- y));
  
  iter(2)= (and
             (= (+ x z) 10000)
             (= (+ y z) 100))
  Something ready to substitute
        x -> (+ 1 (- y));
        y -> (+ 100 (- z));
  
  iter(3)= (and
             (= (+ z (* (- 1) y)) 9999))
  iter(4)= (= (+ z (* 100 (- 1)) (* (* (- 1) z) (- 1))) 9999)
  iter(5)= (= (+ z z) 10099)
  fixed-point
  
  Bound for underapproximation: 13
  
  Interesting:
  
  Expecting 1 choices ...
  
  unsat (nia)
  $ cat > xxx.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun y () Int)
  > (assert (= (+ y y) (- 9899)) )
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -bound 1 --pre-simpl --stop-after pre-simpl xxx.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (= (+ y y) (* (- 1) 9899))
  iter(2)= (= (+ y y) (- 9899))
  fixed-point
  
  Bound for underapproximation: 13
  
  Interesting:
  
  Expecting 1 choices ...
  
  unsat (nia)

  $ cat > 4.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun a () Int)
  > (declare-fun v () Int)
  > (declare-fun x () Int)
  > (declare-fun z () Int)
  > (assert (and
  >           (= (+ it19 it23 (* (- 1) i4)) (- 1))
  >           (= (+ it21 it57 (* (- 1) it21) (* (- 1) it57)) 0)
  > ))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -bound 1 --pre-simpl --stop-after pre-simpl 4.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (and
             (= (+ (+ it19 it23) (* (* (- 1) 1) i4)) (* (- 1) 1))
             (= (+ (+ (+ it21 it57) (* (* (- 1) 1) it21)) (* (* (- 1) 1) it57)) 0))
  iter(2)= (and
             (= (+ it19 it23 (* (- 1) i4)) (- 1))
             (= (+ it21 it57 (* (- 1) it21) (* (- 1) it57)) 0))
  fixed-point
  
  Bound for underapproximation: 2
  
  Interesting:
  
  Expecting 1 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| i4->0 it19->-1 it21->0 it23->0 it57->0 |}
  sat (under I)

  $ cat > 5.smt2 <<-EOF
  > (set-logic ALL)
  > ;(declare-fun a () Int)
  > ;(declare-fun v () Int)
  > ;(declare-fun x () Int)
  > (declare-fun z () Int)
  > (assert
  >   (= (+ (* it198 (- 1)) it232 (* it19 (- 3))) 0) )
  > (assert
  >   (= (+ (* it199 (- 1)) it233) 0))
  > (assert
  >   (= (+ it19 (* it200 (- 1)) z) 0))
  > 
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -bound 1 --pre-simpl --stop-after pre-simpl 5.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (and
             (= (+ (+ it19 (* it200 (* (- 1) 1))) z) 0)
             (= (+ (* it199 (* (- 1) 1)) it233) 0)
             (= (+ (+ (* it198 (* (- 1) 1)) it232) (* it19 (* (- 1) 3))) 0))
  Something ready to substitute
        it19 -> (+ it200 (- z));
  
  iter(2)= (and
             (= (+ it232 (* (- 3) it19) (* (- 1) it198)) 0)
             (= (+ it233 (* (- 1) it199)) 0))
  Something ready to substitute
        it19 -> (+ it200 (- z));
        it232 -> (+ it198 (* (- 3) z) (* 3 it200));
  
  iter(3)= (and
             (= (+ it233 (* (- 1) it199)) 0))
  Something ready to substitute
        it19 -> (+ it200 (- z));
        it232 -> (+ it198 (* (- 3) z) (* 3 it200));
        it233 -> it199;
  
  iter(4)= True
  fixed-point
  
  sat (presimpl)
