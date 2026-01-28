  $ export CHRO_DEBUG=1
  $ cat > TODO1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (assert (<= (+ (* 5 x1) x2) (* 6 x2) ))
  > (check-sat)
  > EOF
  $ Chro --pre-simpl --dsimpl --stop-after pre-simpl TODO1.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (<= (+ (* 5 x1) x2) (* 6 x2))
  iter(2)= (<= (+ x2 (* 5 x1)) (* 6 x2))
  fixed-point
  
  Bound for underapproximation: 3
  
  Interesting:
  
  Expecting 1 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| x1->0 x2->0 |}
  sat (under I)
Should be (<= x 2)
  $ cat > TODO2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (assert (<= (* 5 x1) 13))
  > (check-sat)
  > EOF
  $ Chro --pre-simpl --dsimpl --stop-after pre-simpl TODO2.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (<= (* 5 x1) 13)
  iter(2)= (<= x1 2)
  fixed-point
  
  Bound for underapproximation: 2
  
  Interesting:
  
  Expecting 1 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| x1->0 |}
  sat (under I)


  $ cat > TODO2.smt2 <<-EOF
  > (set-logic ALL)
  > (assert (= (+ 2 6) 8))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro --pre-simpl --dsimpl --stop-after pre-simpl TODO2.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (= (+ 2 6) 8)
  iter(2)= True
  fixed-point
  
  sat (presimpl)


  $ cat > TODO2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (assert (<= (+ x1 (* (- 1) x1)) 8))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro --pre-simpl --dsimpl --stop-after pre-simpl TODO2.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (<= (+ x1 (* (* (- 1) 1) x1)) 8)
  iter(2)= True
  fixed-point
  
  sat (presimpl)

Fold exps
  $ cat > i3.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun it134 () Int)
  > (declare-fun it135 () Int)
  > (assert (<= (* (exp 2 (+ (- 1) it134)) (exp 2 (+ 1 it135) )) 2))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro --pre-simpl --dsimpl --stop-after pre-simpl i3.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (<= (* (exp 2 (+ (* (- 1) 1) it134)) (exp 2 (+ 1 it135))) 2)
  iter(2)= (<= (exp 2 (+ (+ (- 1) it134) (+ 1 it135))) 2)
  iter(3)= (<= (exp 2 (+ it134 it135)) 2)
  fixed-point
  
  Bound for underapproximation: 2
  
  Interesting: %flat_pow1
  
  Expecting 2 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| %flat_pow1->0 it134->0 it135->0 |}
  sat (under I)
  $ cat > i4.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (declare-fun x3 () Int)
  > (assert (<= (* (+ x1 x2) (exp 2 x3)) 2))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro --pre-simpl --dsimpl --stop-after pre-simpl i4.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (<= (* (+ x1 x2) (exp 2 x3)) 2)
  iter(2)= (<= (+ (* x1 (exp 2 x3)) (* x2 (exp 2 x3))) 2)
  fixed-point
  
  Bound for underapproximation: 2
  
  Interesting: x3
  
  Expecting 2 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| x1->0 x2->0 x3->0 |}
  sat (under I)

  $ cat > i3.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun it134 () Int)
  > (declare-fun it1095 () Int)
  > (assert (<= (* (exp 2 (+ (- 1) it134)) (exp 2 it134)) 2))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro --pre-simpl --dsimpl --stop-after pre-simpl i3.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (<= (* (exp 2 (+ (* (- 1) 1) it134)) (exp 2 it134)) 2)
  iter(2)= (<= (exp 2 (+ (+ (- 1) it134) it134)) 2)
  iter(3)= (<= (exp 2 (+ it134 it134)) 4)
  fixed-point
  
  Bound for underapproximation: 2
  
  Interesting: %flat_pow1
  
  Expecting 2 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| %flat_pow1->0 it134->0 |}
  sat (under I)


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
  $ CHRO_DEBUG=1 Chro --pre-simpl --dsimpl --stop-after pre-simpl it646.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (<= (+ (+ it646 (* (* (- 1) 2) it646)) (* (* (- 1) 1) it646))
           (* (- 1) 2))
  iter(2)= (<= (+ it646 (* (- 2) it646) (* (- 1) it646)) (- 2))
  iter(3)= (<= (+ it646 (* (- 3) it646)) (- 2))
  fixed-point
  
  Bound for underapproximation: 2
  
  Interesting:
  
  Expecting 1 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| it646->1 |}
  sat (under I)

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
  $ CHRO_DEBUG=1 Chro --pre-simpl --dsimpl --stop-after pre-simpl XXXX.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (= 0 (* (+ (* (- 1) 2) (* 3 i3)) (exp 2 it134)))
  iter(2)= (= (+ (* (- 1) (* 3 i3) (exp 2 it134)) (* 2 (exp 2 it134))) 0)
  iter(3)= (= (+ (* (- 3) i3 (exp 2 it134)) (* 2 (exp 2 it134))) 0)
  fixed-point
  
  Bound for underapproximation: 2
  
  Interesting: it134
  
  Expecting 2 choices ...
  
  Can't decide in lib/Underapprox.ml
  
  Non linear arithmetic between
  
  0) i3
  
  
  
  Into Z3 goes: (bool.eq
                 (int.add (int.mul (int.mul -3 i3) (int.pow 2 it134))
                  (int.mul 2 (int.pow 2 it134))) 0)
  
  unsat (nia)
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
  $ CHRO_DEBUG=1 Chro --pre-simpl --dsimpl --stop-after pre-simpl XXXX.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (and
             (= (+ (+ it376 (* (* (- 1) 3) it361)) (* 2 (exp it362 3))) 0)
             (= (* 0 it360) 0))
  Something ready to substitute
        it376 -> (+ (* (- 2) (exp it362 3)) (* 3 it361));
  
  iter(2)= True
  fixed-point
  
  sat (presimpl)
