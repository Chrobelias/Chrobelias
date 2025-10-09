  $ export CHRO_DEBUG=1
  $ cat > TODO1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (assert (<= (+ (* 5 x1) x2) (* 6 x2) ))
  > (check-sat)
  > EOF
  $ Chro -pre-simpl -dsimpl -stop-after pre-simpl TODO1.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (<= (+ (* 5 x1) x2) (* 6 x2)))
  iter(2)= (<= (+ x2 (* 5 x1)) (* 6 x2))
  Interesting:
  
  Expecting 1 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| x1->0 x2->0 |}
  sat ; underapprox1
Should be (<= x 2)
  $ cat > TODO2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (assert (<= (* 5 x1) 13))
  > (check-sat)
  > EOF
  $ Chro -pre-simpl -dsimpl -stop-after pre-simpl TODO2.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (<= (* 5 x1) 13))
  iter(2)= (<= x1 2)
  Interesting:
  
  Expecting 1 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| x1->0 |}
  sat ; underapprox1


  $ cat > TODO2.smt2 <<-EOF
  > (set-logic ALL)
  > (assert (= (+ 2 6) 8))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl TODO2.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= (+ 2 6) 8))
  iter(2)= True
  sat ; presimpl


  $ cat > TODO2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (assert (<= (+ x1 (* (- 1) x1)) 8))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl TODO2.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (<= (+ x1 (* (* (- 1) 1) x1)) 8))
  iter(2)= True
  sat ; presimpl

Fold exps
  $ cat > i3.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun it134 () Int)
  > (declare-fun it135 () Int)
  > (assert (<= (* (exp 2 (+ (- 1) it134)) (exp 2 (+ 1 it135) )) 2))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl i3.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (<= (* (exp 2 (+ (* (- 1) 1) it134)) (exp 2 (+ 1 it135))) 2))
  iter(2)= (<= (exp 2 (+ (+ (- 1) it134) (+ 1 it135))) 2)
  iter(3)= (<= (exp 2 (+ it134 it135)) 2)
  Interesting:
  
  Expecting 1 choices ...
  
  Can't decide in lib/Underapprox.ml
  $ cat > i4.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (declare-fun x3 () Int)
  > (assert (<= (* (+ x1 x2) (exp 2 x3)) 2))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl i4.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (<= (* (+ x1 x2) (exp 2 x3)) 2))
  iter(2)= (<= (+ (* x1 (exp 2 x3)) (* x2 (exp 2 x3))) 2)
  Interesting: x3
  
  Expecting 2 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| x1->0 x2->0 x3->0 |}
  sat ; underapprox1

  $ cat > i3.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun it134 () Int)
  > (declare-fun it1095 () Int)
  > (assert (<= (* (exp 2 (+ (- 1) it134)) (exp 2 it134)) 2))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl i3.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (<= (* (exp 2 (+ (* (- 1) 1) it134)) (exp 2 it134)) 2))
  iter(2)= (<= (exp 2 (+ (+ (- 1) it134) it134)) 2)
  iter(3)= (<= (exp 2 (+ it134 it134)) 4)
  Interesting:
  
  Expecting 1 choices ...
  
  Can't decide in lib/Underapprox.ml


$ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl hack1.smt2 | sed 's/[[:space:]]*$//'

  $ cat > it646.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun it646 () Int)
  > (assert (<= (+ it646
  >                (* (- 2) it646)
  >                (* (- 1) it646))
  >             (- 2)) )
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl it646.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (<= (+ (+ it646 (* (* (- 1) 2) it646)) (* (* (- 1) 1) it646))
             (* (- 1) 2)))
  iter(2)= (<= (+ it646 (* (- 2) it646) (* (- 1) it646)) (- 2))
  iter(3)= (<= (+ it646 (* (- 3) it646)) (- 2))
  Interesting:
  
  Expecting 1 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| it646->1 |}
  sat ; underapprox1

  $ cat > XXXX.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun i3 () Int)
  > (declare-fun it134 () Int)
  > (declare-fun it1110 () Int)
  > (assert (= 0  (*
  >                  (+ (- 2) (* 3 i3))
  >                  (exp 2 it134)
  > )))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl XXXX.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= 0 (* (+ (* (- 1) 2) (* 3 i3)) (exp 2 it134))))
  iter(2)= (= (+ (* (- 1) (* 3 i3) (exp 2 it134)) (* 2 (exp 2 it134))) 0)
  iter(3)= (= (+ (* (- 3) i3 (exp 2 it134)) (* 2 (exp 2 it134))) 0)
  Interesting: it134
  
  Expecting 2 choices ...
  
  Can't decide in lib/Underapprox.ml
  $ cat > XXXX.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun i3 () Int)
  > (declare-fun it134 () Int)
  > (declare-fun it1110 () Int)
  > (assert (and
  >    (= (+ it376 (* (- 3) it361) (* 2 (exp it362 3))) 0)
  >    (= (* 0 it360) 0)
  > ))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl XXXX.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (and
               (= (+ (+ it376 (* (* (- 1) 3) it361)) (* 2 (exp it362 3))) 0)
               (= (* 0 it360) 0)))
  iter(2)= (= (+ it376 (* (- 3) it361) (* 2 (exp it362 3))) 0)
  Something ready to substitute:  it376 -> (+ (* (* (- 3) it361) (- 1))
                                           (* (* 2 (exp it362 3)) (- 1)));
  iter(3)= (= (+ it376 (* (- 3) it361) (* 2 (exp it362 3))) 0)
  iter(4)= (= (+ (* (- 3) it361) (* 2 (exp it362 3)) (* (* (- 3) it361) (- 1))
              (* (* 2 (exp it362 3)) (- 1))) 0)
  iter(5)= True
  sat ; presimpl
