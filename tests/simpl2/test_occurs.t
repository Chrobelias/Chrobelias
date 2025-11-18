  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl test3rec.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= (+ y x) 13)
             (= (+ x y) 13))
  Something ready to substitute
        x -> (+ 13 (- y));
  
  iter(2)= True
  sat (presimpl)

TODO: The test below could be simplified further
  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl test4rec.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= (+ z x) 10000)
             (= (+ y z) 100)
             (= (+ x y) 1))
  Something ready to substitute
        x -> (+ 1 (- y));
        z -> (+ 10000 (- x));
  
  iter(2)= (and
             (= (+ y z) 100))
  iter(3)= (= (+ y (* (- 1) x)) (- 9900))
  iter(4)= (= (+ y (* 1 (- 1)) (* (* (- 1) y) (- 1))) (- 9900))
  iter(5)= (= (+ y y) (- 9899))
  Interesting:
  
  Expecting 1 choices ...
  
  Can't decide in lib/Underapprox.ml
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
  Interesting:
  
  Expecting 1 choices ...
  
  Can't decide in lib/Underapprox.ml

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
  $ CHRO_DEBUG=1 Chro -bound 1 -pre-simpl   -stop-after pre-simpl 4.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (and
               (= (+ (+ it19 it23) (* (* (- 1) 1) i4)) (* (- 1) 1))
               (= (+ (+ (+ it21 it57) (* (* (- 1) 1) it21))
                  (* (* (- 1) 1) it57)) 0)))
  iter(2)= (and
             (= (+ it19 it23 (* (- 1) i4)) (- 1))
             (= (+ it21 it57 (* (- 1) it21) (* (- 1) it57)) 0))
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
  $ CHRO_DEBUG=1 Chro -bound 1 -pre-simpl   -stop-after pre-simpl 5.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= (+ (+ it19 (* it200 (* (- 1) 1))) z) 0)
             (= (+ (* it199 (* (- 1) 1)) it233) 0)
             (= (+ (+ (* it198 (* (- 1) 1)) it232) (* it19 (* (- 1) 3))) 0))
  Something ready to substitute
        it19 -> (+ it200 (- z));
        it232 -> (+ it198 (* 3 it19));
        it233 -> it199;
  
  iter(2)= True
  sat (presimpl)
