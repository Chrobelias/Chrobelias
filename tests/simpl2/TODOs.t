  $ export CHRO_DEBUG=simpl
  $ cat > TODO1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (assert (<= (+ (* 5 x1) x2) (* 6 x2) ))
  > (check-sat)
  > EOF
  $ Chro --dsimpl --stop-after pre-simpl TODO1.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (<= (+ (* 5 x1) x2 (* (- 6) x2)) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= (<= (+ (* 5 x1) (* (- 5) x2)) 0)
  [+simpl]
    fixed-point
  
Should be (<= x 2)
  $ cat > TODO2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (assert (<= (* 5 x1) 13))
  > (check-sat)
  > EOF
  $ Chro  --dsimpl --stop-after pre-simpl TODO2.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (<= (+ (- 13) (* 5 x1)) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    fixed-point
  


  $ cat > TODO2.smt2 <<-EOF
  > (set-logic ALL)
  > (assert (= (+ 2 6) 8))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=simpl Chro  --dsimpl --stop-after pre-simpl TODO2.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= True
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    fixed-point
  
  sat (presimpl int)


  $ cat > TODO2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (assert (<= (+ x1 (* (- 1) x1)) 8))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=simpl Chro  --dsimpl --stop-after pre-simpl TODO2.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (<= (+ (- 8) x1 (* (- 1) x1)) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= True
  [+simpl]
    fixed-point
  
  sat (presimpl int)

Fold exps
  $ cat > i3.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun it134 () Int)
  > (declare-fun it135 () Int)
  > (assert (<= (* (exp 2 (+ (- 1) it134)) (exp 2 (+ 1 it135) )) 2))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=simpl Chro  --dsimpl --stop-after pre-simpl i3.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (<= (+ (- 2) (* (exp 2 (+ (- 1) it134)) (exp 2 (+ 1 it135)))) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= (<= (+ (- 2) (exp 2 (+ it134 it135))) 0)
  [+simpl]
    fixed-point
  
  $ cat > i4.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (declare-fun x3 () Int)
  > (assert (<= (* (+ x1 x2) (exp 2 x3)) 2))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=simpl Chro  --dsimpl --stop-after pre-simpl i4.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (<= (+ (- 2) (* (+ x1 x2) (exp 2 x3))) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= (<= (+ (- 2) (* x1 (exp 2 x3)) (* x2 (exp 2 x3))) 0)
  [+simpl]
    fixed-point
  

  $ cat > i3.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun it134 () Int)
  > (declare-fun it1095 () Int)
  > (assert (<= (* (exp 2 (+ (- 1) it134)) (exp 2 it134)) 2))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=simpl Chro  --dsimpl --stop-after pre-simpl i3.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (<= (+ (- 2) (* (exp 2 (+ (- 1) it134)) (exp 2 it134))) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= (<= (+ (- 2) (exp 2 (+ (- 1) it134 it134))) 0)
  [+simpl]
    iter(3)= (<= (+ (- 2) (exp 2 (+ (- 1) (* 2 it134)))) 0)
  [+simpl]
    fixed-point
  


$ CHRO_DEBUG=simpl Chro -pre-simpl -dsimpl -stop-after pre-simpl hack1.smt2 | sed 's/[[:space:]]*$//'

  $ cat > it646.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun it646 () Int)
  > (assert (<= (+ it646
  >                (* (- 2) it646)
  >                (* (- 1) it646))
  >             (- 2)) )
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=simpl Chro  --dsimpl --stop-after pre-simpl it646.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (<= (+ 2 it646 (* (- 2) it646) (* (- 1) it646)) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= (<= (+ 2 (* (- 2) it646)) 0)
  [+simpl]
    fixed-point
  

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
  $ CHRO_DEBUG=simpl Chro  --dsimpl --stop-after pre-simpl XXXX.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (= (* (- 1) (+ (- 2) (* 3 i3)) (exp 2 it134)) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= (= (+ (* (* (- 2) (exp 2 it134)) (- 1))
              (* (* (* 3 i3) (exp 2 it134)) (- 1))) 0)
  [+simpl]
    iter(3)= (= (+ (* (- 3) i3 (exp 2 it134)) (* 2 (exp 2 it134))) 0)
  [+simpl]
    fixed-point
  
  $ cat > XXXX.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun it360 () Int)
  > (declare-fun it361 () Int)
  > (declare-fun it362 () Int)
  > (declare-fun it376 () Int)
  > (assert (and
  >    (= (+ it376 (* (- 3) it361) (* 2 (exp it362 3))) 0)
  >    (= (* 0 it360) 0)
  > ))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=simpl Chro  --dsimpl --stop-after pre-simpl XXXX.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (= (+ it376 (* (- 3) it361) (* 2 (exp it362 3))) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        it376 -> (+ (* 3 it361) (* (- 2) (exp it362 3)));
        
  [+simpl]
    iter(3)= True
  [+simpl]
    fixed-point
  
  sat (presimpl int)
